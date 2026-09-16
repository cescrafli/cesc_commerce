import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../main.dart'; // To access other screens temporarily

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
    setState(() => _isLoading = true);
    final user = await _authService.signInWithEmail(_emailController.text, _passwordController.text);
    setState(() => _isLoading = false);
    
    if (user != null) {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login failed. Check your credentials.')));
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
              // Header
              Align(alignment: Alignment.centerLeft, child: GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.arrow_back_ios_new, size: 16)))),
              const SizedBox(height: 20),
              Image.asset('assets/images/logo_icon.png', height: 80),
              const SizedBox(height: 20),
              const Text('Welcome Back', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF03045E))),
              const SizedBox(height: 8),
              const Text('Log in to continue shopping', style: TextStyle(color: Colors.black54, fontSize: 14)),
              const SizedBox(height: 40),
              
              // Inputs
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _emailController, decoration: const InputDecoration(hintText: 'Email Address', prefixIcon: Icon(Icons.email_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              const SizedBox(height: 15),
              Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)), child: TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Colors.black38), suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.black38), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 16)))),
              
              const SizedBox(height: 15),
              Align(alignment: Alignment.centerRight, child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())), child: const Text('Forgot Password?', style: TextStyle(color: Color(0xFF0096C7), fontWeight: FontWeight.bold)))),
              const SizedBox(height: 30),
              
              // Button
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
