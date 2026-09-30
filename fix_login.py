import re

with open('lib/screens/auth/login_screen.dart', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# 1. Add _obscurePassword and _rememberMe states
if '_obscurePassword' not in content:
    content = content.replace('bool _isLoading = false;', 'bool _isLoading = false;\n  bool _obscurePassword = true;\n  bool _rememberMe = false;')

# 2. Fix _login() validation
old_login = '''  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }'''
new_login = '''  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }'''
content = content.replace(old_login, new_login)

# 3. Fix password visibility
old_obscure = 'obscureText: true,'
new_obscure = 'obscureText: _obscurePassword,'
content = content.replace(old_obscure, new_obscure)

old_suffix = 'suffixIcon: const Icon(Icons.visibility_off_outlined, color: Colors.black38, size: 20),'
new_suffix = '''suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black38, size: 20),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),'''
content = content.replace(old_suffix, new_suffix)

# 4. Fix Remember Me toggle
old_remember = '''                            Container(
                              width: 18, height: 18,
                              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(4)),
                              child: const Icon(Icons.check, color: Colors.white, size: 12),
                            ),
                            const SizedBox(width: 8),
                            Text(tr('remember_me'), style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),'''
new_remember = '''                            GestureDetector(
                              onTap: () => setState(() => _rememberMe = !_rememberMe),
                              child: Row(
                                children: [
                                  Container(
                                    width: 18, height: 18,
                                    decoration: BoxDecoration(
                                      color: _rememberMe ? Theme.of(context).primaryColor : Colors.white, 
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: _rememberMe ? Theme.of(context).primaryColor : Colors.grey.shade400)
                                    ),
                                    child: _rememberMe ? const Icon(Icons.check, color: Colors.white, size: 12) : null,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(tr('remember_me'), style: const TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.bold)),
                                ]
                              )
                            ),'''
content = content.replace(old_remember, new_remember)

with open('lib/screens/auth/login_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed login_screen.dart')
