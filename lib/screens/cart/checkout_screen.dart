import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/order_service.dart';
import 'package:cesc_commerce/core/services/cart_service.dart';


class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  const CheckoutScreen({super.key, required this.items});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {

  String selectedShipping = 'Standard Eco';
  String _selectedPaymentMethod = '';
  bool _isPlacingOrder = false;

  @override
  void initState() {
    super.initState();
    final defaultCard = globalSavedCards.value.firstWhere(
      (c) => c['isDefault'] == true,
      orElse: () => globalSavedCards.value.isNotEmpty ? globalSavedCards.value.first : <String, dynamic>{},
    );
    _selectedPaymentMethod = defaultCard['title'] ?? 'Visa ending in 4242';
  }

  @override

  Widget build(BuildContext context) {
    double subtotal = 0.0;
    for (var i in widget.items) {
      final priceStr = i['price']?.toString().replaceAll(r'$', '').trim() ?? '0';
      final price = double.tryParse(priceStr) ?? 0.0;
      final qty = (i['qty'] as num?)?.toInt() ?? 1;
      subtotal += price * qty;
    }
    Map<String, double> shippingCosts = {'Standard Eco': 0.0, 'Express': 12.99, 'Overnight': 24.99};
  double shipping = shippingCosts[selectedShipping] ?? 0.0;
    double discount = subtotal * 0.10;
    double total = subtotal + shipping - discount;

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

                      const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('NEW ORDER', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade100)),

