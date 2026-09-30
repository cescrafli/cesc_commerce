import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
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

content = content.replace("'Wishlist'", "tr('wishlist')")
content = content.replace("'Your wishlist is empty'", "tr('empty_wishlist')")
content = content.replace("'Add All to Cart'", "tr('add_all_to_cart')")

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Favorite fixed")
