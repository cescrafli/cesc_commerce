
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

    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back_ios_new, size: 16),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        children: [
                          Icon(Icons.circle, color: Color(0xFF00BCD4), size: 8),
                          SizedBox(width: 6),
                          Text('EN (US)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Logo
                Image.asset('assets/images/logo.png', height: 80),
                const SizedBox(height: 10),
                
                // Welcome Text
                const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Sign in to continue exploring top fashion & deals', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 13)),
                
                const SizedBox(height: 40),
                
                // Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Email or Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          controller: _emailController, hintText: 'name@domain.com or phone',
                          hintStyle: TextStyle(color: Colors.black38),
                          prefixIcon: Icon(Icons.alternate_email, color: Colors.black38, size: 20),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '������������',
                          hintStyle: TextStyle(color: Colors.black38, letterSpacing: 2),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.black38, size: 20),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                          suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.black38, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(width: 20, height: 20, decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(4)), child: const Icon(Icons.check, color: Colors.white, size: 14)),
                        const SizedBox(width: 10),
                        const Text('Remember me', style: TextStyle(color: Colors.black87, fontSize: 13)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                      child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.bold, fontSize: 13))
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Login Button
                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008CBA), // darker cyan/blue
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                      shadowColor: const Color(0xFF00BCD4).withOpacity(0.3)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Log In', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text('OR\nCONTINUE\nWITH', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // Social Logins
                Row(
                  children: [
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.g_mobiledata, color: Colors.red, size: 40))),
                    const SizedBox(width: 15),
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.apple, size: 28))),
                    const SizedBox(width: 15),
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: const Icon(Icons.face, color: Color(0xFF00BCD4), size: 28))),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                      child: const Text('Sign up', style: TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.bold, fontSize: 13))
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock, color: Colors.green, size: 12),
                    const SizedBox(width: 4),
                    Text('256-bit Secure Encryption � Protected by Cescrafli', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                  ],
                )
              ],
            ),
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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign up failed.')));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(color: Color(0xFFE8EAF6), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new, size: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFE8EAF6), borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        children: [
                          Icon(Icons.language, color: Color(0xFF006C7A), size: 14),
                          SizedBox(width: 6),
                          Text('EN (US)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          Icon(Icons.arrow_drop_down, size: 16),
                        ],
                      ),
                    )
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Logo
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                  child: Image.asset('assets/images/logo.png', height: 40),
                ),
                const SizedBox(height: 20),
                
                // Welcome Text
                const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF111827))),
                const SizedBox(height: 8),
                Text('Join Cescrafli to unlock exclusive deals and\npersonalized fashion.', textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 13, height: 1.4)),
                
                const SizedBox(height: 30),
                
                // Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'e.g. Cesc Fabregas',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.black54, size: 20),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    const Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                      child: const TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          controller: _emailController, hintText: 'name@domain.com',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.black54, size: 20),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    const Text('Phone Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                            decoration: const BoxDecoration(color: Color(0xFFF0F5FF), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('???? +1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                Icon(Icons.arrow_drop_down, size: 16),
                              ],
                            ),
                          ),
                        ),
                        Container(width: 1, height: 25, color: Colors.grey.shade300),
                        Expanded(
                          flex: 7,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: const BoxDecoration(color: Color(0xFFF0F5FF), borderRadius: BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16))),
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '(555) 000-0000',
                                hintStyle: TextStyle(color: Colors.black26),
                                prefixIcon: Icon(Icons.phone_outlined, color: Colors.black54, size: 18),
                                prefixIconConstraints: BoxConstraints(minWidth: 30),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 15),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                      child: const TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Create strong password',
                          hintStyle: TextStyle(color: Colors.black26),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.black54, size: 20),
                          prefixIconConstraints: BoxConstraints(minWidth: 40),
                          suffixIcon: Icon(Icons.visibility_outlined, color: Colors.black54, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('SECURITY LEVEL', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        Expanded(
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.indigo.shade100, borderRadius: BorderRadius.circular(2)))),
                              const SizedBox(width: 4),
                              Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.indigo.shade100, borderRadius: BorderRadius.circular(2)))),
                              const SizedBox(width: 4),
                              Expanded(child: Container(height: 4, decoration: BoxDecoration(color: Colors.indigo.shade100, borderRadius: BorderRadius.circular(2)))),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const Text('Weak', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 25),
                
                // Terms
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 20, height: 20, decoration: BoxDecoration(color: const Color(0xFFE8EAF6), borderRadius: BorderRadius.circular(4))),
                    const SizedBox(width: 12),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4, fontFamily: 'Roboto'), // adjust font family if needed
                          children: [
                            const TextSpan(text: "I agree to Cescrafli's "),
                            const TextSpan(text: "Terms of Service", style: TextStyle(color: Color(0xFF006C7A))),
                            const TextSpan(text: " and "),
                            const TextSpan(text: "Privacy Policy", style: TextStyle(color: Color(0xFF006C7A))),
                          ]
                        )
                      )
                    )
                  ],
                ),
                
                const SizedBox(height: 25),
                
                // Sign Up Button
                SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF26C6DA), // Cyan
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                      shadowColor: const Color(0xFF00BCD4).withOpacity(0.3)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 25),
                
                // OR Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text('OR SIGN UP WITH', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Social Logins
                Row(
                  children: [
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)), child: const Icon(Icons.g_mobiledata, color: Colors.red, size: 40))),
                    const SizedBox(width: 15),
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)), child: const Icon(Icons.apple, color: Color(0xFF111827), size: 28))),
                    const SizedBox(width: 15),
                    Expanded(child: Container(height: 55, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)), child: const Icon(Icons.fingerprint, color: Color(0xFF006C7A), size: 28))),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Log In', style: TextStyle(color: Color(0xFF006C7A), fontWeight: FontWeight.bold, fontSize: 14))
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
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
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_ios_new, size: 20),
                    ),
                    const Text('Forgot Password', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
                      child: Image.asset('assets/images/logo.png', height: 20),
                    )
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Pills
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFE8F4F8), borderRadius: BorderRadius.circular(20)),
                          child: const Row(
                            children: [
                              Icon(Icons.circle, color: Color(0xFF00BFA5), size: 8),
                              SizedBox(width: 6),
                              Text('ACCOUNT RECOVERY', style: TextStyle(color: Color(0xFF006C7A), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                          child: const Row(
                            children: [
                              Icon(Icons.help_outline, color: Color(0xFF006C7A), size: 14),
                              SizedBox(width: 6),
                              Text('Need Help?', style: TextStyle(color: Color(0xFF006C7A), fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Center Logo Icon
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.1), blurRadius: 40, spreadRadius: 10)
                            ]
                          ),
                          child: Image.asset('assets/images/logo.png', height: 60),
                        ),
                        Transform.translate(
                          offset: const Offset(10, 10),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle),
                            child: const Icon(Icons.restore, color: Colors.white, size: 20),
                          ),
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    const Text('Forgot Password?', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text('No worries! Enter your registered email address\nor phone number and we\'ll send you a verification\ncode to reset your password.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5)),
                    
                    const SizedBox(height: 30),
                    
                    // Tabs
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email_outlined, color: Color(0xFF006C7A), size: 16),
                                SizedBox(width: 8),
                                Text('Send via Email', style: TextStyle(color: Color(0xFF006C7A), fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.sms_outlined, color: Colors.black54, size: 16),
                                SizedBox(width: 8),
                                Text('SMS / WhatsApp', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Form
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100)),
                          child: const TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              controller: _emailController, hintText: 'name@domain.com',
                              hintStyle: TextStyle(color: Colors.black26),
                              prefixIcon: Icon(Icons.alternate_email, color: Colors.black54, size: 20),
                              prefixIconConstraints: BoxConstraints(minWidth: 40),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: Colors.green, size: 14),
                            const SizedBox(width: 6),
                            Text('A 6-digit one-time code will be dispatched instantly.', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                          ],
                        )
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Send Button
                    SizedBox(
                      width: double.infinity, height: 55,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF006C7A), // Dark Cyan
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 5,
                          shadowColor: const Color(0xFF006C7A).withOpacity(0.3)
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Send Reset Code', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Secure Info
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFE8EAF6), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.verified_user_outlined, color: Color(0xFF006C7A), size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Secure Session Reset', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(height: 2),
                                Text('Cescrafli protects your orders, wallet & prefere...', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                              ],
                            ),
                          )
                        ],
                      )
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Bottom Links
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Remember your password? ", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text('Log In', style: TextStyle(color: Color(0xFF006C7A), fontWeight: FontWeight.bold, fontSize: 13))
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.support_agent, color: Colors.grey, size: 14),
                        const SizedBox(width: 6),
                        Text('Need more help? Contact Support', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
