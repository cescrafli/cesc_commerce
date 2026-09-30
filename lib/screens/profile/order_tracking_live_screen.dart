import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class OrderTrackingLiveScreen extends StatelessWidget {

  const OrderTrackingLiveScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: Column(

          children: [

            // Header

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: const Icon(Icons.arrow_back_ios_new, size: 20),

                  ),

                  const SizedBox(width: 15),

                  const Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text('Order Tracking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        Text('ORDER & LOGISTICS', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                      ],

                    ),

                  ),

                  const Icon(Icons.share_outlined, size: 22, color: Colors.black87),

                  const SizedBox(width: 15),

                  Container(

                    padding: const EdgeInsets.all(6),

                    decoration: const BoxDecoration(color: Color(0xFF006C7A), shape: BoxShape.circle),

                    child: const Icon(Icons.person, color: Colors.white, size: 16),

                  ),

                ],

              ),

            ),

            

            Expanded(

              child: SingleChildScrollView(

                child: Padding(

                  padding: const EdgeInsets.all(20),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      // Status pill

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Container(

                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),

                            child: const Row(

                              children: [

                                Icon(Icons.circle, color: Colors.green, size: 8),

                                SizedBox(width: 6),

                                Text('ORDER #ORD-8910  EXPRESS', style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold)),

                              ],

                            )

                          ),

                          Container(

                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),

                            child: const Row(

                              children: [

                                Icon(Icons.bolt, color: Colors.green, size: 14),

                                SizedBox(width: 4),

                                Text('Live GPS', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),

                              ],

                            ),

                          )

                        ],

                      ),

                      const SizedBox(height: 20),

                      

                      // Live Map Card

                      ClipRRect(

                        borderRadius: BorderRadius.circular(24),

                        child: Stack(

                          children: [

                            Image.network('https://picsum.photos/seed/map3/600/500', height: 250, width: double.infinity, fit: BoxFit.cover),

                            Container(height: 250, width: double.infinity, color: const Color(0xFFE8EAF6).withOpacity(0.5)),

                            // Faux Map details

                            Positioned(

                              top: 20, left: 20,

                              child: Container(

                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),

                                child: Row(

                                  children: [

                                    const Icon(Icons.circle, color: Color(0xFF00BCD4), size: 10),

                                    const SizedBox(width: 6),

                                    const Text('Arriving in ~25 mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                    const SizedBox(width: 6),

                                    Text(' 1.8 mi away', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                  ],

                                ),

                              ),

                            ),

                            Positioned(

                              top: 20, right: 20,

                              child: Container(

                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),

                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),

                                child: const Row(

                                  children: [

                                    Icon(Icons.traffic_outlined, color: Colors.green, size: 14),

                                    SizedBox(width: 4),

                                    Text('Light', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),

                                  ],

                                ),

                              ),

                            ),

                            // Map Markers

                            const Positioned(

                              top: 90, left: 160,

                              child: Icon(Icons.location_on, color: Color(0xFF006C7A), size: 30),

                            ),

                            const Positioned(

                              top: 150, left: 240,

                              child: Icon(Icons.location_on, color: Colors.red, size: 30),

                            ),

                            Positioned(

                              bottom: 20, right: 20,

                              child: Column(

                                children: [

                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.my_location, size: 20)),

                                  const SizedBox(height: 10),

                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.add, size: 20)),

                                  const SizedBox(height: 5),

                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.remove, size: 20)),

                                ],

                              ),

                            ),

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 20),

                      

                      // Courier Info Card

                      Container(

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),

                        child: Column(

                          children: [

                            Row(

                              children: [

                                Stack(

                                  children: [

                                    ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network('https://picsum.photos/seed/dave/100/100', width: 50, height: 50, fit: BoxFit.cover)),

                                    Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.check_circle, color: Colors.green, size: 14))),

                                  ],

                                ),

                                const SizedBox(width: 15),

                                Expanded(

                                  child: Column(

                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [

                                      const Row(

                                        children: [

                                          Text('Dave Miller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                                          SizedBox(width: 4),

                                          Icon(Icons.verified, color: Color(0xFF0F8A9E), size: 14),

                                        ],

                                      ),

                                      const SizedBox(height: 2),

                                      Row(

                                        children: [

                                          const Icon(Icons.star, color: Colors.orange, size: 12),

                                          const SizedBox(width: 4),

                                          const Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                          Text(' (420+ trips)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                        ],

                                      ),

                                      const SizedBox(height: 2),

                                      Text('Honda PCX160  CA8K...', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),

                                    ],

                                  ),

                                ),

                                Row(

                                  children: [

                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF0F8A9E), size: 20)),

                                    const SizedBox(width: 10),

                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.phone_outlined, color: Colors.white, size: 20)),

                                  ],

                                )

                              ],

                            ),

                            const SizedBox(height: 15),

                            Container(

                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

                              decoration: BoxDecoration(color: const Color(0xFFF0FBFF), borderRadius: BorderRadius.circular(16)),

                              child: Row(

                                children: [

                                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade100, shape: BoxShape.circle), child: const Icon(Icons.location_on_outlined, color: Color(0xFF0F8A9E), size: 16)),

                                  const SizedBox(width: 12),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        const Text('You are the next delivery stop!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                        Text('Dave just completed 3 of 4 neighborhood...', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),

                                      ],

                                    ),

                                  )

                                ],

                              ),

                            )

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 25),

                      

                      // Route Progress

                      Container(

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [

                                const Text('Route Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('Stage 3 of 4', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),

                              ],

                            ),

                            const SizedBox(height: 20),

                            

                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Order Packed & Prepared', 'Pacific Distribution Hub  9:15 AM', false),

                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Courier Picked Up', 'Dave Miller on route  9:32 AM', false),

                            _buildExpressTimeline(true, Icons.circle, const Color(0xFF00BCD4), 'Out for Delivery', 'Navigating Evergreen Terr. toward 123 Main St.', true, isCurrent: true),

                            _buildExpressTimeline(false, Icons.circle, Colors.grey.shade300, 'Delivered & Handed Over', 'Expected by 10:05 AM', false, isLast: true),

                            

                            const SizedBox(height: 15),

                            Container(

                              padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),

                              child: Row(

                                children: [

                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network('https://picsum.photos/seed/103/100/100', width: 40, height: 40, fit: BoxFit.cover)),

                                  const SizedBox(width: 12),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        const Text('Cargo Utility Pants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                        Text('Size 32  Olive Green', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),

                                      ],

                                    ),

                                  ),

                                  const Text('\$15.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                ],

                              )

                            )

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 25),

                      

                      // Handover Security

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.lock_outline, color: Colors.black87, size: 20),

                              SizedBox(width: 8),

                              Text('Handover Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                            ],

                          ),

                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Row(children: [Icon(Icons.verified_user_outlined, color: Color(0xFF0F8A9E), size: 10), SizedBox(width: 4), Text('VERIFIED', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))])),

                        ],

                      ),

                      const SizedBox(height: 15),

                      Container(

                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),

                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Icon(Icons.contactless_outlined, color: Color(0xFF0F8A9E), size: 20),

                            const SizedBox(width: 12),

                            Expanded(

                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text('Contactless Drop-off', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                  const SizedBox(height: 4),

                                  Text('Leave at front door or hand directly to resident. Ring doorbell upon leaving.', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, height: 1.3)),

                                ],

                              ),

                            )

                          ],

                        )

                      ),

                      const SizedBox(height: 12),

                      Container(

                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [

                            Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('DELIVERY SECURITY PIN', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                const SizedBox(height: 4),

                                Text('Share with Dave upon arrival', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),

                              ],

                            ),

                            Container(

                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),

                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),

                              child: const Text('4  9  2  0', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),

                            )

                          ],

                        )

                      ),

                      

                      const SizedBox(height: 30),

                      

                      // Action button

                      SizedBox(

                        width: double.infinity, height: 55,

                        child: ElevatedButton(

                          onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset code sent!'))); Navigator.pop(context); },

                          style: ElevatedButton.styleFrom(

                            backgroundColor: const Color(0xFF00BCD4),

                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))

                          ),

                          child: const Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [

                              Icon(Icons.ios_share, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Share Live Location / ETA', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                            ],

                          ),

                        ),

                      ),

                      const SizedBox(height: 12),

                      Center(child: Text('Automatic SMS updates will be sent when courier is 2 minutes\naway.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 10, height: 1.5))),

                      const SizedBox(height: 40),

                    ],

                  ),

                ),

              ),

            )

          ],

        ),

      ),

    );

  }



  Widget _buildExpressTimeline(bool isDone, IconData icon, Color color, String title, String sub, bool isHighlight, {bool isLast = false, bool isCurrent = false}) {

    return IntrinsicHeight(

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Column(

            children: [

              Container(

                width: 24, height: 24,

                decoration: BoxDecoration(

                  color: isCurrent ? Colors.white : color,

                  shape: BoxShape.circle,

                  border: isCurrent ? Border.all(color: color, width: 4) : null,

                ),

                child: !isCurrent ? Icon(icon, size: 14, color: Colors.white) : null,

              ),

              if (!isLast)

                Expanded(

                  child: Container(

                    width: 2,

                    color: isCurrent ? Colors.grey.shade200 : color, // after current it's grey

                  ),

                )

            ],

          ),

          const SizedBox(width: 15),

          Expanded(

            child: Padding(

              padding: const EdgeInsets.only(bottom: 20),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      Text(title, style: TextStyle(fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.normal, fontSize: 13, color: isCurrent || isDone ? Colors.black87 : Colors.grey.shade500)),

                      if (isCurrent) ...[

                        const SizedBox(width: 8),

                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('CURRENT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold))),

                      ]

                    ],

                  ),

                  const SizedBox(height: 4),

                  Text(sub, style: TextStyle(color: isCurrent ? Colors.black87 : Colors.grey.shade500, fontSize: 11)),

                ],

              ),

            ),

          )

        ],

      ),

    );

  }

}
