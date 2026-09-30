import re

with open('lib/screens/profile/my_orders_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/order_service.dart';\n"
if 'order_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

idx_start = content.find('ValueListenableBuilder<List<Map<String, dynamic>>>(')
idx_end = content.find(') // ValueListenableBuilder', idx_start)
if idx_end == -1:
    idx_end = content.find(')', idx_start + 1000) # Fallback

if idx_start != -1:
    # Just extract the method that returns the list
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
    
    # Let's just find the whole Expanded block
    idx_expanded_start = content.find('Expanded(', content.find('// 3. Orders List'))
    
    new_expanded = '''Expanded(
              child: ''' + new_list + '''
            )'''
            
    content = content[:idx_expanded_start] + new_expanded + content[content.find(']', idx_expanded_start):]

with open('lib/screens/profile/my_orders_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed my orders 2')
