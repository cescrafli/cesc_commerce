import codecs, re

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

if "import 'package:cesc_commerce/core/localization.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cesc_commerce/core/localization.dart';")

content = re.sub(
    r"return Scaffold\(",
    "return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, lang, _) {\n        return Scaffold(",
    content
)

content = content.replace("'Search for clothes...'", "tr('search_hint')")
content = content.replace("'Categories'", "tr('categories')")
content = content.replace("'Popular Deals'", "tr('popular_deals')")
content = content.replace("'New Arrivals'", "tr('new_arrivals')")
content = content.replace("'See All'", "tr('see_all')")

content = re.sub(r"\);\n\n  \}\n\n\}", ");\n      }\n    );\n  }\n}", content)

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
