import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class PayPalScreen extends StatelessWidget {

  const PayPalScreen({super.key});

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

                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: const [

                          Text('PayPal Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                          SizedBox(width: 6),

                          Icon(Icons.shield, color: Colors.blue, size: 16),

                        ],

                      ),

                      const SizedBox(height: 2),

                      Text('CONNECTED ACCOUNT • #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.lock, color: Color(0xFF0F8A9E), size: 18)),

                ],

              ),

            ),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // PayPal Banner

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: const Color(0xFF003087), borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFF003087), Color(0xFF0079C1)])),

                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Row(

                                children: [

                                  const Text('PP', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),

                                  const SizedBox(width: 10),

                                  const Text('PayPal', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),

                                ],

                              ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                            ],

                          ),

                          const SizedBox(height: 25),

                          Divider(color: Colors.white.withOpacity(0.2), height: 1),

                          const SizedBox(height: 20),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text('CONNECTED ACCOUNT', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                  const SizedBox(height: 4),

                                  const Text('cesc.fabregas@clubmail.com', style: TextStyle(color: Colors.white, fontSize: 13)),

                                ],

                              ),

                              Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Text('Switch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    // Summary

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Row(

                        children: [

                          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.shopping_bag, color: Color(0xFF00BCD4))),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Row(children: const [Text('E-Commerce Store', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), SizedBox(width: 6), Icon(Icons.verified, color: Colors.blue, size: 14)]),

                                const SizedBox(height: 4),

                                Text('Order #ORD-9302 • 2 items', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),

                              ],

                            ),

                          ),

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.end,

                            children: [

                              Text('Total', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),

                              const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('PAY WITH', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),

                        const Text('3 sources linked', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12)),

                      ],

                    ),

                    const SizedBox(height: 15),

                    _buildPPOption(true, 'PayPal Balance', '\$142.80 available', Icons.account_balance_wallet, Colors.blue, 'Preferred', Colors.blue.shade50, Colors.blue),

                    const SizedBox(height: 12),

                    _buildPPOption(false, 'Chase Checking', 'Primary Bank Account', Icons.account_balance, Colors.grey.shade700, '**** 5120', Colors.transparent, Colors.grey),

                    const SizedBox(height: 12),

                    _buildPPOption(false, 'Pay in 4 Interest-Free', '4 payments of \$10.12 every 2 weeks', Icons.money, Colors.orange, '0% APR', Colors.green.shade50, Colors.green),

                    const SizedBox(height: 20),

                    Container(

                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16)),

                      child: Row(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Icon(Icons.security, color: Color(0xFF0F8A9E), size: 18),

                          const SizedBox(width: 10),

                          Expanded(

                            child: RichText(

                              text: const TextSpan(

                                style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4),

                                children: [

                                  TextSpan(text: 'PayPal Purchase Protection: ', style: TextStyle(fontWeight: FontWeight.bold)),

                                  TextSpan(text: 'Eligible purchases are covered if items don\'t arrive or match description.'),

                                ]

                              ),

                            ),

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('Billing Currency', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),

                        const Text(' USD (\$40.50) • No conversion fee', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),

                      ],

                    ),

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

                    width: double.infinity, height: 55,

                    child: ElevatedButton(

                      onPressed: () => Navigator.pop(context),

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: const Text('Agree & Pay \$40.50 with PayPal  ', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                    ),

                  ),

                  const SizedBox(height: 20),

                  const Text('Cancel and return to checkout', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14)),

                  const SizedBox(height: 20),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Icon(Icons.lock, color: Colors.grey, size: 12),

                      const SizedBox(width: 6),

                      Text('Protected by PayPal 256-bit encryption & PCI-DSS standards', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),

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



  Widget _buildPPOption(bool isSel, String title, String sub, IconData icon, Color iconColor, String badgeTxt, Color badgeBg, Color badgeColor) {

    return Container(

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),

      child: Row(

        children: [

          Icon(isSel ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),

          const SizedBox(width: 15),

          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 20)),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                const SizedBox(height: 4),

                Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),

              ],

            ),

          ),

          if(badgeTxt.isNotEmpty)

            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(8)), child: Text(badgeTxt, style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold))),

        ],

      ),

    );

  }

}
