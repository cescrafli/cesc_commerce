import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class ApplePayScreen extends StatelessWidget {

  const ApplePayScreen({super.key});

  @override Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF2F4F7),

      body: SafeArea(

        child: Column(

          children: [

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),

                  ),

                  Column(

                    children: [

                      const Text('Apple Pay Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('FAST 1-TOUCH AUTHORIZATION', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  const Text('Cancel', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14)),

                ],

              ),

            ),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Column(

                  children: [

                    // Order Summary

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text('CURRENT ORDER', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)),

                                  const SizedBox(height: 4),

                                  const Text('#ORD-9302', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 16)),

                                ],

                              ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                            ],

                          ),

                          const SizedBox(height: 20),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Denim Jacket + Basic T-Shirt', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13)), const Text('\$35.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 10),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Standard Shipping & Taxes', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13)), const Text('\$5.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 20),

                          Divider(height: 1, color: Colors.grey.shade200),

                          const SizedBox(height: 20),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Total Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))]),

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),



                    // Apple Pay Sheet UI Mimic

                    Container(

                      width: double.infinity,

                      padding: const EdgeInsets.all(25),

                      decoration: BoxDecoration(color: const Color(0xFF131A26), borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))]),

                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Row(

                                children: [

                                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24)), child: const Icon(Icons.apple, color: Colors.white, size: 24)),

                                  const SizedBox(width: 15),

                                  Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      Text('PAYMENT GATEWAY', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                      const SizedBox(height: 4),

                                      Row(

                                        children: [

                                          const Text('Apple Pay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

                                          const SizedBox(width: 6),

                                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),

                                        ],

                                      )

                                    ],

                                  )

                                ],

                              ),

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.end,

                                children: [

                                  Text('Authorization', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),

                                  const SizedBox(height: 4),

                                  const Text('\$40.50', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 16, fontWeight: FontWeight.bold)),

                                ],

                              )

                            ],

                          ),

                          const SizedBox(height: 25),

                          Divider(height: 1, color: Colors.white.withOpacity(0.1)),

                          const SizedBox(height: 25),

                          Container(

                            padding: const EdgeInsets.all(15),

                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),

                            child: Row(

                              children: [

                                Container(width: 45, height: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.credit_card, size: 20)),

                                const SizedBox(width: 15),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      const Text('Apple Card', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),

                                      const SizedBox(height: 2),

                                      Text('Mastercard **** 9924', style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 12)),

                                    ],

                                  ),

                                ),

                                const Text('Change', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 13)),

                              ],

                            ),

                          ),

                          const SizedBox(height: 25),

                          _buildAppleDetailRow('SHIPPING', 'Cesc Fabregas\n123 Main Street, San Diego, CA 92101'),

                          const SizedBox(height: 15),

                          _buildAppleDetailRow('DELIVERY', 'Standard (2-3 Business Days)', badge: 'FREE'),

                          const SizedBox(height: 15),

                          _buildAppleDetailRow('CONTACT', 'cesc.fabregas@clubmail.com'),

                          const SizedBox(height: 35),

                          Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFF00BCD4).withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.face_retouching_natural, color: Color(0xFF00BCD4), size: 30)),

                          const SizedBox(height: 15),

                          const Text('Double-Click Side Button to Pay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),

                          const SizedBox(height: 4),

                          Text('or verify with Face ID / Passcode', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    Text(' Choose a different payment method', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 13)),

                    const SizedBox(height: 30),

                  ],

                ),

              ),

            ),

            // Bottom

            Container(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Column(

                children: [

                  SizedBox(

                    width: double.infinity, height: 60,

                    child: ElevatedButton(

                      onPressed: () => Navigator.pop(context),

                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [

                          Text('Authorize', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                          SizedBox(width: 10),

                          Icon(Icons.apple, color: Colors.white, size: 20),

                          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

                          SizedBox(width: 15),

                          Text('•', style: TextStyle(color: Colors.blueGrey)),

                          SizedBox(width: 15),

                          Text('\$40.50', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 16, fontWeight: FontWeight.bold)),

                        ],

                      ),

                    ),

                  ),

                  const SizedBox(height: 12),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Icon(Icons.lock, color: Colors.blueGrey, size: 12),

                      const SizedBox(width: 6),

                      Text('Protected by Apple Pay Secure Enclave', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),

                    ],

                  )

                ],

              ),

            )

          ],

        )

      )

    );

  }

  

  Widget _buildAppleDetailRow(String title, String val, {String? badge}) {

    return Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        SizedBox(width: 90, child: Text(title, style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11, letterSpacing: 0.5))),

        Expanded(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,

            children: [

              Text(val, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),

              if(badge != null) ...[const SizedBox(height: 4), Text(badge, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12))]

            ],

          ),

        )

      ],

    );

  }

}
