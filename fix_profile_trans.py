import codecs, re

with codecs.open('lib/screens/profile/profile_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

if "import 'package:cesc_commerce/core/localization.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cesc_commerce/core/localization.dart';")

# Wrap Scaffold in ValueListenableBuilder
if "ValueListenableBuilder<String>" not in content:
    content = re.sub(
        r"return Scaffold\(",
        "return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, lang, _) {\n        return Scaffold(",
        content
    )
    # Scaffold closes at the very end of the file.
    content = re.sub(r"    \);\n  \}\n\}", "    );\n      }\n    );\n  }\n}", content)

content = content.replace("'Profile'", "tr('profile')")
content = content.replace("'My Orders'", "tr('my_orders')")
content = content.replace("'Settings'", "tr('settings')")
content = content.replace("'Notifications'", "tr('notifications')")
content = content.replace("'Help & Support'", "tr('help_support')")
content = content.replace("'Logout'", "tr('logout')")

with codecs.open('lib/screens/profile/profile_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Profile fixed")
