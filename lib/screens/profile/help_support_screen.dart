import 'package:cesc_commerce/core/localization.dart';
import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});
  

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  final Map<int, bool> _faqExpanded = {0: false, 1: false, 2: false};
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedFaqCategory = 'All';

  final List<Map<String, String>> faqData = [
    {
      'question': 'How do I track my order in real-time?',
      'answer': 'Navigate to My Orders > Select your active purchase > Tap Track Shipment to see live carrier coordinates and estimated doorstep arrival.',
      'category': 'orders_shipping'
    },
    {
      'question': 'What is your return policy?',
      'answer': 'You can return any unworn item within 30 days of receipt. Visit the Returns Center to print a free shipping label.',
      'category': 'payments_refunds'
    },
    {
      'question': 'Can I change my delivery address?',
      'answer': 'You can update your delivery instructions or address directly in the chat with our support agents before the order ships.',
      'category': 'orders_shipping'
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFaqData = faqData.where((faq) {
      if (_selectedFaqCategory != 'All' && faq['category'] != _selectedFaqCategory) return false;
      if (_searchCtrl.text.isNotEmpty && !faq['question']!.toLowerCase().contains(_searchCtrl.text.toLowerCase()) && !faq['answer']!.toLowerCase().contains(_searchCtrl.text.toLowerCase())) return false;
      return true;
    }).toList();

    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, _, __) {
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

                    Text(tr('help_support_title'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(

                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen())),

                      child: Container(

                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                        child: Stack(

                          clipBehavior: Clip.none,

                          children: [

                            const Icon(Icons.chat_outlined, size: 20, color: Color(0xFF0F8A9E)),

                            Positioned(

                              right: -2, top: -2,

                              child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))

                            )

                          ]

                        )

                      ),

                    ),

                  ],

                ),

              ),



              // 2. Search Bar

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Container(

                  height: 48,

                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),

                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(

                      hintText: 'Search FAQ, topics, orders, refunds...',

                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),

                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),

                      suffixIcon: Icon(Icons.mic_none, color: Colors.grey.shade400, size: 20),

                      border: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(vertical: 14)

                    ),

                  ),

                ),

              ),

              const SizedBox(height: 20),



              // 3. Gradient Banner

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  gradient: const LinearGradient(colors: [Color(0xFF26D0CE), Color(0xFF0072FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [BoxShadow(color: const Color(0xFF26D0CE).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                         Container(

                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),

                           child: Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('24/7 Live Support', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))])

                         ),

                         const Text('Wait time: ~2m', style: TextStyle(color: Colors.white, fontSize: 12))

                      ]

                    ),

                    const SizedBox(height: 15),

                    Text(tr('how_can_we_help'), style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 8),

                    const Text('Reach out directly or explore quick answers to\nresolve order and account questions.', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),

                    const SizedBox(height: 25),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                         _buildContactOption(Icons.chat_bubble_outline, 'Live Chat', 'Online Now', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen()))),

                         _buildContactOption(Icons.phone_outlined, 'Call Center', 'Toll Free', onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Calling: 1-800-CESC-SHOP')))),

                         _buildContactOption(Icons.mail_outline, 'Email', 'Response <4h', onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email: support@cesccommerce.com')))),

                      ]

                    )

                  ]

                )

              ),

              const SizedBox(height: 30),



              // 4. MY SUPPORT TICKET

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Row(

                      children: [

                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F8A9E), shape: BoxShape.circle)),

                        const SizedBox(width: 8),

                        Text(tr('my_support_ticket'), style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

                      ],

                    ),

                    const Text('History', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),

                  ],

                ),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      children: [

                        const Text('#TK-4821', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                        const SizedBox(width: 8),

                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text(tr('in_progress'), style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),

                      ]

                    ),

                    const SizedBox(height: 12),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        const Expanded(child: Text('Shipping delay query on #ORD-9284', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500))),

                        Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade400))

                      ]

                    ),

                    const SizedBox(height: 12),

                    Text('Updated 2 hours ago • Assigned to Sarah M.', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                  ]

                )

              ),

              const SizedBox(height: 30),



              // 5. Explore FAQ

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                     Text(tr('explore_faq'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

                     Text(tr('browse_categories'), style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),

                  ]

                )

              ),

              const SizedBox(height: 15),

              SizedBox(

                height: 35,

                child: ListView(

                  scrollDirection: Axis.horizontal,

                  padding: const EdgeInsets.symmetric(horizontal: 20),

                  children: [

                     GestureDetector(
                       onTap: () => setState(() => _selectedFaqCategory = 'All'),
                       child: Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 20), alignment: Alignment.center, decoration: BoxDecoration(color: _selectedFaqCategory == 'All' ? const Color(0xFF0F8A9E) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: _selectedFaqCategory == 'All' ? Colors.transparent : Colors.grey.shade200)), child: Text('All', style: TextStyle(color: _selectedFaqCategory == 'All' ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12)))
                     ),

                     GestureDetector(
                       onTap: () => setState(() => _selectedFaqCategory = 'orders_shipping'),
                       child: Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: _selectedFaqCategory == 'orders_shipping' ? const Color(0xFF0F8A9E) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: _selectedFaqCategory == 'orders_shipping' ? Colors.transparent : Colors.grey.shade200)), child: Text(tr('orders_shipping'), style: TextStyle(color: _selectedFaqCategory == 'orders_shipping' ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12)))
                     ),

                     GestureDetector(
                       onTap: () => setState(() => _selectedFaqCategory = 'payments_refunds'),
                       child: Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: _selectedFaqCategory == 'payments_refunds' ? const Color(0xFF0F8A9E) : Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: _selectedFaqCategory == 'payments_refunds' ? Colors.transparent : Colors.grey.shade200)), child: Text(tr('payments_refunds'), style: TextStyle(color: _selectedFaqCategory == 'payments_refunds' ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12)))
                     ),

                  ]

                )

              ),

              const SizedBox(height: 15),



              // FAQ Accordion Card

              ...filteredFaqData.map((item) {
                int originalIndex = faqData.indexOf(item);
                return Column(
                  children: [
                    _buildFaqItem(originalIndex, item['question']!, item['answer']!),
                    const SizedBox(height: 12),
                  ],
                );
              }),

              const SizedBox(height: 60),

            ]

          )

        )

      )

        );
      }
    );
  }


  Widget _buildContactOption(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {

    return Expanded(

      child: GestureDetector(
        onTap: onTap,
        child: Container(

          margin: const EdgeInsets.symmetric(horizontal: 4),

          padding: const EdgeInsets.symmetric(vertical: 12),

          decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),

          child: Column(

            children: [

               Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, color: const Color(0xFF0072FF), size: 18)),

               const SizedBox(height: 8),

               Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),

               const SizedBox(height: 2),

               Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 9)),

            ]

          )

          ),
      ),
    );

  }

  Widget _buildFaqItem(int index, String question, String answer) {
    bool isExpanded = _faqExpanded[index] ?? false;
    return GestureDetector(
      onTap: () {
        setState(() {
          _faqExpanded[index] = !isExpanded;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.access_time, color: Color(0xFF0F8A9E), size: 16)),
                const SizedBox(width: 15),
                Expanded(child: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.4))),
                const SizedBox(width: 10),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: const Color(0xFF0F8A9E), size: 20)
              ]
            ),
            if (isExpanded) ...[
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(answer, style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.6))
              )
            ]
          ]
        )
      ),
    );
  }
}
