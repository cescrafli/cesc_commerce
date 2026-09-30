import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/auth_service.dart';


class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key});

  @override

  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();

}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }



  void _sendResetCode() async {

    if (_emailController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter your email address')));

      return;

    }

    setState(() => _isLoading = true);

    

    final email = _emailController.text.trim();
    try {
      final success = await AuthService().resetPassword(email);
      if (!mounted) return;
      setState(() => _isLoading = false);
      if (success == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password reset email sent! Check your inbox.')));
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Failed to send reset email')));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred. Please try again.')));
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

                      child: GestureDetector(

                        onTap: () => Navigator.pop(context),

                        child: const Icon(Icons.arrow_back_ios_new, size: 16)

                      ),

                    ),

                    const LanguageSelector(bgColor: Colors.white, textColor: Colors.black)

                  ],

                ),

                

                const SizedBox(height: 40),

                

                // Logo & Header

                Image.asset('assets/images/logo_icon.png', height: 70),

                const SizedBox(height: 30),

                

                const Text('Reset Password', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF03045E), letterSpacing: -0.5)),

                const SizedBox(height: 12),

                const Text('Enter your email address and we will send you a link to reset your password.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 15, height: 1.5)),

                

                const SizedBox(height: 40),

                

                // Input Form

                Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const Text('Email Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                    const SizedBox(height: 8),

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),

                      child: TextField(

                        controller: _emailController,

                        decoration: const InputDecoration(

                          border: InputBorder.none,

                          hintText: 'name@domain.com',

                          hintStyle: TextStyle(color: Colors.black38),

                          prefixIcon: Icon(Icons.alternate_email, color: Colors.black38, size: 20),

                          prefixIconConstraints: BoxConstraints(minWidth: 40),

                        ),

                      ),

                    ),

                  ],

                ),

                

                const SizedBox(height: 40),

                

                // Send Button

                SizedBox(

                  width: double.infinity, height: 55,

                  child: ElevatedButton(

                    onPressed: _isLoading ? null : _sendResetCode,

                    style: ElevatedButton.styleFrom(

                      backgroundColor: const Color(0xFF00B4D8), // Cyan

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                      elevation: 5,

                      shadowColor: const Color(0xFF00BCD4).withOpacity(0.3)

                    ),

                    child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text('Send Reset Link', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                        SizedBox(width: 8),

                        Icon(Icons.arrow_forward, color: Colors.white, size: 20),

                      ],

                    ),

                  ),

                ),

                

                const SizedBox(height: 30),

                

                // Back to Login

                Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Text("Remember your password? ", style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),

                    GestureDetector(

                      onTap: () => Navigator.pop(context),

                      child: const Text('Log In', style: TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.bold, fontSize: 14))

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
