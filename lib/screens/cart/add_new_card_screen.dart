import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class AddNewCardScreen extends StatefulWidget {

  final double total;
  const AddNewCardScreen({super.key, this.total = 0.0});

  @override State<AddNewCardScreen> createState() => _AddNewCardScreenState();

}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  final TextEditingController expCtrl = TextEditingController();
  final TextEditingController cvvCtrl = TextEditingController();
  bool isSameAddress = true;

  bool saveCard = true;

  bool setAsDefault = true;

  String get _cardType {
    final num = numberCtrl.text.replaceAll(' ', '');
    if (num.startsWith('4')) return 'VISA';
    if (num.startsWith('5')) return 'Mastercard';
    return 'CARD';
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    numberCtrl.dispose();
    expCtrl.dispose();
    cvvCtrl.dispose();
    super.dispose();
  }

  @override Widget build(BuildContext context) {

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

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),

                  ),

                  Column(

                    children: [

                      const Text('Add New Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('CREDIT OR DEBIT CARD', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.security, color: Color(0xFF0F8A9E), size: 18)),

                ],

              ),

            ),

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Scan Card Banner

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),

                      child: Row(

                        children: [

                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.camera_alt, color: Colors.white, size: 20)),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Scan Your Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                                const SizedBox(height: 2),

                                Text('Auto-fill card details instantly', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),

                              ],

                            ),

                          ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                    // Credit Card UI

                    Container(

                      height: 220, width: double.infinity,

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(20),

                        gradient: const LinearGradient(colors: [Color(0xFF0A4F5C), Color(0xFF00BCD4)], begin: Alignment.topLeft, end: Alignment.bottomRight),

                        boxShadow: [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],

                      ),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Row(

                                children: [

                                  Container(width: 40, height: 30, decoration: BoxDecoration(color: Colors.amber.shade200, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.sim_card, size: 20, color: Colors.black54)),

                                  const SizedBox(width: 10),

                                  const Icon(Icons.wifi, color: Colors.white70, size: 24),

                                ],

                              ),

                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)), child: Text(_cardType, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))),

                            ],

                          ),

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text('CARD NUMBER', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                              const SizedBox(height: 4),

                              Text(numberCtrl.text.isNotEmpty ? numberCtrl.text : '4242   ****   ****   8821', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),

                            ],

                          ),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text('CARD HOLDER', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                  const SizedBox(height: 4),

                                  Text(nameCtrl.text.isNotEmpty ? nameCtrl.text : 'CESC FABREGAS', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                ],

                              ),

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Text('EXPIRES', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                  const SizedBox(height: 4),

                                  Text(expCtrl.text.isNotEmpty ? expCtrl.text : '08/28', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                ],

                              )

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 25),

                    

                    // Form fields

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Text('Cardholder Name *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                          const SizedBox(height: 8),

                          Container(

                            padding: const EdgeInsets.symmetric(horizontal: 15),

                            decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                            child: TextField(controller: nameCtrl, onChanged: (val) => setState(() {}), decoration: const InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', prefixIcon: Icon(Icons.person_outline, size: 20, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: const TextStyle(fontSize: 14)),

                          ),

                          const SizedBox(height: 15),

                          const Text('Card Number *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                          const SizedBox(height: 8),

                          Container(

                            padding: const EdgeInsets.symmetric(horizontal: 15),

                            decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                            child: TextField(controller: numberCtrl, onChanged: (val) => setState(() {}), decoration: InputDecoration(border: InputBorder.none, hintText: '4242 8821 9012 3456', prefixIcon: const Icon(Icons.credit_card, size: 20, color: Colors.grey), prefixIconConstraints: const BoxConstraints(minWidth: 30), suffixIcon: Padding(padding: const EdgeInsets.only(top:12, bottom:12), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8), decoration: const BoxDecoration(color: Color(0xFFE0F7FA), borderRadius: BorderRadius.all(Radius.circular(6))), child: Text(_cardType, style: const TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 10, height: 1.5))))), style: const TextStyle(fontSize: 14)),

                          ),

                          const SizedBox(height: 15),

                          Row(

                            children: [

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    const Text('Expiry Date *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                    const SizedBox(height: 8),

                                    Container(

                                      padding: const EdgeInsets.symmetric(horizontal: 15),

                                      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                                      child: TextField(controller: expCtrl, onChanged: (val) => setState(() {}), decoration: const InputDecoration(border: InputBorder.none, hintText: '08 / 28', prefixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: const TextStyle(fontSize: 14)),

                                    ),

                                  ],

                                ),

                              ),

                              const SizedBox(width: 15),

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [

                                        const Text('CVV / CVC *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                                        Row(children: [const Icon(Icons.help_outline, size: 12, color: Color(0xFF0F8A9E)), const SizedBox(width: 2), const Text('3 digits', style: TextStyle(fontSize: 10, color: Color(0xFF0F8A9E)))])

                                      ],

                                    ),

                                    const SizedBox(height: 8),

                                    Container(

                                      padding: const EdgeInsets.symmetric(horizontal: 15),

                                      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                                      child: TextField(controller: cvvCtrl, obscureText: true, decoration: const InputDecoration(border: InputBorder.none, hintText: '***', prefixIcon: Icon(Icons.lock_outline, size: 18, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: const TextStyle(fontSize: 14, letterSpacing: 2)),

                                    ),

                                  ],

                                ),

                              )

                            ],

                          ),

                          const SizedBox(height: 20),

                          Row(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              GestureDetector(

                                onTap: () => setState(() => isSameAddress = !isSameAddress),

                                child: Container(

                                  width: 18, height: 18, margin: const EdgeInsets.only(top: 2),

                                  decoration: BoxDecoration(color: isSameAddress ? const Color(0xFF0F8A9E) : Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: isSameAddress ? const Color(0xFF0F8A9E) : Colors.grey.shade300)),

                                  child: isSameAddress ? const Icon(Icons.check, color: Colors.white, size: 14) : null,

                                ),

                              ),

                              const SizedBox(width: 10),

                              Expanded(

                                child: RichText(

                                  text: TextSpan(

                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12, height: 1.4),

                                    children: const [

                                      TextSpan(text: 'Billing address is the same as delivery address: '),

                                      TextSpan(text: '123 Main Street, Apt 4B, San Diego', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),

                                    ]

                                  ),

                                ),

                              )

                            ],

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),



                    // Toggles

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text('Save card for future checkouts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                  const SizedBox(height: 4),

                                  Text('Encrypted tokenization via PCI-DSS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                ],

                              ),

                              Switch(value: saveCard, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => saveCard = val)),

                            ],

                          ),

                          const SizedBox(height: 15),

                          Divider(height: 1, color: Colors.grey.shade100),

                          const SizedBox(height: 15),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text('Set as default payment card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                  const SizedBox(height: 4),

                                  Text('Use for 1-click order authorizations', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                ],

                              ),

                              Switch(value: setAsDefault, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => setAsDefault = val)),

                            ],

                          ),

                        ],

                      )

                    ),

                    const SizedBox(height: 25),

                    Center(child: Text('Accepted Networks:  VISA  MC  AMEX', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))),

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
                        if (nameCtrl.text.isEmpty || numberCtrl.text.isEmpty || expCtrl.text.isEmpty || cvvCtrl.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                          return;
                        }
                        String t = 'Card';
                        if(numberCtrl.text.startsWith('4')) t = 'VISA';
                        else if(numberCtrl.text.startsWith('5')) t = 'Mastercard';

                        Navigator.pop(context, {
                          'name': nameCtrl.text, 
                          'number': numberCtrl.text, 
                          'expiry': expCtrl.text, 
                          'type': t,
                          'saveCard': saveCard,
                          'setAsDefault': setAsDefault,
                        });
                      },

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Row(

                            children: [

                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Save & Use Card', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),

                            ],

                          ),

                          Row(

                            children: [

                              Text('\$${widget.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18),

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

                      const Text('256-bit Bank-grade Encryption • PCI-DSS Compliant', style: TextStyle(color: Colors.grey, fontSize: 10)),

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
