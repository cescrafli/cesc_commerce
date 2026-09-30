with open('lib/screens/auth/sign_up_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_code = '''final user = await _authService.signUpWithEmail(_emailController.text.trim(), _passwordController.text.trim());'''
new_code = '''final user = await _authService.signUpWithEmail(_emailController.text.trim(), _passwordController.text.trim(), fullName: _nameController.text.trim());'''

content = content.replace(old_code, new_code)

with open('lib/screens/auth/sign_up_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed signup')
