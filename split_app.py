import os
import re
import codecs

# 1. Setup directories
dirs = [
    'lib/core',
    'lib/widgets',
    'lib/screens/auth',
    'lib/screens/home',
    'lib/screens/product',
    'lib/screens/cart',
    'lib/screens/profile',
    'lib/screens/misc'
]
for d in dirs:
    os.makedirs(d, exist_ok=True)

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# To safely parse classes, we'll scan for `class Name ` or `class _NameState `
# and use brace counting to extract the entire block.
# We also want to extract globals.

# We will just use regex to find the start of blocks.
# But wait, we can just split by "class " and then fix it up!
# Actually, iterating and tracking braces is much safer.

def get_blocks(text):
    blocks = []
    idx = 0
    while idx < len(text):
        # Look for the next class, void function, or final ValueNotifier
        m = re.search(r'\b(class \w+|void \w+\(|final ValueNotifier<\w+(?:<[^>]+>)?(?:<[^>]+>)?> \w+\s*=)\b', text[idx:])
        if not m:
            break
        
        start = idx + m.start()
        
        if text[start:start+4] == 'void' and 'void main(' in m.group(1):
            # Skip main
            idx = start + len(m.group(1))
            continue
            
        # Find the opening brace or semicolon (for ValueNotifiers sometimes they are one liners, but here they have blocks)
        # ValueNotifiers in this app are initialized with `ValueNotifier([ ... ]);`
        brace_start = text.find('{', start)
        semi_start = text.find(';', start)
        
        if m.group(1).startswith('final ValueNotifier'):
            # It ends at the first semicolon where bracket count is 0
            curr = start
            b_count = 0
            p_count = 0
            while curr < len(text):
                c = text[curr]
                if c == '[': b_count += 1
                elif c == ']': b_count -= 1
                elif c == '(': p_count += 1
                elif c == ')': p_count -= 1
                elif c == ';' and b_count == 0 and p_count == 0:
                    break
                curr += 1
            end = curr + 1
            blocks.append(('GLOBAL', text[start:end]))
            idx = end
            continue
            
        elif m.group(1).startswith('void '):
            # Find the opening brace of the function
            curr = start
            brace_count = 0
            while curr < len(text) and text[curr] != '{':
                curr += 1
            
            if curr == len(text): break
            brace_count = 1
            curr += 1
            while curr < len(text) and brace_count > 0:
                if text[curr] == '{': brace_count += 1
                elif text[curr] == '}': brace_count -= 1
                curr += 1
            end = curr
            blocks.append(('FUNC', text[start:end]))
            idx = end
            continue
            
        elif m.group(1).startswith('class '):
            class_name = m.group(1).split()[1]
            curr = start
            while curr < len(text) and text[curr] != '{':
                curr += 1
            
            if curr == len(text): break
            brace_count = 1
            curr += 1
            while curr < len(text) and brace_count > 0:
                if text[curr] == '{': brace_count += 1
                elif text[curr] == '}': brace_count -= 1
                curr += 1
            end = curr
            blocks.append(('CLASS', class_name, text[start:end]))
            idx = end
            continue
            
    return blocks

blocks = get_blocks(content)
print(f"Extracted {len(blocks)} blocks")

# Group states with their stateful widgets
classes = {}
state_classes = {}
for b in blocks:
    if b[0] == 'CLASS':
        name = b[1]
        if name.startswith('_') and name.endswith('State'):
            state_classes[name] = b[2]
        elif name != 'MyApp':
            classes[name] = b[2]

globals_code = []
for b in blocks:
    if b[0] == 'GLOBAL' or b[0] == 'FUNC':
        globals_code.append(b[1])

# Route files
def camel_to_snake(name):
    s1 = re.sub('(.)([A-Z][a-z]+)', r'\1_\2', name)
    return re.sub('([a-z0-9])([A-Z])', r'\1_\2', s1).lower()

files = {}
for name, code in classes.items():
    snake = camel_to_snake(name)
    state_name = f"_{name}State"
    full_code = code
    if state_name in state_classes:
        full_code += "\n\n" + state_classes[state_name]
        
    # Decide folder
    folder = 'lib/screens/misc'
    if 'Screen' in name:
        if name in ['LoginScreen', 'SignUpScreen', 'ForgotPasswordScreen', 'PersonalInfoScreen']:
            folder = 'lib/screens/auth'
        elif name in ['HomeScreen', 'MainNavigationScreen', 'SearchScreen']:
            folder = 'lib/screens/home'
        elif name in ['ProductDetailScreen', 'CategoryListScreen', 'CategoryProductsScreen', 'FavoriteScreen', 'WriteReviewScreen']:
            folder = 'lib/screens/product'
        elif name in ['CartScreen', 'CheckoutScreen', 'PaymentScreen', 'AddressScreen', 'AddNewAddressScreen', 'EditAddressScreen', 'OrderSuccessScreen', 'TrackingScreen', 'AddNewCardScreen', 'ApplePayScreen', 'PayPalScreen', 'CODScreen', 'EditBagScreen']:
            folder = 'lib/screens/cart'
        elif name in ['ProfileScreen', 'SettingsScreen', 'MyOrdersScreen', 'OrderTrackingScreen', 'OrderTrackingLiveScreen', 'CustomerSupportChatScreen', 'NotificationScreen', 'NotificationsScreen', 'HelpSupportScreen', 'NewsDetailScreen']:
            folder = 'lib/screens/profile'
    else:
        # It's a widget or splash screen
        if name == 'SplashScreen' or name == 'OnboardingScreen':
            folder = 'lib/screens/misc'
        else:
            folder = 'lib/widgets'
            
    filepath = f"{folder}/{snake}.dart"
    files[filepath] = full_code

# Standard imports
imports = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

"""

# Write files
for filepath, code in files.items():
    with codecs.open(filepath, 'w', 'utf-8') as f:
        f.write(imports + code + '\n')

with codecs.open('lib/core/globals.dart', 'w', 'utf-8') as f:
    f.write("import 'package:flutter/material.dart';\n\n")
    f.write("\n\n".join(globals_code))

# Write barrel files
screens_exports = []
widgets_exports = []
for filepath in files.keys():
    export_path = filepath.replace('lib/', '')
    if filepath.startswith('lib/screens'):
        screens_exports.append(f"export '{export_path}';")
    elif filepath.startswith('lib/widgets'):
        widgets_exports.append(f"export '{export_path}';")

with codecs.open('lib/screens.dart', 'w', 'utf-8') as f:
    f.write("\n".join(screens_exports) + "\n")

with codecs.open('lib/widgets.dart', 'w', 'utf-8') as f:
    f.write("\n".join(widgets_exports) + "\n")

# Re-write main.dart
main_imports = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/screens.dart';
"""

# Extract main() and MyApp
main_code = ""
main_idx = content.find('void main(')
if main_idx != -1:
    brace_count = 1
    curr = content.find('{', main_idx) + 1
    while curr < len(content) and brace_count > 0:
        if content[curr] == '{': brace_count += 1
        elif content[curr] == '}': brace_count -= 1
        curr += 1
    main_code = content[main_idx:curr]

myapp_code = classes.get('MyApp', '')

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(main_imports + "\n" + main_code + "\n\n" + myapp_code + "\n")

print(f"Split {len(files)} files successfully!")
