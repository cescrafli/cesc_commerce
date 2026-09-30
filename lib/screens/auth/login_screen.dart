import 'package:cesc_commerce/core/localization.dart';
import 'package:cesc_commerce/core/services/auth_service.dart';
import 'package:cesc_commerce/core/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

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
  bool _obscurePassword = true;
  bool _rememberMe = false;

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('please_fill_all'))));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = await _authService.signInWithEmail(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      if (user != null && mounted) {
        globalUser.value = {'uid': user.uid, 'email': user.email ?? '', 'name': user.displayName ?? ''};
        UserService.mockProfile.value = {...UserService.mockProfile.value, 'uid': user.uid, 'email': user.email ?? '', 'name': user.displayName ?? UserService.mockProfile.value['name'] ?? ''};
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('login_failed'))));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tr('login_failed'))));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, _, __) => Scaffold(
        backgroundColor: const Color(0xFFF0FBFF),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language selector at top
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [LanguageSelector()],
                  ),
                  const SizedBox(height: 20),

                  // Logo
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo_icon.png', width: 70, height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                        Image.asset('assets/images/logo_text.png', height: 20, fit: BoxFit.contain),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Welcome text
                  Text(tr('welcome_back'), style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(tr('sign_in_desc'), style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 13)),
                  const SizedBox(height: 30),

                  // Email field
                  Text(tr('email_phone'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'you@example.com',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.black38, size: 20),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Password field
                  Text(tr('password'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: '••••••••',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.black38, size: 20),
                      prefixIconConstraints: const BoxConstraints(minWidth: 40),
                      suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.black38, size: 20),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Remember me & Forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _rememberMe = !_rememberMe),
                        child: Row(
                          children: [
                            Container(
                              width: 20, height: 20,
                              decoration: BoxDecoration(
                                color: _rememberMe ? const Color(0xFF00BCD4) : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: _rememberMe ? const Color(0xFF00BCD4) : Colors.grey.shade400)
                              ),
                              child: _rememberMe ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                            ),
                            const SizedBox(width: 10),
                            Text(tr('remember_me'), style: const TextStyle(color: Colors.black87, fontSize: 13)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                        child: Text(tr('forgot_password'), style: const TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.bold, fontSize: 13)),
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
                        backgroundColor: const Color(0xFF00BCD4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 5,
                        shadowColor: const Color(0xFF00BCD4).withOpacity(0.3),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(tr('log_in'), style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
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
                        child: Text(tr('or_continue_with'), textAlign: TextAlign.center, style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Social login
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google login coming soon')));
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                            child: const Icon(Icons.g_mobiledata, color: Colors.red, size: 40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Sign up link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tr('dont_have_account'), style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                      GestureDetector(
                        onTap: () {
                          if (Navigator.canPop(context)) { Navigator.pop(context); } else { Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpScreen())); }
                        },
                        child: Text(tr('sign_up'), style: const TextStyle(color: Color(0xFF00BCD4), fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Secure badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock, color: Colors.green, size: 12),
                      const SizedBox(width: 4),
                      Text(tr('secure_encryption'), style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
