import re

with open('lib/screens/profile/my_orders_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/order_service.dart';\n"
if 'order_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

old_list = '''ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: globalOrders,
                builder: (context, orders, child) {
                  if (orders.isEmpty) {
                    return Center(child: Text(tr('no_orders_yet'), style: TextStyle(color: Colors.grey)));
                  }
                  
                  final selectedStatus = tabs[_selectedTabIndex]['name'];
                  final filtered = orders.where((o) {
                    if (selectedStatus == 'All') return o['status'] == 'Pending'; // BUG: Only shows Pending instead of all!
                    return o['status'] == selectedStatus;
                  }).toList();

                  if (filtered.isEmpty) {
                    return Center(child: Text('No \ orders.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final order = filtered[index];
                      final items = (order['items'] as List?) ?? [];
                      final firstItem = items.isNotEmpty ? items[0] : {};
                      return _buildOrderCard(
                        id: order['id'] ?? '#ORD',
                        date: order['date'] != null ? order['date'].toString().split(' ')[0] : 'Unknown',
                        status: order['status'] ?? 'Pending',
                        total: order['total']?.toString() ?? '0',
                        itemCount: items.length,
                        firstItemImage: firstItem['image'] ?? 'https://picsum.photos/100',
                        firstItemName: firstItem['title'] ?? 'Product',
                      );
                    }
                  );
                }
              )'''

new_list = '''FutureBuilder<List<Map<String, dynamic>>>(
                future: OrderService().getOrders(status: tabs[_selectedTabIndex]['name'] == 'All' ? null : tabs[_selectedTabIndex]['name']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text(tr('no_orders_yet'), style: const TextStyle(color: Colors.grey)));
                  }
                  
                  final filtered = snapshot.data!;

                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final order = filtered[index];
                      final items = (order['items'] as List?) ?? [];
                      final firstItem = items.isNotEmpty ? items[0] : {};
                      return _buildOrderCard(
                        id: order['id'] ?? '#ORD',
                        date: order['date'] != null ? order['date'].toString().split(' ')[0] : 'Unknown',
                        status: order['status'] ?? 'Pending',
                        total: order['total']?.toString() ?? '0',
                        itemCount: items.length,
                        firstItemImage: firstItem['image'] ?? 'https://picsum.photos/100',
                        firstItemName: firstItem['title'] ?? 'Product',
                      );
                    }
                  );
                }
              )'''

# Wait, the string interpolation \ in old code could cause issues.
new_list = new_list.replace('\\\$', '$')

content = content.replace(old_list, new_list)

# Fix onTap on tab to use setState properly so FutureBuilder rebuilds
old_tab_tap = '''onTap: () => setState(() => _selectedTabIndex = index),'''
new_tab_tap = '''onTap: () => setState(() => _selectedTabIndex = index),'''

with open('lib/screens/profile/my_orders_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed my orders')
