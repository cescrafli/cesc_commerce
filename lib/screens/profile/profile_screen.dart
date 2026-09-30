import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/auth_service.dart';
import 'package:cesc_commerce/core/services/user_service.dart';


class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, lang, _) {
        return ValueListenableBuilder<Map<String, dynamic>>(
          valueListenable: UserService.mockProfile,
          builder: (context, userProfile, _) {
            return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [

              // 1. Header

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Navigator.canPop(context) 
                    ? GestureDetector(
                        onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      )
                    : const SizedBox(width: 40),

                    Text(tr('account_profile'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('More options'))),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                        child: const Icon(Icons.more_horiz, size: 20),
                      ),
                    ),

                  ],

                ),

              ),



              // 2. Profile Card

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  gradient: LinearGradient(

                    colors: [Theme.of(context).primaryColor, const Color(0xFF137A8C)], 

                    begin: Alignment.topLeft, end: Alignment.bottomRight

                  ),

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]

                ),

                child: Column(

                  children: [

                    Row(

                      children: [

                        Stack(

                          children: [

                            Container(

                              padding: const EdgeInsets.all(3),

                              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),

                              child: CircleAvatar(radius: 35, backgroundImage: NetworkImage(userProfile['avatar'] ?? 'https://i.pravatar.cc/150?img=11')),

                            ),

                            Positioned(

                              right: 0, bottom: 0,

                              child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen())),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                  child: Icon(Icons.camera_alt, color: Theme.of(context).primaryColor, size: 14)
                                ),
                              )

                            )

                          ]

                        ),

                        const SizedBox(width: 15),

                        Expanded(

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Row(

                                children: [

                                  Text(userProfile['name'] ?? 'User', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),

                                  const SizedBox(width: 5),

                                  const Icon(Icons.verified, color: Colors.orange, size: 16),

                                ]

                              ),

                              const SizedBox(height: 4),

                              Text(userProfile['email'] ?? 'email@example.com', style: TextStyle(color: Colors.white70, fontSize: 12)),

                              const SizedBox(height: 8),

                              Container(

                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white54)),

                                child: const Text('GOLD VIP MEMBER', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))

                              )

                            ]

                          )

                        )

                      ]

                    ),

                    const SizedBox(height: 20),

                    Divider(color: Colors.white.withOpacity(0.2), height: 1),

                    const SizedBox(height: 15),

                    ValueListenableBuilder(
                      valueListenable: globalOrders,
                      builder: (context, orders, _) => ValueListenableBuilder(
                        valueListenable: globalWishlist,
                        builder: (context, wishlist, _) => Row(
                          children: [
                            Expanded(child: Column(children: [Text('${orders.length}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(tr('orders'), style: const TextStyle(color: Colors.white70, fontSize: 12))])),
                            Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2)),
                            Expanded(child: Column(children: [Text('${wishlist.length}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(tr('wishlist'), style: const TextStyle(color: Colors.white70, fontSize: 12))])),
                            Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2)),
                            Expanded(child: Column(children: [Text(globalUser.value?['vouchers']?.toString() ?? '0', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text(tr('vouchers'), style: const TextStyle(color: Colors.white70, fontSize: 12))])),
                          ]
                        ),
                      ),
                    )

                  ]

                )

              ),



              // 3. Menu Group 1

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),

                child: Column(

                  children: [

                    _buildMenuTile(context, Icons.person_outline, tr('personal_info'), tr('personal_info_desc'), null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen()))),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMenuTile(context, Icons.inventory_2_outlined, tr('my_orders'), tr('my_orders_desc'), ValueListenableBuilder(valueListenable: globalOrders, builder: (context, orders, child) { final count = orders.where((o) => o['status'] == 'In Transit').length; return count > 0 ? Container(padding: const EdgeInsets.symmetric(horizontal:8, vertical:2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text('$count In Transit', style: TextStyle(color: Colors.cyan.shade700, fontSize: 12, fontWeight: FontWeight.bold))) : const SizedBox(); }), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen()))),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMenuTile(context, Icons.notifications_none, tr('notifications'), tr('promos_alerts'), ValueListenableBuilder(valueListenable: globalNotifications, builder: (context, notifs, child) { return notifs.any((n) => n['isRead'] == false) ? Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)) : const SizedBox(); }), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()))),

                  ]

                )

              ),



              // 4. Menu Group 2

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),

                child: Column(

                  children: [

                    _buildMenuTile(context, Icons.settings_outlined, tr('settings'), 'Language, currency, privacy', null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMenuTile(context, Icons.payment_outlined, tr('payment_methods'), tr('payment_methods_desc'), _buildPill(context, 'VISA', isCyan: false), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentMethodsScreen()))),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMenuTile(context, Icons.help_outline, tr('help_support'), tr('faq_desc'), null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen()))),

                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),

                    _buildMenuTile(context, Icons.logout, tr('logout'), tr('sign_out_desc'), null, isLogout: true, onTap: () async {
                      await AuthService().signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                      }
                    }),

                  ]

                )

              ),

              const SizedBox(height: 80),

            ],

          ),

        ),

      )

    );
          },
        );
      },
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, String subtitle, Widget? trailingExtra, {bool isLogout = false, VoidCallback? onTap}) {

    return Material(

      color: Colors.transparent,

      child: ListTile(

        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),

        leading: Container(

          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(color: isLogout ? Colors.red.shade50 : Colors.cyan.shade50, shape: BoxShape.circle),

          child: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF0F8A9E)),

        ),

        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isLogout ? Colors.red : Colors.black87)),

        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),

        trailing: Row(

          mainAxisSize: MainAxisSize.min,

          children: [

            if (trailingExtra != null) ...[trailingExtra, const SizedBox(width: 10)],

            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),

          ],

        ),

        onTap: onTap ?? () {},

      ),

    );

  }



  Widget _buildPill(BuildContext context, String text, {required bool isCyan}) {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      decoration: BoxDecoration(color: isCyan ? Colors.cyan.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),

      child: Text(text, style: TextStyle(color: isCyan ? const Color(0xFF0F8A9E) : Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold)),

    );

  }

}
