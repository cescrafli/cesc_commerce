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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed. Check email or password.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, size: 16)))),
              const SizedBox(height: 20),
              Image.asset('assets/images/logo_icon.png', height: 80),
              const SizedBox(height: 20),
              const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF03045E))),
              const SizedBox(height: 8),
              const Text('Log in with your Firebase Account', style: TextStyle(color: Colors.black54, fontSize: 14)),
              const SizedBox(height: 40),
              
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _emailController, decoration: const InputDecoration(hintText: 'Email Address', prefixIcon: Icon(Icons.email_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              const SizedBox(height: 15),
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.black38), suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              
              const SizedBox(height: 15),
              Align(alignment: Alignment.centerRight, child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())), child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF0096C7), fontWeight: FontWeight.bold)))),
              const SizedBox(height: 30),
              
              SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: _isLoading ? null : _login, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B4D8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
              
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("Don't have an account? ", style: TextStyle(color: Colors.black54)), GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())), child: const Text('Sign Up', style: TextStyle(color: Color(0xFF0096C7), fontWeight: FontWeight.bold)))]),
            ],
          ),
        ),
      ),
    );
  }
}

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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up failed. Email might be in use.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, size: 16)))),
              const SizedBox(height: 20),
              Image.asset('assets/images/logo_icon.png', height: 80),
              const SizedBox(height: 20),
              const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF03045E))),
              const SizedBox(height: 8),
              const Text('Sign up to start shopping', style: TextStyle(color: Colors.black54, fontSize: 14)),
              const SizedBox(height: 40),
              
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _nameController, decoration: const InputDecoration(hintText: 'Full Name', prefixIcon: Icon(Icons.person_outline, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              const SizedBox(height: 15),
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _emailController, decoration: const InputDecoration(hintText: 'Email Address', prefixIcon: Icon(Icons.email_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              const SizedBox(height: 15),
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.black38), suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              
              const SizedBox(height: 30),
              SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: _isLoading ? null : _signUp, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B4D8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
              
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Text("Already have an account? ", style: TextStyle(color: Colors.black54)), GestureDetector(onTap: () => Navigator.pop(context), child: const Text('Log In', style: TextStyle(color: Color(0xFF0096C7), fontWeight: FontWeight.bold)))]),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, size: 16)))),
              const SizedBox(height: 20),
              Image.asset('assets/images/logo_icon.png', height: 80),
              const SizedBox(height: 20),
              const Text('Forgot Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF03045E))),
              const SizedBox(height: 8),
              const Text('Enter your email to reset password', style: TextStyle(color: Colors.black54, fontSize: 14)),
              const SizedBox(height: 40),
              
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: const TextField(decoration: InputDecoration(hintText: 'Email Address', prefixIcon: Icon(Icons.email_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              
              const SizedBox(height: 30),
              SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset link sent!'))); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00B4D8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Send Reset Link', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)))),
            ],
          ),
        ),
      ),
    );
  }
}
