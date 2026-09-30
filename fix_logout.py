with open('lib/screens/profile/profile_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_auth = "import 'package:cesc_commerce/core/services/auth_service.dart';\n"
if 'auth_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_auth)

old_code = '''onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false)),'''
new_code = '''onTap: () async {
                      await AuthService().signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                      }
                    }),'''

content = content.replace(old_code, new_code)

with open('lib/screens/profile/profile_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed logout')
