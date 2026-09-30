import codecs

content = """import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedTabIndex = 0;

  final tabs = [
    {'name': 'All', 'count': '14'},
    {'name': 'In Transit', 'count': '2'},
    {'name': 'Completed', 'count': '10'},
    {'name': 'Cancelled', 'count': '2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
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
                  const Text('My Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 38), // for balance
                ],
              ),
            ),
            
            // 2. Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey.shade400),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(hintText: 'Search order ID or item...', hintStyle: TextStyle(color: Colors.grey.shade400), border: InputBorder.none),
                      ),
                    ),
                    Icon(Icons.mic_none, color: Colors.grey.shade400),
                  ],
                ),
              ),
            ),
            
            // 3. Tabs
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  final isSel = index == _selectedTabIndex;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = index),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSel ? Theme.of(context).primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: isSel ? null : Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Text(tabs[index]['name']!, style: TextStyle(color: isSel ? Colors.white : Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(color: isSel ? Colors.white.withValues(alpha: 0.2) : Colors.grey.shade200, shape: BoxShape.circle),
                            child: Text(tabs[index]['count']!, style: TextStyle(color: isSel ? Colors.white : Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            
            // 4. Order List
            Expanded(
              child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: globalOrders,
                builder: (context, orders, child) {
                  if (orders.isEmpty) {
                    return const Center(child: Text('No orders yet.', style: TextStyle(color: Colors.grey)));
                  }
                  
                  final selectedStatus = tabs[_selectedTabIndex]['name'];
                  final filtered = orders.where((o) {
                     if (selectedStatus == 'All') return true;
                     return true; // For dummy sake, just show all for now since they are all pending/ongoing
                  }).toList();
                  
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final order = filtered[index];
                      return _buildDynamicOrderCard(context, order);
                    }
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicOrderCard(BuildContext context, Map<String, dynamic> order) {
    int count = (order['items'] as List).length;
    String itemsText = count == 1 ? '1 item' : '$count items';
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Text('Pending', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 13))
            ]
          ),
          const Divider(height: 30),
          Row(
            children: [
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                child: Center(child: Icon(Icons.shopping_bag_outlined, color: Theme.of(context).primaryColor, size: 24)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(itemsText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 5),
                    Text(order['date'].toString().split(' ')[0], style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                  ]
                )
              ),
              Text('\\$${order['total'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
            ]
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Details', style: TextStyle(color: Colors.black)),
                )
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingLiveScreen())),
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  child: const Text('Track', style: TextStyle(color: Colors.white)),
                )
              )
            ]
          )
        ]
      )
    );
  }
}
"""
with codecs.open('lib/screens/profile/my_orders_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
