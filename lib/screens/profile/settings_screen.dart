import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/widgets.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});



  @override

  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {

  TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    globalLanguage.addListener(_onLangChange);
  }
  
  bool _pushNotif = true;
  bool _trackingAlerts = true;
  bool _promoDeals = false;
  String _currency = 'USD (\$)';

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

                    Text(tr('settings'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                      child: const Icon(Icons.search, size: 20),

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

                      hintText: 'Search preferences, orders, security...',

                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),

                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),

                      border: InputBorder.none,

                      contentPadding: const EdgeInsets.symmetric(vertical: 14)

                    ),

                  ),

                ),

              ),

              const SizedBox(height: 25),



              // 3. Card 1: REGIONAL & PREFERENCES

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Text('REGIONAL & PREFERENCES', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  children: [

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                          builder: (_) => const LanguageSelector(),
                        );
                      },
                      child: _buildSettingsTile(Icons.language, 'Language', 'Application display language', _buildCyanPill(_getLangLabel(globalLanguage.value)), showChevron: true),
                    ),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Select Currency'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ['USD (\$)', 'IDR (Rp)', 'EUR (€)'].map((c) => ListTile(
                                title: Text(c),
                                onTap: () {
                                  setState(() => _currency = c);
                                  Navigator.pop(context);
                                }
                              )).toList(),
                            )
                          )
                        );
                      },
                      child: _buildSettingsTile(Icons.attach_money, 'Currency', 'Pricing and checkout', _buildCyanPill(_currency), showChevron: true),
                    ),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Country selection coming soon')),
                        );
                      },
                      child: _buildSettingsTile(Icons.location_on_outlined, 'Country / Region', 'United States', Text(tr('default'), style: TextStyle(color: Colors.grey.shade400, fontSize: 12)), showChevron: true),
                    ),

                  ],

                ),

              ),

              const SizedBox(height: 25),



              // 4. Card 2: NOTIFICATIONS

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Text('NOTIFICATIONS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  children: [

                    _buildSettingsTile(Icons.notifications_none, 'Push Notifications', 'Order updates and delivery', _buildToggle(_pushNotif, (v) => setState(() => _pushNotif = v)), showChevron: false),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildSettingsTile(Icons.local_shipping_outlined, 'Order Tracking Alerts', 'Real-time shipping notifications', _buildToggle(_trackingAlerts, (v) => setState(() => _trackingAlerts = v)), showChevron: false),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildSettingsTile(Icons.local_offer_outlined, 'Promotions & Deals', 'VIP discounts and seasonal coupons', _buildToggle(_promoDeals, (v) => setState(() => _promoDeals = v)), showChevron: false),

                  ],

                ),

              ),

              const SizedBox(height: 25),



              // 5. Card 3: DISPLAY & APPEARANCE

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 30),

                child: Text('DISPLAY & APPEARANCE', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),

              ),

              const SizedBox(height: 10),

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),

                child: Column(

                  children: [

                    ValueListenableBuilder<ThemeMode>(
                    valueListenable: globalThemeMode,
                    builder: (context, theme, _) {
                      return _buildSettingsTile(Icons.dark_mode_outlined, 'Dark Mode', 'Adjust application theme', _buildToggle(theme == ThemeMode.dark, (v) {
                        globalThemeMode.value = v ? ThemeMode.dark : ThemeMode.light;
                      }), showChevron: false);
                    }
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



  String _getLangLabel(String code) {
    if (code.contains('id') || code.contains('ID')) return 'Indonesia\n(ID)';
    if (code.contains('es') || code.contains('ES')) return 'Español\n(ES)';
    if (code.contains('zh') || code.contains('ZH')) return '中文\n(ZH)';
    return 'English\n(US)';
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle, Widget trailingWidget, {bool showChevron = true}) {

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      child: Row(

        children: [

           Container(

             padding: const EdgeInsets.all(10),

             decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.cyan.shade100)),

             child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),

           ),

           const SizedBox(width: 15),

           Expanded(

             child: Column(

               crossAxisAlignment: CrossAxisAlignment.start,

               children: [

                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                  const SizedBox(height: 2),

                  Text(subtitle, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

               ]

             )

           ),

           trailingWidget,

           if (showChevron) ...[

             const SizedBox(width: 8),

             Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300)

           ]

        ]

      )

    );

  }



  Widget _buildCyanPill(String text) {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),

      child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),

    );

  }



  Widget _buildToggle(bool value, ValueChanged<bool> onChanged) {

    return GestureDetector(

      onTap: () => onChanged(!value),

      child: AnimatedContainer(

        duration: const Duration(milliseconds: 200),

        width: 48, height: 26,

        padding: const EdgeInsets.all(2),

        decoration: BoxDecoration(

          color: value ? Theme.of(context).primaryColor : Colors.grey.shade200,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(color: value ? Theme.of(context).primaryColor : Colors.grey.shade300)

        ),

        child: AnimatedAlign(

          duration: const Duration(milliseconds: 200),

          alignment: value ? Alignment.centerRight : Alignment.centerLeft,

          child: Container(

            width: 20, height: 20,

            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))]),

          )

        )

        ),
      );

  }


  @override
  void dispose() {
    globalLanguage.removeListener(_onLangChange);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onLangChange() {
    if (!mounted) return;
    setState(() {});
  }

}
