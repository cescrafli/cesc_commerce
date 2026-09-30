import os, codecs, re

# 1. lib/main.dart
with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    main_dart = f.read()
main_dart = "import 'package:firebase_core/firebase_core.dart';\n" + main_dart
main_dart = main_dart.replace("import 'package:cesc_commerce/screens.dart';", "import 'package:cesc_commerce/screens.dart';\nimport 'package:cesc_commerce/widgets.dart';")
with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(main_dart)

# 2. add_new_card_screen.dart & payment_screen.dart & onboarding_screen.dart & edit_bag_screen.dart
for file in ['lib/screens/cart/add_new_card_screen.dart', 'lib/screens/cart/payment_screen.dart', 'lib/screens/misc/onboarding_screen.dart', 'lib/screens/cart/edit_bag_screen.dart']:
    if not os.path.exists(file): continue
    with codecs.open(file, 'r', 'utf-8') as f:
        content = f.read()
    
    # inject total/shipping
    content = content.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context) {\n    double total = 0.0;\n    double shipping = 0.0;")
    
    with codecs.open(file, 'w', 'utf-8') as f:
        f.write(content)

# 3. checkout_screen.dart
with codecs.open('lib/screens/cart/checkout_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context) {\n    double subtotal = 0.0; for (var i in widget.items) { subtotal += i['price'] * i['qty']; }\n    double shipping = 0.0;\n    double discount = 0.0;\n    double total = subtotal + shipping - discount;")
with codecs.open('lib/screens/cart/checkout_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 4. edit_address_screen.dart
with codecs.open('lib/screens/cart/edit_address_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("const TextField(controller", "TextField(controller")
with codecs.open('lib/screens/cart/edit_address_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 5. add_new_address_screen.dart
with codecs.open('lib/screens/cart/add_new_address_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
# Fix duplicates
content = re.sub(r'int selectedLabel = 0; // 0: Home, 1: Office, 2: Parents\s*bool isDefault = true;\s*bool isEco = true;', '', content, count=1)
# Fix backslashes
content = content.replace("\\'", "'")
# Fix const TextField
content = content.replace("const TextField(controller", "TextField(controller")
with codecs.open('lib/screens/cart/add_new_address_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 6. product_detail_screen.dart
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("replaceAll('$', '')", "replaceAll(r'$', '')")
with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 7. cart_screen.dart
with codecs.open('lib/screens/cart/cart_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("'\\$$${totalPrice", "'\\$${totalPrice")
with codecs.open('lib/screens/cart/cart_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 8. auth screens
for file in ['lib/screens/auth/sign_up_screen.dart', 'lib/screens/auth/login_screen.dart']:
    with codecs.open(file, 'r', 'utf-8') as f:
        content = f.read()
    content = "import 'package:cesc_commerce/core/services/auth_service.dart';\n" + content
    with codecs.open(file, 'w', 'utf-8') as f:
        f.write(content)

print("Mass fix completed!")
