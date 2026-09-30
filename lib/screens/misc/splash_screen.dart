import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/core/services/auth_service.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});



  @override

  State<SplashScreen> createState() => _SplashScreenState();

}


class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  Timer? _timer;

  late AnimationController _controller;

  late Animation<double> _animation;



  @override

  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    // Navigate after 3 seconds and check auth
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        final user = AuthService().currentUser;
        if (user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        }
      }
    });
  }



  @override

  void dispose() {
    _timer?.cancel();

    _controller.dispose();

    super.dispose();

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [Color(0xFFE0F7FA), Color(0xFFF0F9FF), Colors.white],

            stops: [0.0, 0.4, 1.0],

          ),

        ),

        child: Stack(

          alignment: Alignment.center,

          children: [

            // Decorative background blurs

            Positioned(top: -50, right: -50, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.2), blurRadius: 100, spreadRadius: 50)]))),

            Positioned(bottom: -50, left: -50, child: Container(width: 300, height: 300, decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: const Color(0xFF81D4FA).withOpacity(0.2), blurRadius: 100, spreadRadius: 50)]))),

            

            Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Spacer(flex: 3),

                // Logo with pulsing glow

                AnimatedBuilder(

                  animation: _animation,

                  builder: (context, child) {

                    return Stack(

                      alignment: Alignment.center,

                      children: [

                        Transform.scale(

                          scale: _animation.value,

                          child: Container(

                            width: 120, height: 120,

                            decoration: BoxDecoration(

                              shape: BoxShape.circle,

                              boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.3), blurRadius: 40, spreadRadius: 10)],

                            ),

                          ),

                        ),

                        child!,

                      ],

                    );

                  },

                  child: Container(

                    width: 100, height: 100,

                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28), border: Border.all(color: Colors.cyan.shade100), boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))]),

                    child: Image.asset('assets/images/logo_icon.png', fit: BoxFit.contain),

                  ),

                ),

                const SizedBox(height: 30),

                const Text('cescrafli', style: TextStyle(color: Color(0xFF03045E), fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1)),

                const Text('E-COMMERCE SOLUTION', style: TextStyle(color: Color(0xFF00B4D8), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),

                const SizedBox(height: 25),

                const Text('Smart, Seamless & Modern\nE-Commerce Solution', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w500, height: 1.4)),

                const Spacer(flex: 2),

                

                // Loading & Footer

                const SizedBox(

                  width: 35, height: 35,

                  child: CircularProgressIndicator(color: Color(0xFF00B4D8), strokeWidth: 3),

                ),

                const SizedBox(height: 20),

                const Row(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Icon(Icons.shield_outlined, color: Color(0xFF00B4D8), size: 14),

                    SizedBox(width: 6),

                    Text('Secured  Version 2.4.0', style: TextStyle(color: Colors.black45, fontSize: 12, fontWeight: FontWeight.w600)),

                  ],

                ),

                const SizedBox(height: 40),

              ],

            )

          ],

        ),

      ),

    );

  }

}
