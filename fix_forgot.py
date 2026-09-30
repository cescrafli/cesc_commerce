with open('lib/screens/auth/forgot_password_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_auth = "import 'package:cesc_commerce/core/services/auth_service.dart';\n"
if 'auth_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_auth)

old_code = '''// Simulate network request

    Future.delayed(const Duration(seconds: 2), () {

      if (mounted) {

        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent to your email!')));

        Navigator.pop(context);

      }

    });'''

new_code = '''final success = await AuthService().resetPassword(_emailController.text);
    if (mounted) {
      setState(() => _isLoading = false);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent to your email!')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to send reset link.')));
      }
    }'''

content = content.replace(old_code, new_code)
content = content.replace('_sendResetCode() {', '_sendResetCode() async {')

with open('lib/screens/auth/forgot_password_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed forgot password')
