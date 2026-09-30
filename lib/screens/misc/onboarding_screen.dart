import 'package:flutter/material.dart';

import 'package:cesc_commerce/screens.dart';

class OnboardingScreen extends StatelessWidget {

  const OnboardingScreen({super.key});



  @override

  Widget build(BuildContext context) {
    
    

    return Scaffold(

      backgroundColor: const Color(0xFFFAF8FF),

      body: SafeArea(

        child: Column(

          children: [

            // Top Nav

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                    child: const Row(

                      children: [

                        Icon(Icons.circle, color: Color(0xFF00BCD4), size: 8),

                        SizedBox(width: 6),

                        Text('EN (US)', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 11)),

                      ],

                    ),

                  ),

                  GestureDetector(

                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),

                    child: const Text('SKIP', style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),

                  ),

                ],

              ),

            ),

            

            // Hero Illustration

            Expanded(

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 24),

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Container(

                      width: double.infinity,

                      height: 280,

                      decoration: BoxDecoration(

                        gradient: const LinearGradient(begin: Alignment.topRight, end: Alignment.bottomLeft, colors: [Color(0xFFE0F7FA), Colors.white, Color(0xFFF0F9FF)]),

                        borderRadius: BorderRadius.circular(32),

                        border: Border.all(color: Colors.cyan.shade100.withOpacity(0.6)),

                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))]

                      ),

                      child: Stack(

                        alignment: Alignment.center,

                        children: [

                          // Badges

                          Positioned(

                            top: 20, left: 20,

                            child: Container(

                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),

                              child: Row(

                                children: [

                                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.bolt, color: Colors.amber, size: 16)),

                                  const SizedBox(width: 8),

                                  const Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Text('Flash Deals', style: TextStyle(color: Colors.black45, fontSize: 9, fontWeight: FontWeight.bold)),

                                      Text('Up to 70% Off', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),

                                    ],

                                  )

                                ],

                              ),

                            )

                          ),

                          Positioned(

                            bottom: 20, right: 20,

                            child: Container(

                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.95), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),

                              child: Row(

                                children: [

                                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.local_shipping, color: Color(0xFF00B4D8), size: 16)),

                                  const SizedBox(width: 8),

                                  const Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Text('Delivery', style: TextStyle(color: Colors.black45, fontSize: 9, fontWeight: FontWeight.bold)),

                                      Text('Fast & Tracked', style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold)),

                                    ],

                                  )

                                ],

                              ),

                            )

                          ),

                          // Center Logo

                          Column(

                            mainAxisSize: MainAxisSize.min,

                            children: [

                              Container(

                                width: 90, height: 90,

                                padding: const EdgeInsets.all(15),

                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.cyan.shade100), boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.2), blurRadius: 25, offset: const Offset(0, 10))]),

                                child: Image.asset('assets/images/logo_icon.png', fit: BoxFit.contain),

                              ),

                              const SizedBox(height: 15),

                              Container(

                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)),

                                child: const Text('CESCRAFLI', style: TextStyle(color: Color(0xFF00B4D8), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 2)),

                              )

                            ],

                          )

                        ],

                      ),

                    ),

                  ],

                ),

              ),

            ),

            

            // Text Content

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 28),

              child: Column(

                children: [

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Container(width: 25, height: 6, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF00BCD4)]), borderRadius: BorderRadius.circular(3), boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.3), blurRadius: 5)])),

                      const SizedBox(width: 6),

                      Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),

                      const SizedBox(width: 6),

                      Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.grey.shade300, shape: BoxShape.circle)),

                    ],

                  ),

                  const SizedBox(height: 25),

                  const Text('Discover Trendy Fashion,\nDelivered Instantly', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, height: 1.2, color: Color(0xFF0F172A))),

                  const SizedBox(height: 15),

                  const Text('Explore thousands of curated clothing collections, seamless checkouts, and real-time live GPS courier tracking.', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 13, height: 1.5)),

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      _buildFeaturePill(Icons.check, '100% Original'),

                      const SizedBox(width: 8),

                      _buildFeaturePill(Icons.security, 'Secure Pay'),

                      const SizedBox(width: 8),

                      _buildFeaturePill(Icons.replay, 'Easy Return'),

                    ],

                  ),

                  const SizedBox(height: 35),

                  

                  // Buttons

                  SizedBox(

                    width: double.infinity, height: 55,

                    child: ElevatedButton(

                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),

                      style: ElevatedButton.styleFrom(

                        backgroundColor: const Color(0xFF00B4D8),

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

                        elevation: 8,

                        shadowColor: const Color(0xFF00B4D8).withOpacity(0.4)

                      ),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18),

                        ],

                      ),

                    ),

                  ),

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Text("Already have an account? ", style: TextStyle(color: Colors.black54, fontSize: 13)),

                      GestureDetector(

                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),

                        child: const Text('Log In', style: TextStyle(color: Color(0xFF0096C7), fontWeight: FontWeight.bold, fontSize: 13))

                      ),

                    ],

                  ),

                  const SizedBox(height: 30),

                ],

              ),

            )

          ],

        ),

      ),

    );

  }



  Widget _buildFeaturePill(IconData icon, String text) {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.cyan.shade100)),

      child: Row(

        children: [

          Icon(icon, color: const Color(0xFF0096C7), size: 12),

          const SizedBox(width: 4),

          Text(text, style: const TextStyle(color: Color(0xFF0096C7), fontSize: 11, fontWeight: FontWeight.bold)),

        ],

      ),

    );

  }

}
