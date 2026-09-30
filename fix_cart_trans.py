import codecs, re

with codecs.open('lib/screens/cart/cart_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

if "import 'package:cesc_commerce/core/localization.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cesc_commerce/core/localization.dart';")

if "ValueListenableBuilder<String>" not in content:
    content = re.sub(
        r"return Scaffold\(",
        "return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, lang, _) {\n        return Scaffold(",
        content
    )
    content = re.sub(r"    \);\n  \}\n\}", "    );\n      }\n    );\n  }\n}", content)

content = content.replace("'Shopping Cart'", "tr('shopping_cart')")
content = content.replace("'Your cart is empty'", "tr('empty_cart')")
content = content.replace("'Checkout'", "tr('checkout')")

with codecs.open('lib/screens/cart/cart_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Cart fixed")
