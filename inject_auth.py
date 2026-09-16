import re

with open('screens_auth.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# LoginScreen
login_logic = '''
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    setState(() => _isLoading = true);
    final user = await _authService.signInWithEmail(_emailController.text.trim(), _passwordController.text.trim());
    setState(() => _isLoading = false);
    
    if (user != null) {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed. Check credentials.')));
    }
  }

  @override
  Widget build(BuildContext context) {
'''
content = re.sub(r'class LoginScreen extends StatelessWidget \{\s*const LoginScreen\(\{super\.key\}\);\s*@override\s*Widget build\(BuildContext context\) \{', login_logic, content)
content = re.sub(r"hintText: 'name@domain\.com or phone'", "controller: _emailController, hintText: 'name@domain.com or phone'", content)
content = re.sub(r"hintText: '\*\*\*\*\*\*\*\*'", "controller: _passwordController, hintText: '********'", content)
content = content.replace("onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen())),", "onPressed: _isLoading ? null : _login,")
content = content.replace("const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))", "_isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))")

# SignUpScreen
signup_logic = '''
class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _signUp() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    setState(() => _isLoading = true);
    final user = await _authService.signUpWithEmail(_emailController.text.trim(), _passwordController.text.trim());
    setState(() => _isLoading = false);
    
    if (user != null) {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {
'''
content = re.sub(r'class SignUpScreen extends StatelessWidget \{\s*const SignUpScreen\(\{super\.key\}\);\s*@override\s*Widget build\(BuildContext context\) \{', signup_logic, content)
content = re.sub(r"hintText: 'Jane Doe'", "controller: _nameController, hintText: 'Jane Doe'", content)
content = re.sub(r"hintText: 'name@domain\.com'", "controller: _emailController, hintText: 'name@domain.com'", content)
# It has a second password field, replace the first matching '********' with password controller
content = content.replace("hintText: '********',", "controller: _passwordController, hintText: '********',", 1)
content = content.replace("onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen())),", "onPressed: _isLoading ? null : _signUp,", 1)
content = content.replace("const Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))", "_isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold))")

with open('temp_firebase_auth_fixed.dart', 'w', encoding='utf-8') as f:
    f.write(content)
