import codecs

for path in ['lib/screens/auth/login_screen.dart', 'lib/screens/auth/sign_up_screen.dart']:
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    if 'localization.dart' not in content:
        loc_import = "import 'package:cesc_commerce/core/localization.dart';\n"
        content = loc_import + content
        with codecs.open(path, 'w', 'utf-8') as f:
            f.write(content)
        print(f'Added import to {path}')
    else:
        print(f'Already has: {path}')

# Also add to search_screen, notifications_screen, help_support_screen
extra = [
    'lib/screens/home/search_screen.dart',
    'lib/screens/profile/notifications_screen.dart',
    'lib/screens/profile/notification_screen.dart',
    'lib/screens/profile/help_support_screen.dart',
]
for path in extra:
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    if 'localization.dart' not in content:
        loc_import = "import 'package:cesc_commerce/core/localization.dart';\n"
        content = loc_import + content
        with codecs.open(path, 'w', 'utf-8') as f:
            f.write(content)
        print(f'Added import to {path}')
    else:
        print(f'Already has: {path}')
