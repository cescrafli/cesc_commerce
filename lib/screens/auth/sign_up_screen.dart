import 'package:cesc_commerce/core/localization.dart';
import 'package:cesc_commerce/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/user_service.dart';

class SignUpScreen extends ConsumerStatefulWidget {

  const SignUpScreen({super.key});

  @override

  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();

}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {

  final AuthService _authService = AuthService();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  bool _isLoading = false;

  bool _agreedToTerms = false;

  String _selectedCountryCode = '+62'; // Default Indonesia

  bool _obscurePassword = true;



  void _signUp() async {

    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty || _phoneController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('please_fill_all'))));

      return;

    }

    if (!_agreedToTerms) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must agree to the Terms of Service')));

      return;

    }

    

    // Basic email validation

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(_emailController.text.trim())) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid email address')));

      return;

    }

    

    setState(() => _isLoading = true);

    try {
      final res = await _authService.signUpWithEmail(_emailController.text.trim(), _passwordController.text.trim(), fullName: _nameController.text.trim());

      if (mounted) {

        setState(() => _isLoading = false);

        if (res != null) {

          // user created successfully
          UserService.mockProfile.value = {...UserService.mockProfile.value, 'name': res.displayName ?? _nameController.text.trim(), 'email': res.email, 'phone': '$_selectedCountryCode ${_phoneController.text.trim()}'};
          globalUser.value = {'uid': res.uid, 'email': res.email, 'name': res.displayName ?? _nameController.text.trim(), 'phone': '$_selectedCountryCode ${_phoneController.text.trim()}'};
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));

        } else {

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign Up Failed. Check your email format or try again.')));

        }

      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }




  @override

  Widget build(BuildContext context) {

    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, _, __) => Scaffold(

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

                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                        }
                      },

                      child: Container(

                        padding: const EdgeInsets.all(12),

                        decoration: const BoxDecoration(color: Color(0xFFE8EAF6), shape: BoxShape.circle),

                        child: const Icon(Icons.arrow_back_ios_new, size: 16),

                      ),

                    ),

                    const LanguageSelector(bgColor: Color(0xFFE8EAF6), textColor: Colors.black, showLanguageIcon: true)

                  ],

                ),

                

                const SizedBox(height: 20),

                

                // Logo

                Container(

                  padding: const EdgeInsets.all(15),

                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),

                  child: Image.asset('assets/images/logo_icon.png', height: 40),

                ),

                const SizedBox(height: 20),

                

                // Welcome Text

                Text(tr('create_account'), style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF111827))),

                const SizedBox(height: 8),

                Text(tr('join_desc'), textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 13, height: 1.4)),

                

                const SizedBox(height: 30),

                

                // Form

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(tr('full_name'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                    const SizedBox(height: 8),

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),

                      child: TextField(

                        controller: _nameController,

                        decoration: const InputDecoration(

                          border: InputBorder.none,

                          hintText: 'e.g. Cesc Fabregas',

                          hintStyle: TextStyle(color: Colors.black26),

                          prefixIcon: Icon(Icons.person_outline, color: Colors.black54, size: 20),

                          prefixIconConstraints: BoxConstraints(minWidth: 40),

                        ),

                      ),

                    ),

                    

                    const SizedBox(height: 15),

                    

                    Text(tr('email_address'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                    const SizedBox(height: 8),

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),

                      child: TextField(

                        controller: _emailController,

                        keyboardType: TextInputType.emailAddress,

                        decoration: const InputDecoration(

                          border: InputBorder.none,

                          hintText: 'name@domain.com',

                          hintStyle: TextStyle(color: Colors.black26),

                          prefixIcon: Icon(Icons.email_outlined, color: Colors.black54, size: 20),

                          prefixIconConstraints: BoxConstraints(minWidth: 40),

                        ),

                      ),

                    ),

                    

                    const SizedBox(height: 15),

                    

                    Text(tr('phone_number'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                    const SizedBox(height: 8),

                    Row(

                      children: [

                        Expanded(

                          flex: 3,

                          child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                            decoration: const BoxDecoration(color: Color(0xFFF0F5FF), borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16))),

                            child: DropdownButtonHideUnderline(

                              child: DropdownButton<String>(

                                value: _selectedCountryCode,

                                isExpanded: true,

                                icon: const Icon(Icons.arrow_drop_down, size: 16),

                                items: ['+1', '+62', '+44', '+91'].map((code) => DropdownMenuItem(value: code, child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)))).toList(),

                                onChanged: (val) => setState(() => _selectedCountryCode = val!),

                              ),

                            ),

                          ),

                        ),

                        Container(width: 1, height: 25, color: Colors.grey.shade300),

                        Expanded(

                          flex: 7,

                          child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 15),

                            decoration: const BoxDecoration(color: Color(0xFFF0F5FF), borderRadius: BorderRadius.only(topRight: Radius.circular(16), bottomRight: Radius.circular(16))),

                            child: TextField(

                              controller: _phoneController,

                              keyboardType: TextInputType.phone,

                              decoration: const InputDecoration(

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

                    

                    Text(tr('password'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                    const SizedBox(height: 8),

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),

                      child: TextField(

                        controller: _passwordController,

                        obscureText: _obscurePassword,

                        decoration: InputDecoration(

                          border: InputBorder.none,

                          hintText: 'Create strong password',

                          hintStyle: const TextStyle(color: Colors.black26),

                          prefixIcon: const Icon(Icons.lock_outline, color: Colors.black54, size: 20),

                          prefixIconConstraints: const BoxConstraints(minWidth: 40),

                          suffixIcon: IconButton(

                            icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black54, size: 20),

                            onPressed: () => setState(() => _obscurePassword = !_obscurePassword)

                          ),

                        ),

                      ),

                    ),

                  ],

                ),

                

                const SizedBox(height: 25),

                

                // Terms

                Row(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    SizedBox(

                      width: 24, height: 24,

                      child: Checkbox(

                        value: _agreedToTerms,

                        onChanged: (val) => setState(() => _agreedToTerms = val ?? false),

                        activeColor: const Color(0xFF006C7A),

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),

                      ),

                    ),

                    const SizedBox(width: 8),

                    Expanded(

                      child: GestureDetector(

                        onTap: () {

                          showDialog(

                            context: context,

                            builder: (context) => AlertDialog(

                              title: Text(tr('terms_privacy')),

                              content: const SingleChildScrollView(

                                child: Text('Cescrafli Terms of Service & Privacy Policy\n\n1. Acceptance of Terms\nBy accessing and using this application, you agree to be bound by these Terms of Service.\n\n2. Privacy Policy\nYour privacy is important to us. We will not share your personal data without your consent.\n\n3. User Conduct\nYou agree to use the application responsibly and not for any unlawful purposes.'),

                              ),

                              actions: [

                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))

                              ],

                            ),

                          );

                        },

                        child: Text.rich(

                          TextSpan(

                            text: 'By creating an account, you agree to Cescrafli ',

                            style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),

                            children: [

                              TextSpan(text: 'Terms of Service ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),

                              const TextSpan(text: 'and '),

                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),

                            ]

                          )

                        ),

                      )

                    )

                  ],

                ),

                

                const SizedBox(height: 30),

                

                // Sign Up Button

                SizedBox(

                  width: double.infinity, height: 55,

                  child: ElevatedButton(

                    onPressed: _isLoading ? null : _signUp,

                    style: ElevatedButton.styleFrom(

                      backgroundColor: const Color(0xFF26C6DA),

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                      elevation: 5,

                      shadowColor: const Color(0xFF00BCD4).withOpacity(0.3)

                    ),

                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(tr('create_account'), style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                        SizedBox(width: 8),

                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),

                      ],

                    ),

                  ),

                ),

                

                const SizedBox(height: 25),

                

                // Log in link

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text(tr('already_have_account'), style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),

                    GestureDetector(

                      onTap: () {
                        if (Navigator.canPop(context)) { Navigator.pop(context); } else { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())); }
                      },

                      child: Text(tr('log_in'), style: TextStyle(color: Color(0xFF006C7A), fontWeight: FontWeight.bold, fontSize: 14))

                    ),

                  ],

                ),

                const SizedBox(height: 100),
              ],

            ),
          ),
        ),
      ),
      ),
    );
  }
}
