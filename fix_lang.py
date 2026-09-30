import codecs, re

with codecs.open('lib/widgets/language_selector.dart', 'r', 'utf-8') as f:
    content = f.read()

# Add import
if "import 'package:cesc_commerce/core/localization.dart';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:cesc_commerce/core/localization.dart';")

# Update state
content = re.sub(
    r"String _selectedLanguage = 'EN \(US\)';",
    "",
    content
)

content = content.replace("setState(() {\n\n            _selectedLanguage = value;\n\n          });", "globalLanguage.value = value;")
content = content.replace("_selectedLanguage", "globalLanguage.value")

# To make it rebuild when globalLanguage changes, we can wrap the Container in ValueListenableBuilder
content = re.sub(
    r"Widget build\(BuildContext context\) \{\n\n    return Container\(",
    "Widget build(BuildContext context) {\n    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, lang, child) {\n        return Container(",
    content
)

content = re.sub(
    r"      \),\n\n    \);\n\n  \}\n\n\}",
    "      ),\n    );\n      }\n    );\n  }\n}",
    content
)

with codecs.open('lib/widgets/language_selector.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
