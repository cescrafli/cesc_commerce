import re

with open('lib/screens/profile/notifications_screen.dart', 'r', encoding='utf-8') as f:
    notif = f.read()
notif = notif.replace('class NotificationsScreen extends StatefulWidget {', 'class NotificationsScreen extends StatefulWidget {\\n  const NotificationsScreen({super.key});')
with open('lib/screens/profile/notifications_screen.dart', 'w', encoding='utf-8') as f:
    f.write(notif)

with open('lib/screens/profile/help_support_screen.dart', 'r', encoding='utf-8') as f:
    help_screen = f.read()
help_screen = help_screen.replace('class HelpSupportScreen extends StatefulWidget {', 'class HelpSupportScreen extends StatefulWidget {\\n  const HelpSupportScreen({super.key});')
with open('lib/screens/profile/help_support_screen.dart', 'w', encoding='utf-8') as f:
    f.write(help_screen)

with open('lib/screens/home/home_screen.dart', 'r', encoding='utf-8') as f:
    home = f.read()
if 'const HomeScreen({super.key});' not in home:
    home = home.replace('class HomeScreen extends StatefulWidget {', 'class HomeScreen extends StatefulWidget {\\n  const HomeScreen({super.key});')
    with open('lib/screens/home/home_screen.dart', 'w', encoding='utf-8') as f:
        f.write(home)

print('Restored constructors')