                    child: const Row(

                      children: [

                        Icon(Icons.lock, color: Colors.green, size: 12),

                        SizedBox(width: 4),

                        Text('Secure', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),

                      ],

                    ),

                  ),

                ],

              ),

            ),



            // 2. Progress Bar

            Container(

              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

              padding: const EdgeInsets.symmetric(vertical: 15),

              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14)),

                  const SizedBox(width: 6),

                  const Text('Cart', style: TextStyle(color: Colors.grey, fontSize: 12)),

                  const SizedBox(width: 10),

                  Container(width: 20, height: 2, color: const Color(0xFF00BCD4)),

                  const SizedBox(width: 10),

                  Container(width: 24, height: 24, alignment: Alignment.center, decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),

                  const SizedBox(width: 6),

                  const Text('Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                  const SizedBox(width: 10),

                  Container(width: 20, height: 2, color: Colors.grey.shade200),

                  const SizedBox(width: 10),

                  Container(width: 24, height: 24, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: Text('3', style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold))),

                  const SizedBox(width: 6),

                  Text('Payment', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),

                ],

              ),

            ),



            // Scrollable Content

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // 3. Delivery Address

                    Row(

                      children: [

                        const Text('Delivery Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                        const SizedBox(width: 10),

                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),

                        const Spacer(),

                        GestureDetector(

                          onTap: () async {
                            final selected = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen()));
                            if (selected != null) {
                              globalSelectedAddressIndex.value = selected;
                            }
                          },

                          child: const Text('Change', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13, fontWeight: FontWeight.bold)),

                        ),

                      ],

                    ),

                    const SizedBox(height: 15),

                    ValueListenableBuilder<int>(
                      valueListenable: globalSelectedAddressIndex,
                      builder: (context, val, child) {
                        return ValueListenableBuilder<List<Map<String, dynamic>>>(
                          valueListenable: globalAddresses,
                          builder: (context, addresses, child) {
                            if (addresses.isEmpty || val < 0 || val >= addresses.length) {
                              return GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen())),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                                  child: Row(
                                    children: [
                                      Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), child: const Icon(Icons.location_off, color: Colors.red, size: 20)),
                                      const SizedBox(width: 15),
                                      const Expanded(
                                        child: Text('No delivery address selected. Tap to add.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            final _selectedAddr = val >= 0 && val < addresses.length ? addresses[val] : null;
                            return Container(

                              padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

                          child: Column(

                            children: [

                              Row(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.location_on, color: Color(0xFF00BCD4), size: 20)),

                                  const SizedBox(width: 15),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Row(
                                          children: [
                                            Text(_selectedAddr?['title'] ?? 'Home Address', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                            const SizedBox(width: 6),
                                            if (_selectedAddr?['isDefault'] == true) Text('• Primary', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        RichText(text: TextSpan(style: const TextStyle(fontSize: 13, color: Colors.black87), children: [TextSpan(text: '${_selectedAddr?['name'] ?? 'Cesc Fabregas'} ', style: const TextStyle(fontWeight: FontWeight.w600)), TextSpan(text: _selectedAddr?['phone'] ?? '(+1858-555-0192)', style: TextStyle(color: Colors.grey.shade500))])),
                                        const SizedBox(height: 4),
                                        Text(_selectedAddr?['address'] ?? '123 Main Street, Apt 4B, San Diego, CA 92101', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                                      ],

                                    ),

                                  ),

                                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),

                                ],

                              ),

                              const SizedBox(height: 15),

                              Container(

                                padding: const EdgeInsets.only(top: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),

                                child: Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [

                                    Row(

                                      children: [

                                        const Icon(Icons.access_time, color: Color(0xFF0F8A9E), size: 16),

                                        const SizedBox(width: 6),

                                        RichText(text: TextSpan(style: TextStyle(color: Colors.grey.shade600, fontSize: 12), children: [const TextSpan(text: 'Delivery by '), const TextSpan(text: 'Tomorrow, 14:00', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))])),

                                      ],

                                    ),

                                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('Fast Transit', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))),

                                  ],

                                ),

                              )

                            ],

                          ),

                            );
                          }
                        );
                      }
                    ),

                    const SizedBox(height: 25),



                    // 4. Shipping Method

                    const Text('Shipping Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 15),

                    Row(

                      children: [

                        Expanded(

                          child: GestureDetector(

                            onTap: () => setState(() => selectedShipping = 'Standard Eco'),

                            child: Container(

                              padding: const EdgeInsets.all(15),

                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selectedShipping == 'Standard Eco' ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: selectedShipping == 'Standard Eco' ? 1.5 : 1)),

                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      const Text('Standard Eco', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                      Icon(selectedShipping == 'Standard Eco' ? Icons.check_circle : Icons.circle_outlined, color: selectedShipping == 'Standard Eco' ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 18),

                                    ],

                                  ),

                                  const SizedBox(height: 6),

                                  Text('2-3 Business Days', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                  const SizedBox(height: 10),

                                  Text(shippingCosts['Standard Eco'] == 0 ? 'FREE' : '+\$${shippingCosts['Standard Eco']?.toStringAsFixed(2)}', style: TextStyle(color: shippingCosts['Standard Eco'] == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),

                                ],

                              ),

                            ),

                          ),

                        ),

                        const SizedBox(width: 15),

                        Expanded(

                          child: GestureDetector(

                            onTap: () => setState(() => selectedShipping = 'Express'),

                            child: Container(

                              padding: const EdgeInsets.all(15),

                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selectedShipping == 'Express' ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: selectedShipping == 'Express' ? 1.5 : 1)),

                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      const Text('Express', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                      Icon(selectedShipping == 'Express' ? Icons.check_circle : Icons.circle_outlined, color: selectedShipping == 'Express' ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 18),

                                    ],

                                  ),

                                  const SizedBox(height: 6),

                                  Text('Next Day by 10 AM', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                  const SizedBox(height: 10),

                                  Text(shippingCosts['Express'] == 0 ? 'FREE' : '+\$${shippingCosts['Express']?.toStringAsFixed(2)}', style: TextStyle(color: shippingCosts['Express'] == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),

                                ],

                              ),

                            ),

                          ),

                        ),

                      ],

                    ),

                    const SizedBox(height: 25),



                    // 5. Payment Method

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentScreen(total: total)));
                            if (result is String && result.isNotEmpty) {
                              setState(() => _selectedPaymentMethod = result);
                            }
                          },
                          child: const Text('Manage', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13, fontWeight: FontWeight.bold)),

                        ),

                      ],

                    ),

                    const SizedBox(height: 15),

                    Container(

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: Row(

                        children: [

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Row(

                                  children: [

                                    Text(_selectedPaymentMethod, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                                    const SizedBox(width: 8),

                                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),

                                  ],

                                ),

                              ],

                            ),

                          ),

                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),

                        ],

                      ),

                    ),

                    const SizedBox(height: 10),

                    Container(

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(color: const Color(0xFF16161D), borderRadius: BorderRadius.circular(20)),

                      child: Row(

                        children: [

                          const Icon(Icons.apple, color: Colors.white, size: 30),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Apple Pay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),

                                const SizedBox(height: 2),

                                Text('1-Touch Instant Checkout Enabled', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                              ],

                            ),

                          ),

                          Row(

                            children: [

                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                              const SizedBox(width: 4),

                              const Text('Ready', style: TextStyle(color: Colors.green, fontSize: 12)),

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),



                    // 6. Order Items

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('Order Items (${widget.items.length})', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                        GestureDetector(

                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditBagScreen())),

                          child: Text('Edit Bag', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.bold)),

                        ),

                      ],

                    ),

                    const SizedBox(height: 15),

                    ...widget.items.map((item) {
                      double itemPrice = 0.0;
                      if (item['price'] is String) {
                        itemPrice = double.tryParse(item['price'].toString().replaceAll('\$', '').trim()) ?? 0.0;
                      } else if (item['price'] is num) {
                        itemPrice = item['price'].toDouble();
                      }
                      return _buildOrderItemCard(Icons.shopping_bag, item['title'] ?? 'Product', 'Qty: ${item['qty']}', '\$${(itemPrice * ((item['qty'] as num?)?.toInt() ?? 1)).toStringAsFixed(2)}');
                    }).toList(),

                    const SizedBox(height: 25),



                    // 7. Summary

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: Column(

                        children: [

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), Text('\$${subtotal.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Delivery Fee', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), Text(shipping == 0 ? 'FREE' : '+\$${shipping.toStringAsFixed(2)}', style: TextStyle(color: shipping == 0 ? Colors.green : Colors.black, fontWeight: FontWeight.bold, fontSize: 13))]),

                          const SizedBox(height: 12),

                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.local_offer, color: Colors.green, size: 14), const SizedBox(width: 6), Text('Eco Member Discount (-10%)', style: TextStyle(color: Colors.green.shade600, fontSize: 13))]), Text('-\$${discount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))]),

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

                                  const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 2), Text('Includes all local taxes & duties', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)), ], ), Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),

                            ],

                          )

                        ],

                      ),

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
                      onPressed: _isPlacingOrder ? null : () async {
                        if (globalAddresses.value.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No delivery address selected')));
                          return;
                        }
                        final val = globalSelectedAddressIndex.value;
                        final _selectedAddr = val >= 0 && val < globalAddresses.value.length ? globalAddresses.value[val] : null;
                        if (_selectedAddr == null) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an address')));
                          return;
                        }
                        setState(() {
                          _isPlacingOrder = true;
                        });
                        try {
                          await OrderService().placeOrder({
                            'items': widget.items,
                            'total': total,
                            'address': _selectedAddr,
                            'paymentMethod': _selectedPaymentMethod
                          });
                          await CartService().clearCart();
                          if (mounted) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen()));
                          }
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to place order: $e')));
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isPlacingOrder = false;
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: _isPlacingOrder 
                          ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.shield, color: Colors.white, size: 18),
                                    SizedBox(width: 8),
                                    Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), 
                                    const SizedBox(width: 8), 
                                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
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

                      Text('100% Secure 256-bit Encrypted Checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

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



  Widget _buildOrderItemCard(IconData icon, String title, String subtitle, String price, {Color iconColor = Colors.grey}) {

    return Container(

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),

      child: Row(

        children: [

          Container(

            padding: const EdgeInsets.all(15),

            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),

            child: Icon(icon, color: iconColor == Colors.grey ? Colors.blueGrey.shade700 : iconColor, size: 24),

          ),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                const SizedBox(height: 4),

                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

              ],

            ),

          ),

          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

        ],

      ),

    );

  }

}
