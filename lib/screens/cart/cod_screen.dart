import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CODScreen extends StatelessWidget {

  const CODScreen({super.key});

  @override Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

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

                      const Text('Cash on Delivery', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('ORDER CONFIRMATION #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                ],

              ),

            ),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    // Delivery Dest

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Row(

                                children: [

                                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.location_on, color: Color(0xFF00BCD4), size: 16)),

                                  const SizedBox(width: 10),

                                  Text('DELIVERY\nDESTINATION', style: TextStyle(color: Colors.blueGrey.shade300, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)),

                                ],

                              ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                            ],

                          ),

                          const SizedBox(height: 20),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Cesc Fabregas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('Home', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 12))]),

                          const SizedBox(height: 8),

                          const Text('123 Main Street, Apt 4B, San Diego, CA 92101', style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4)),

                          const SizedBox(height: 12),

                          Row(children: [const Icon(Icons.phone_outlined, size: 14, color: Colors.grey), const SizedBox(width: 6), Text('(858) 555-0192', style: TextStyle(color: Colors.grey.shade600, fontSize: 13))]),

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    // Breakdown

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text('PAYMENT BREAKDOWN', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                          const SizedBox(height: 15),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const Text('\$35.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Standard Shipping', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const Text('\$5.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Text('COD Handling Fee', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('WAIVED', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)))]), const Text('\$0.00 (Free)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14))]),

                          const SizedBox(height: 15),

                          Divider(color: Colors.grey.shade200, height: 1), // Actually dashed in mockup, but solid is fine

                          const SizedBox(height: 15),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Total to Pay at Door', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 4), Text('Inclusive of all local taxes', style: TextStyle(color: Colors.grey.shade400, fontSize: 11))]), const Text('\$40.50', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 24))]),

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    // Notice

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const Icon(Icons.info, color: Colors.brown, size: 20),

                              const SizedBox(width: 10),

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    const Text('COURIER NOTICE', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                                    const SizedBox(height: 4),

                                    RichText(text: const TextSpan(style: TextStyle(color: Colors.brown, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Please prepare exact change of '), TextSpan(text: '\$40.50', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)), TextSpan(text: ' when the courier arrives to expedite handover.')])),

                                  ],

                                ),

                              )

                            ],

                          ),

                          const SizedBox(height: 15),

                          Divider(color: Colors.amber.shade200, height: 1),

                          const SizedBox(height: 15),

                          Row(children: [const Icon(Icons.sms_outlined, color: Colors.brown, size: 14), const SizedBox(width: 6), Text('Courier will call or send SMS prior to delivery.', style: TextStyle(color: Colors.brown.shade800, fontSize: 11))])

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    // Buyer Protection

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Text('COD BUYER PROTECTION', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                          const SizedBox(height: 15),

                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.check, color: Color(0xFF00BCD4), size: 14)),

                              const SizedBox(width: 10),

                              Expanded(child: RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Unboxing check allowed ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'before cash payment handover.')])))

                            ],

                          ),

                          const SizedBox(height: 15),

                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.check, color: Color(0xFF00BCD4), size: 14)),

                              const SizedBox(width: 10),

                              Expanded(child: RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Instant digital receipt & invoice ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'sent via SMS and email immediately upon collection.')])))

                            ],

                          ),

                        ],

                      ),

                    ),

                    const SizedBox(height: 30),

                  ],

                ),

              ),

            ),

            // Bottom Action

            Container(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),

              child: Column(

                children: [

                  SizedBox(

                    width: double.infinity, height: 55,

                    child: ElevatedButton(

                      onPressed: () => Navigator.pop(context),

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: const Text('Confirm Order via COD • \$40.50  ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                    ),

                  ),

                  const SizedBox(height: 12),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Icon(Icons.verified, color: Colors.green, size: 14),

                      const SizedBox(width: 6),

                      Text('Safe, contactless or cash handover guarantee', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),

                    ],

                  )

                ],

              ),

            )

          ]

        )

      )

    );

  }

}
