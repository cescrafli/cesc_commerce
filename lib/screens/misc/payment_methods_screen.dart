import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class PaymentMethodsScreen extends StatefulWidget {
  

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _selectedMethod = 'Mastercard';
  List<Map<String, dynamic>> savedCards = [];

  @override
  void initState() {
    super.initState();
    savedCards = List<Map<String, dynamic>>.from(globalSavedCards.value);
    final defaultCard = savedCards.firstWhere((c) => c['isDefault'] == true, orElse: () => savedCards.isNotEmpty ? savedCards.first : <String, dynamic>{});
    _selectedMethod = defaultCard['title'] ?? 'Mastercard';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text('Payment Methods', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewCardScreen()));
                        if (result != null) {
                          final raw = result['number']?.toString() ?? '';
                          final last4 = raw.length >= 4 ? raw.substring(raw.length - 4) : raw.padLeft(4, '*');
                          final Map<String, dynamic> newCard = {
                            'id': 'card_${DateTime.now().millisecondsSinceEpoch}',
                            'title': '${result['type'].toString().toUpperCase()} ending in $last4',
                            'subtitle': 'Expires ${result['expiry']} • Credit Card',
                            'last4': last4,
                            'isDefault': result['setAsDefault'] == true,
                            ...Map<String, dynamic>.from(result as Map)
                          };
                          setState(() {
                            if (newCard['isDefault'] == true) {
                              for (var c in savedCards) {
                                c['isDefault'] = false;
                              }
                            }
                            savedCards.add(newCard);
                            globalSavedCards.value = List.from(savedCards);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                        child: const Icon(Icons.add, size: 20),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),



              // 2. DEFAULT PAYMENT Section

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text('DEFAULT PAYMENT', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    Text('Manage', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),

                  ],

                ),

              ),

              const SizedBox(height: 15),



              // Gradient Card

              ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: globalSavedCards,
                builder: (context, cards, child) {
                final defaultCard = cards.firstWhere(
                  (c) => c['isDefault'] == true,
                  orElse: () => cards.isNotEmpty ? cards.first : {},
                );
                final bannerLast4 = defaultCard['last4'] ?? '????';
                final bannerName = (defaultCard['name'] ?? defaultCard['title'] ?? '').toString().toUpperCase();
                final bannerExpiry = defaultCard['expiry'] ?? '--/--';
                final bannerType = (defaultCard['type'] ?? 'CARD').toString().toUpperCase();

                return Container(

                  height: 220,

                  margin: const EdgeInsets.symmetric(horizontal: 20),

                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    gradient: const LinearGradient(colors: [Color(0xFF26D0CE), Color(0xFF0F8A9E)], begin: Alignment.topLeft, end: Alignment.bottomRight),

                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [BoxShadow(color: const Color(0xFF26D0CE).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]

                  ),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                           Row(

                             children: [

                               Container(

                                 width: 42, height: 28,

                                 decoration: BoxDecoration(

                                   color: Colors.amber.shade400,

                                   borderRadius: BorderRadius.circular(6),

                                   border: Border.all(color: Colors.amber.shade200),

                                   boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]

                                 )

                               ),

                               const SizedBox(width: 12),

                               const Icon(Icons.contactless_outlined, color: Colors.white70, size: 24),

                             ]

                           ),

                           Container(

                             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                             decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white30)),

                             child: const Row(children: [Icon(Icons.check, color: Colors.white, size: 12), SizedBox(width: 4), Text('DEFAULT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5))])

                           )

                        ]

                      ),

                      const SizedBox(height: 10),

                      Text('****   ****   ****   $bannerLast4', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),

                      const SizedBox(height: 10),

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [

                           Column(

                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [

                               const Text('CARDHOLDER NAME', style: TextStyle(color: Colors.white70, fontSize: 9, letterSpacing: 1)),

                               const SizedBox(height: 2),

                               Text(bannerName.isEmpty ? 'CARDHOLDER' : bannerName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),

                             ]

                           ),

                           Column(

                             crossAxisAlignment: CrossAxisAlignment.start,

                             children: [

                               const Text('EXPIRES', style: TextStyle(color: Colors.white70, fontSize: 9, letterSpacing: 1)),

                               const SizedBox(height: 2),

                               Text(bannerExpiry, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),

                             ]

                           ),

                           Text(bannerType, style: const TextStyle(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900))

                        ]

                      )

                    ]

                  )

                );
              }),

              const SizedBox(height: 30),



              // 3. SAVED CARDS & METHODS

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Text('SAVED CARDS & METHODS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  children: [

                    ...savedCards.map((card) {
                      return Column(
                        children: [
                          if (savedCards.indexOf(card) > 0) Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                          _buildMethodTile(
                            // icon based on type
                            card['type']?.toString().toLowerCase() == 'visa'
                                ? Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), alignment: Alignment.center, child: Text('VISA', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 11)))
                                : Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle), alignment: Alignment.center, child: SizedBox(width: 24, height: 16, child: Stack(children: [Positioned(left: 0, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.red.withOpacity(0.8), shape: BoxShape.circle))), Positioned(right: 0, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.amber.withOpacity(0.8), shape: BoxShape.circle)))]))),
                            card['title'] ?? 'Card',
                            card['isDefault'] == true ? Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text('Default', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 9, fontWeight: FontWeight.bold))) : null,
                            card['subtitle'] ?? '',
                            card['isDefault'] == true 
                                ? GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) => SafeArea(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(leading: const Icon(Icons.edit), title: const Text('Edit'), onTap: () => Navigator.pop(context)),
                                              ListTile(
                                                leading: const Icon(Icons.delete),
                                                title: const Text('Delete'),
                                                onTap: () {
                                                  Navigator.pop(context); // pop the sheet
                                                  setState(() {
                                                    bool wasDefault = card['isDefault'] == true;
                                                    savedCards.remove(card);
                                                    if (wasDefault && savedCards.isNotEmpty) {
                                                      savedCards[0]['isDefault'] = true;
                                                    }
                                                    globalSavedCards.value = List.from(savedCards);
                                                  });
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment method deleted')));
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Icon(Icons.more_horiz, color: Colors.grey.shade400),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedMethod = card['title'] ?? 'Card';
                                        for (var i = 0; i < savedCards.length; i++) {
                                          savedCards[i]['isDefault'] = (savedCards[i]['id'] == card['id']);
                                        }
                                        globalSavedCards.value = List.from(savedCards);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment method set as default')));
                                    },
                                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)), child: Text('Set\nDefault', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold, height: 1.2))),
                                  )
                          )
                        ]
                      );
                    }).toList(),
                    
                    if (savedCards.isNotEmpty) Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMethodTile(

                      Container(width: 44, height: 44, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), alignment: Alignment.center, child: const Icon(Icons.apple, color: Colors.white, size: 24)),

                      'Apple Pay', 

                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                      '1-Touch Instant Checkout Enabled', 

                      Row(children: [const Text('Ready', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 4), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade300)])

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 30),



              // 4. DIGITAL WALLETS & BANK ACCOUNTS

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Text('DIGITAL WALLETS & BANK ACCOUNTS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  children: [

                    _buildMethodTile(

                      Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), alignment: Alignment.center, child: Text('PP', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))),

                      'PayPal', 

                      null,

                      'cesc.fabregas@clubmail.com', 

                      Row(children: [Text('Connected', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 4), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade300)])

                    ),

                  ],

                ),

              ),

              const SizedBox(height: 60),

            ]

          )

        )

      )

    );

  }



  Widget _buildMethodTile(Widget iconWidget, String title, Widget? titleBadge, String subtitle, Widget trailingWidget, {String methodId = ""}) {
    String id = methodId.isNotEmpty ? methodId : title;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = id;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
             Radio<String>(
               value: id,
               groupValue: _selectedMethod,
               onChanged: (value) {
                 if (value != null) {
                   setState(() {
                     _selectedMethod = value;
                   });
                 }
               },
               activeColor: Theme.of(context).primaryColor,
               visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
             ),
             const SizedBox(width: 12),
             iconWidget,
             const SizedBox(width: 15),
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Row(
                      children: [
                        Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis)),
                        if (titleBadge != null) ...[const SizedBox(width: 6), titleBadge]
                      ]
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                 ]
               )
             ),
             trailingWidget,
          ]
        )
      )
    );
  }

}
