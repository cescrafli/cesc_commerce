import codecs

def replace_import(filepath, relative_path):
    with codecs.open(filepath, 'r', 'utf-8') as f:
        content = f.read()
    content = content.replace("import 'package:cesc_commerce/core/localization.dart';", f"import '{relative_path}';")
    with codecs.open(filepath, 'w', 'utf-8') as f:
        f.write(content)

replace_import('lib/widgets/language_selector.dart', '../core/localization.dart')
replace_import('lib/screens/home/main_navigation_screen.dart', '../../core/localization.dart')
replace_import('lib/screens/home/home_screen.dart', '../../core/localization.dart')
print("Imports fixed")
