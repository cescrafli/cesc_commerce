import re

with open('lib/screens/profile/my_orders_screen.dart', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# 1. Fix the tab filter logic
old_filter = '''                  final filtered = orders.where((o) {
                     if (selectedStatus == 'All') return true;
                     return true; // For dummy sake, just show all for now since they are all pending/ongoing
                  }).toList();'''
new_filter = '''                  final filtered = orders.where((o) {
                    final status = o['status']?.toString() ?? 'Pending';
                    if (_selectedTabIndex == 0) return status == 'Pending';
                    if (_selectedTabIndex == 1) return status == 'In Transit';
                    if (_selectedTabIndex == 2) return status == 'Completed';
                    if (_selectedTabIndex == 3) return status == 'Cancelled';
                    return true;
                  }).toList();'''
content = content.replace(old_filter, new_filter)

# 2. Fix the hardcoded "Pending" badge
old_badge = '''padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Text(tr('pending'), style: const TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)))'''
new_badge = '''padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: (order['status'] == 'Completed' ? Colors.green : order['status'] == 'Cancelled' ? Colors.red : Colors.orange).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)), child: Text(order['status']?.toString() ?? tr('pending'), style: TextStyle(color: (order['status'] == 'Completed' ? Colors.green : order['status'] == 'Cancelled' ? Colors.red : Colors.orange), fontSize: 10, fontWeight: FontWeight.bold)))'''
content = content.replace(old_badge, new_badge)

# 3. Fix the Details button action
old_details = '''OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor, side: BorderSide(color: Theme.of(context).primaryColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: const Text('Details', style: TextStyle(fontSize: 12)),
                        ),'''
new_details = '''OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Order ' + order['id'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 10),
                                    Text('Status: ' + (order['status'] ?? 'Pending')),
                                    const SizedBox(height: 10),
                                    Text('Items: ' + count.toString()),
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(foregroundColor: Theme.of(context).primaryColor, side: BorderSide(color: Theme.of(context).primaryColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          child: const Text('Details', style: TextStyle(fontSize: 12)),
                        ),'''
content = content.replace(old_details, new_details)

with open('lib/screens/profile/my_orders_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed my_orders_screen.dart')
