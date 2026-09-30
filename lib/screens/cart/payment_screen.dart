import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class PaymentScreen extends StatefulWidget {
  final double total;
  const PaymentScreen({super.key, this.total = 0.0});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  // Selected Payment Method: 0=Visa, 1=Mastercard, 2=ApplePay, 3=PayPal, 4=COD

  dynamic selectedMethod = 0; 

  bool rememberCheckout = true;

  List<Map<String, dynamic>> _cards = [];

  @override
  void initState() {
    super.initState();
    _cards = globalSavedCards.value.asMap().entries.map((e) => {
      'id': e.key,
      'type': e.value['type'].toString().toUpperCase(),
      'title': '${e.value['type'].toString().toUpperCase()} ending in ${e.value['last4']}',
      'subtitle': 'Expires ${e.value['expiry']} • Credit Card',
    }).toList();
  }

  @override

  Widget build(BuildContext context) {
    double total = widget.total;
    double shipping = 0.0;

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

                    onTap: () {
                      String method = '';
                      try {
                        method = _cards.firstWhere((c) => c['id'] == selectedMethod)['title'];
                      } catch (_) {
                        if (selectedMethod is String) method = selectedMethod;
                        else method = 'Unknown';
                      }
                      Navigator.pop(context, method);
                    },

                    child: Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                      child: const Icon(Icons.arrow_back_ios_new, size: 18),

                    ),

                  ),

                  Expanded(

                    child: Column(

                      children: [

                        const Text('Select Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 2),

                        Text('ORDER #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                      ],

                    ),

                  ),

                  GestureDetector(
                    onTap: () async {
                      final card = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewCardScreen(total: widget.total)));
                      if (card != null) {
                        String last4 = card['number'].toString();
                        if (last4.length > 4) last4 = last4.substring(last4.length - 4);
                        Map<String, dynamic> newCard = {
                          'id': DateTime.now().millisecondsSinceEpoch,
                          'name': card['name'] ?? 'Cardholder',
                          'last4': last4,
                          'expiry': card['expiry'],
                          'type': card['type'],
                          'title': '${card['type']} ending in $last4',
                          'subtitle': 'Expires ${card['expiry']}',
                          'isDefault': card['setAsDefault'] == true
                        };
                        if (newCard['isDefault'] == true) {
                          for (var c in globalSavedCards.value) {
                            c['isDefault'] = false;
                          }
                        }
                        globalSavedCards.value = [...globalSavedCards.value, newCard];
                        setState(() {
                          int newId = _cards.isEmpty ? 10 : _cards.map((c) => c['id'] as int).reduce((a, b) => a > b ? a : b) + 1;
                          _cards.add({
                            'id': newId,
                            'type': card['type'],
                            'title': '${card['type']} ending in $last4',
                            'subtitle': 'Expires ${card['expiry']} • Credit Card',
                          });
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)),
                      child: const Row(
                        children: [
                          Icon(Icons.add, color: Color(0xFF00BCD4), size: 16),
                          SizedBox(width: 4),
                          Text('Add', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )

                ],

              ),

            ),

            

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Checkout Total Banner

                    Container(

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16)),

                      child: Row(

                        children: [

                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF00BCD4), size: 20)),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Checkout Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                              ],

                            ),

                          ),

                          Text('\$${widget.total.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),



                    // SAVED CARDS Section

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('SAVED CARDS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                        Text('${_cards.length} on file', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),

                      ],

                    ),

                    const SizedBox(height: 15),

                    ..._cards.map((c) {
                      if (c['id'] == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildActiveVisaCard(),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildInactiveCard(c['id'], c['title'], c['subtitle'], Icons.circle, Colors.orange, 'Set Default', c['type'] ?? ''),
                      );
                    }).toList(),
                    const SizedBox(height: 3),
                    
                    // Add New Card Button
                    GestureDetector(
                      onTap: () async {
                        final card = await Navigator.push(context, MaterialPageRoute(builder: (_) => AddNewCardScreen(total: widget.total)));
                        if (card != null) {
                          String last4 = card['number'].toString();
                          if (last4.length > 4) last4 = last4.substring(last4.length - 4);
                          Map<String, dynamic> newCard = {
                            'id': DateTime.now().millisecondsSinceEpoch,
                            'name': card['name'] ?? 'Cardholder',
                            'last4': last4,
                            'expiry': card['expiry'],
                            'type': card['type'],
                            'title': '${card['type']} ending in $last4',
                            'subtitle': 'Expires ${card['expiry']}',
                            'isDefault': card['setAsDefault'] == true
                          };
                          if (newCard['isDefault'] == true) {
                            for (var c in globalSavedCards.value) {
                              c['isDefault'] = false;
                            }
                          }
                          globalSavedCards.value = [...globalSavedCards.value, newCard];
                          setState(() {
                            int newId = _cards.isEmpty ? 10 : _cards.map((c) => c['id'] as int).reduce((a, b) => a > b ? a : b) + 1;
                            _cards.add({
                              'id': newId,
                              'type': card['type'],
                              'title': '${card['type']} ending in $last4',
                              'subtitle': 'Expires ${card['expiry']} • Credit Card',
                            });
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100, width: 2, style: BorderStyle.solid)), 
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Color(0xFF0F8A9E), size: 18),
                            SizedBox(width: 8),
                            Text('Add New Credit or Debit Card', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),



                    // EXPRESS & DIGITAL WALLETS

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('EXPRESS & DIGITAL WALLETS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                        Row(

                          children: [

                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                            const SizedBox(width: 4),

                            const Text('Instant', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),

                          ],

                        )

                      ],

                    ),

                    const SizedBox(height: 15),

                    _buildExpressOption('Apple Pay', 'Apple Pay', '1-Touch Instant Checkout Enabled', Icons.apple, Colors.black, 'Ready', Colors.green, const ApplePayScreen()),

                    const SizedBox(height: 12),

                    _buildExpressOption('PayPal', 'PayPal', 'cesc.fabregas@clubmail.com', Icons.paypal, Colors.blue.shade50, 'Connected', const Color(0xFF00BCD4), const PayPalScreen()),

                    const SizedBox(height: 25),



                    // OTHER METHODS

                    Text('OTHER METHODS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                    const SizedBox(height: 15),

                    _buildExpressOption('Cash on Delivery', 'Cash on Delivery', 'Pay upon package arrival', Icons.local_mall_outlined, Colors.orange.shade50, 'Verified Area', Colors.orange, const CODScreen()),

                    

                    const SizedBox(height: 25),

                    

                    // Remember Toggle

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Remember for faster checkout', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),

                                const SizedBox(height: 4),

                                Text('Use ${globalSavedCards.value.isNotEmpty ? '${globalSavedCards.value[0]['type']?.toString().toUpperCase() ?? 'Card'} ${globalSavedCards.value[0]['last4'] ?? ''}' : 'default card'} on future purchases', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                              ],

                            ),

                          ),

                          Switch(value: rememberCheckout, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => rememberCheckout = val)),

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

                      onPressed: () {
                        String method = '';
                        try {
                          method = _cards.firstWhere((c) => c['id'] == selectedMethod)['title'];
                        } catch (_) {
                          if (selectedMethod is String) method = selectedMethod;
                          else method = 'Unknown';
                        }
                        Navigator.pop(context, method);
                      },

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Row(

                            children: [

                              Icon(Icons.verified_user_outlined, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Use Selected Method', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                            ],

                          ),

                          Row(

                            children: [

                              Text('\$${total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18),

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

                      const Icon(Icons.lock_outline, color: Colors.blueGrey, size: 12),

                      const SizedBox(width: 6),

                      Text('256-bit Bank-grade Encryption & PCI-DSS Compliant', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),

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



  Widget _buildActiveVisaCard() {

    bool isSel = selectedMethod == 0;

    // Read real card data from globalSavedCards index 0 (the first/default card)
    final cardData = globalSavedCards.value.firstWhere((c) => c['isDefault'] == true, orElse: () => globalSavedCards.value.isNotEmpty ? globalSavedCards.value.first : {});
    final cardType = (cardData['type'] ?? 'CARD').toString().toUpperCase();
    final cardLast4 = cardData['last4'] ?? '????';
    final cardExpiry = cardData['expiry'] ?? '--/--';
    final cardName = (cardData['name'] ?? '').toString().toUpperCase();

    return GestureDetector(

      onTap: () => setState(() => selectedMethod = 0),

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1),

          boxShadow: isSel ? [BoxShadow(color: Colors.cyan.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))] : [],

        ),

        child: Column(

          children: [

            Row(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),

                const SizedBox(width: 15),

                Container(

                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                  decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),

                  child: Text(cardType, style: const TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 14, fontStyle: FontStyle.italic)),

                ),

                const SizedBox(width: 15),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Flexible(child: Text('$cardType ending in $cardLast4', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis)),

                          Row(

                            children: [

                              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 9, fontWeight: FontWeight.bold))),

                              const SizedBox(width: 5),

                              const Icon(Icons.more_vert, color: Colors.grey, size: 16),

                            ],

                          )

                        ],

                      ),

                      const SizedBox(height: 6),

                      Text('Expires $cardExpiry • Debit Card', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),

                      const SizedBox(height: 4),

                      Text(cardName, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                    ],

                  ),

                )

              ],

            ),

            if (isSel) ...[

              const SizedBox(height: 20),

              Divider(height: 1, color: Colors.grey.shade200),

              const SizedBox(height: 15),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  const Row(

                    children: [

                      Icon(Icons.lock_outline, color: Color(0xFF0F8A9E), size: 16),

                      SizedBox(width: 8),

                      Text('Confirm Security Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), overflow: TextOverflow.ellipsis),
                    ],

                  ),

                  Row(

                    children: [

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                      const SizedBox(width: 10),

                      const Text('Verified', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 12)),

                    ],

                  )

                ],

              )

            ]

          ],

        ),

      ),

    );

  }



  Widget _buildInactiveCard(int index, String title, String sub, IconData icon, Color iconColor, String rightPill, String type) {

    bool isSel = selectedMethod == index;

    return GestureDetector(

      onTap: () => setState(() => selectedMethod = index),

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),

        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),

            const SizedBox(width: 15),

            Container(

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade100)),

              child: type.toUpperCase() == 'VISA'
                  ? const Text('VISA', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12, fontStyle: FontStyle.italic))
                  : Row(

                      mainAxisSize: MainAxisSize.min,

                      children: [

                        Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),

                        Transform.translate(offset: const Offset(-4, 0), child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.amber.withOpacity(0.8), shape: BoxShape.circle))),

                      ],

                    ) 

            ),

            const SizedBox(width: 15),

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                  const SizedBox(height: 6),

                  Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),

                ],

              ),

            ),

            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: Text(rightPill, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))),

          ],

        ),

      ),

    );

  }



  Widget _buildExpressOption(dynamic index, String title, String sub, IconData icon, Color iconBg, String badgeTxt, Color badgeColor, Widget targetScreen) {

    bool isSel = selectedMethod == index;

    return GestureDetector(

      onTap: () {

        setState(() => selectedMethod = index);

        Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));

      },

      child: Container(

        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),

        child: Row(

          children: [

            Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),

            const SizedBox(width: 15),

            Container(

              padding: const EdgeInsets.all(12),

              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),

              child: icon == Icons.paypal 

                  ? const Text('PP', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))

                  : Icon(icon, color: iconBg == Colors.black ? Colors.white : Colors.orange, size: 20),

            ),

            const SizedBox(width: 15),

            Expanded(

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                      const SizedBox(width: 8),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Row(children: [if(badgeTxt == 'Ready') const Icon(Icons.circle, color: Colors.green, size: 6), if(badgeTxt == 'Ready') const SizedBox(width: 4), Text(badgeTxt, style: TextStyle(color: badgeColor, fontSize: 9, fontWeight: FontWeight.bold))])),

                    ],

                  ),

                  const SizedBox(height: 4),

                  Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                ],

              ),

            ),

            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),

          ],

        ),

      ),

    );

  }

}
