import os

if os.path.exists('lib/screens/profile/notification_screen.dart'):
    os.remove('lib/screens/profile/notification_screen.dart')

with open('lib/screens.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("export 'screens/profile/notification_screen.dart';\n", "")

with open('lib/screens.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print('Cleaned up rogue notification_screen.dart')
