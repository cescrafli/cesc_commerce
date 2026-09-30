import 'package:cesc_commerce/core/localization.dart';
import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/core/services/notification_service.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/screens/profile/my_orders_screen.dart';
import 'package:cesc_commerce/widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';
  @override
  void initState() {
    super.initState();
    _refreshNotifications();
  }

  void _refreshNotifications() {
    NotificationService().getNotifications();
  }

  Widget _buildChip(String label, String filterKey, int? count) {
    bool isSelected = _selectedFilter == filterKey;
    String displayLabel = count != null ? '$label ($count)' : label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = filterKey;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00BCD4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: Colors.grey.shade200),
          boxShadow: isSelected
              ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]
              : null,
        ),
        child: Text(
          displayLabel,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildNotifCard(BuildContext context, Map<String, dynamic> n) {
    final type = n['type'] as String? ?? 'general';
    final title = n['title'] as String? ?? '';
    final bodyText = n['body'] as String? ?? '';
    final time = n['time'] as String? ?? '';
    final isRead = n['isRead'] as bool? ?? true;
    final id = n['id']?.toString() ?? '';

    Widget iconBox;
    Widget? actionButton;

    if (type == 'order') {
      iconBox = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.cyan.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.local_shipping_outlined, color: Color(0xFF00BCD4), size: 24),
      );
      actionButton = GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Text(tr('track_order'), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10),
            ],
          ),
        ),
      );
    } else if (type == 'promo') {
      iconBox = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.local_fire_department_outlined, color: Colors.orange, size: 24),
      );
      actionButton = GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoryListScreen()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFF0B1221), borderRadius: BorderRadius.circular(20)),
          child: Text(tr('shop_deals'), style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      );
    } else if (type == 'account') {
      iconBox = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.person_outline, color: Colors.green, size: 24),
      );
      actionButton = null;
    } else {
      iconBox = Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.notifications_outlined, color: Colors.grey, size: 24),
      );
      actionButton = null;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: !isRead ? const Color(0xFF00BCD4).withOpacity(0.3) : Colors.grey.shade100,
          width: !isRead ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          iconBox,
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
                    if (!isRead)
                      GestureDetector(
                        onTap: () async {
                          await NotificationService().markAsRead(id);
                          if (!mounted) return;
                          _refreshNotifications();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 4, left: 10),
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF75555),
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(bodyText, style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    actionButton ?? const SizedBox(),
                    Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FA),
          body: SafeArea(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: globalNotifications,
              builder: (context, notifications, _) {
                final unreadCount = notifications.where((n) => n['isRead'] == false).length;
                final filtered = notifications.where((n) {
                  if (_selectedFilter == 'All') return true;
                  if (_selectedFilter == 'Orders') return n['type'] == 'order';
                  if (_selectedFilter == 'Promos') return n['type'] == 'promo';
                  if (_selectedFilter == 'Account') return n['type'] == 'account';
                  return true;
                }).toList();

                return Column(
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
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: const Icon(Icons.arrow_back_ios_new, size: 18),
                            ),
                          ),
                          Row(
                            children: [
                              Text(tr('notifications'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              if (unreadCount > 0) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00BCD4),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '$unreadCount New',
                                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              await NotificationService().markAllAsRead();
                              if (!mounted) return;
                              _refreshNotifications();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: const Icon(Icons.check, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. Chips
                    SizedBox(
                      height: 35,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          _buildChip('All', 'All', notifications.length),
                          _buildChip(tr('orders'), 'Orders', null),
                          _buildChip(tr('promos_deals'), 'Promos', null),
                          _buildChip(tr('account'), 'Account', null),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 3. List
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(child: Text('No notifications', style: TextStyle(color: Colors.grey.shade500)))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                return _buildNotifCard(context, filtered[index]);
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
