import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class EditBagScreen extends StatefulWidget {

  const EditBagScreen({super.key});



  @override

  State<EditBagScreen> createState() => _EditBagScreenState();

}

class _EditBagScreenState extends State<EditBagScreen> {

  int qty1 = 1;

  String size1 = 'L';

  int color1 = 0; // 0: Indigo, 1: Black, 2: Grey

  

  int qty2 = 1;

  String size2 = 'M';

  int color2 = 0; // 0: Sand, 1: White, 2: Green



  @override

  Widget build(BuildContext context) {
    double total = 0.0;
    double shipping = 0.0;

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: Column(

          children: [

            // 1. Header

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                      child: const Icon(Icons.arrow_back_ios_new, size: 18),

                    ),

                  ),

                  Column(

                    children: [

                      const Text('Edit Bag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('2 ITEMS SELECTED • ORDER #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),

                    child: Row(

                      children: [

                        Icon(Icons.delete_outline, color: Colors.red.shade400, size: 14),

                        const SizedBox(width: 4),

                        Text('Clear', style: TextStyle(color: Colors.red.shade400, fontSize: 11, fontWeight: FontWeight.bold)),

                      ],

                    ),

                  ),

                ],

              ),

            ),

            

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Top Banner

                    Container(

                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(color: const Color(0xFFE8FAF6), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3))),

                      child: Row(

                        children: [

                          Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Icon(Icons.eco, color: Colors.greenAccent, size: 18)),

                          const SizedBox(width: 12),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Eco Member Discount Active', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                const SizedBox(height: 2),

                                Text('Extra -10% automatically deducted on final bag.', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 10)),

                              ],

                            ),

                          ),

                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(12)), child: const Text('APPLIED', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),



                    // Section Title

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Row(

                          children: [

                            const Text('EDITABLE ITEMS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),

                            const SizedBox(width: 8),

                            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Text('2', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),

                          ],

                        ),

                        Text('Auto-saved to checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                      ],

                    ),

                    const SizedBox(height: 15),



                    // Item 1

                    _buildEditableItem(

                      icon: Icons.checkroom, iconColor: Colors.blueGrey.shade800,

                      badgeText: 'Eco',

                      title: 'Denim Classic Jacket',

                      desc: 'Classic Fit • Heavyweight 14oz Cotton',

                      statusColor: Colors.green, statusText: 'In Stock • Ships Tomorrow 14:00',

                      price: '\$30.00',

                      sizeList: ['S', 'M', 'L', 'XL'],

                      selectedSize: size1,

                      onSizeChanged: (s) => setState(() => size1 = s),

                      colorName: 'INDIGO BLUE',

                      colorList: [const Color(0xFF2C3E50), const Color(0xFF1A1A24), const Color(0xFF95A5A6)],

                      selectedColorIdx: color1,

                      onColorChanged: (c) => setState(() => color1 = c),

                      qty: qty1,

                      onQtyAdd: () => setState(() => qty1++),

                      onQtySub: () => setState(() { if (qty1 > 1) qty1--; }),

                    ),

                    const SizedBox(height: 20),



                    // Item 2

                    _buildEditableItem(

                      icon: Icons.eco, iconColor: Colors.green.shade700,

                      badgeText: '100% Bio', badgeColor: Colors.green,

                      title: 'Basic Eco-Cotton T-Shirt',

                      desc: 'Breathable Organic Weave',

                      statusColor: const Color(0xFF0F8A9E), statusText: 'Carbon Neutral Shipping',

                      price: '\$15.00',

                      sizeList: ['XS', 'S', 'M', 'L'],

                      selectedSize: size2,

                      onSizeChanged: (s) => setState(() => size2 = s),

                      colorName: 'SAND LINEN',

                      colorList: [const Color(0xFFD2B48C), const Color(0xFFF5F5F5), const Color(0xFF2F4F4F)],

                      selectedColorIdx: color2,

                      onColorChanged: (c) => setState(() => color2 = c),

                      qty: qty2,

                      onQtyAdd: () => setState(() => qty2++),

                      onQtySub: () => setState(() { if (qty2 > 1) qty2--; }),

                    ),

                    const SizedBox(height: 25),



                    // Promo Code

                    Container(

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(

                            children: [

                              const Icon(Icons.sell_outlined, color: Color(0xFF0F8A9E), size: 16),

                              const SizedBox(width: 8),

                              const Text('PROMO CODE OR GIFT CARD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                            ],

                          ),

                          const SizedBox(height: 12),

                          Row(

                            children: [

                              Expanded(

                                child: Container(

                                  height: 45,

                                  padding: const EdgeInsets.symmetric(horizontal: 12),

                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF00BCD4))),

                                  child: Row(

                                    children: [

                                      const Icon(Icons.check_circle, color: Color(0xFF0F8A9E), size: 16),

                                      const SizedBox(width: 8),

                                      const Text('ECOMEMBER10', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),

                                    ],

                                  ),

                                ),

                              ),

                              const SizedBox(width: 10),

                              Container(

                                height: 45, padding: const EdgeInsets.symmetric(horizontal: 20),

                                alignment: Alignment.center,

                                decoration: BoxDecoration(color: const Color(0xFF16161D), borderRadius: BorderRadius.circular(12)),

                                child: const Text('Applied', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),

                              )

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),



                    // Live Bag Calculation

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Text('LIVE BAG CALCULATION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                          const SizedBox(height: 15),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal (2 items)', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.check, color: Color(0xFF0F8A9E), size: 14), const SizedBox(width: 6), Text('Standard Eco Delivery', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13))]), Text(shipping == 0 ? 'FREE' : '+\$${shipping.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.local_offer, color: Color(0xFF0F8A9E), size: 14), const SizedBox(width: 6), Text('Eco Member Discount (-10%)', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13))]), const Text('-\$4.50', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 15),

                          Row(

                            children: List.generate(40, (index) => Expanded(child: Container(color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300, height: 1))),

                          ),

                          const SizedBox(height: 15),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                                  const SizedBox(height: 2),

                                  Text('Taxes & import duties included', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),

                                ],

                              ),

                              const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 15),

                    

                    // Free shipping banner

                    Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        const Icon(Icons.local_shipping, color: Colors.orange, size: 16),

                        const SizedBox(width: 6),

                        RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12), children: [TextSpan(text: 'You unlocked '), TextSpan(text: 'Free Eco Shipping', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: '!')])),

                        const SizedBox(width: 10),

                        const Text('Saved \$6.99', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 11, fontWeight: FontWeight.bold)),

                      ],

                    ),

                    const SizedBox(height: 20),

                  ],

                ),

              ),

            ),

            

            // Bottom Action Bar

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

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 16)),

                          const Text('Update & Return to\nCheckout', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, height: 1.2)),

                          Row(

                            children: [

                              const Text('\$40.50', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),

                              const SizedBox(width: 6),

                              const Icon(Icons.arrow_forward, color: Colors.white, size: 16),

                            ],

                          )

                        ],

                      ),

                    ),

                  ),

                  const SizedBox(height: 12),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      Icon(Icons.lock, color: Colors.grey.shade400, size: 12),

                      const SizedBox(width: 6),

                      Text('Changes automatically update your checkout summary', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),

                    ],

                  )

                ],

              ),

            )

          ],

        ),

      ),

    );

  }



  Widget _buildEditableItem({

    required IconData icon, required Color iconColor, required String badgeText, Color badgeColor = const Color(0xFF0F8A9E),

    required String title, required String desc, required Color statusColor, required String statusText, required String price,

    required List<String> sizeList, required String selectedSize, required Function(String) onSizeChanged,

    required String colorName, required List<Color> colorList, required int selectedColorIdx, required Function(int) onColorChanged,

    required int qty, required VoidCallback onQtyAdd, required VoidCallback onQtySub,

  }) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Stack(

                clipBehavior: Clip.none,

                children: [

                  Container(

                    width: 60, height: 60,

                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),

                    child: Icon(icon, color: iconColor, size: 30),

                  ),

                  Positioned(

                    bottom: -5, right: -5,

                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),

                      decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),

                      child: Text(badgeText, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),

                    ),

                  )

                ],

              ),

              const SizedBox(width: 15),

              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),

                        Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                      ],

                    ),

                    const SizedBox(height: 4),

                    Text(desc, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                    const SizedBox(height: 8),

                    Row(

                      children: [

                        Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),

                        const SizedBox(width: 4),

                        Text(statusText, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),

                      ],

                    )

                  ],

                ),

              )

            ],

          ),

          const SizedBox(height: 20),

          

          // Size

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Row(

                children: [

                  const Text('SIZE SELECTED: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),

                  Text(selectedSize, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F8A9E))),

                ],

              ),

              const Text('Size Guide', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 11, decoration: TextDecoration.underline)),

            ],

          ),

          const SizedBox(height: 10),

          Row(

            children: sizeList.map((s) {

              bool isSel = s == selectedSize;

              return Expanded(

                child: GestureDetector(

                  onTap: () => onSizeChanged(s),

                  child: Container(

                    margin: const EdgeInsets.only(right: 8),

                    padding: const EdgeInsets.symmetric(vertical: 8),

                    alignment: Alignment.center,

                    decoration: BoxDecoration(

                      color: isSel ? const Color(0xFF0F8A9E) : Colors.white,

                      border: Border.all(color: isSel ? const Color(0xFF0F8A9E) : Colors.grey.shade300),

                      borderRadius: BorderRadius.circular(12),

                    ),

                    child: Text(s, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: isSel ? FontWeight.bold : FontWeight.normal, fontSize: 12)),

                  ),

                ),

              );

            }).toList(),

          ),

          const SizedBox(height: 20),



          // Color

          Row(

            children: [

              const Text('COLOR: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),

              Text(colorName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),

            ],

          ),

          const SizedBox(height: 10),

          Row(

            children: List.generate(colorList.length, (idx) {

              bool isSel = idx == selectedColorIdx;

              return GestureDetector(

                onTap: () => onColorChanged(idx),

                child: Container(

                  margin: const EdgeInsets.only(right: 12),

                  padding: const EdgeInsets.all(2),

                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSel ? const Color(0xFF0F8A9E) : Colors.transparent, width: 1.5)),

                  child: Container(

                    width: 24, height: 24,

                    decoration: BoxDecoration(color: colorList[idx], shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                    child: isSel ? const Icon(Icons.check, color: Colors.white, size: 14) : null,

                  ),

                ),

              );

            }),

          ),

          const SizedBox(height: 20),

          Divider(height: 1, color: Colors.grey.shade100),

          const SizedBox(height: 15),



          // Actions

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Container(

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                child: Row(

                  children: [

                    InkWell(onTap: onQtySub, borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Icon(Icons.remove, size: 16, color: Colors.grey.shade600))),

                    Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                    InkWell(onTap: onQtyAdd, borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Icon(Icons.add, size: 16, color: Colors.grey.shade600))),

                  ],

                ),

              ),

              Row(

                children: [

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                  const SizedBox(width: 8),

                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.delete_outline, color: Colors.red.shade400, size: 18)),

                ],

              )

            ],

          )

        ],

      ),

    );

  }

}
