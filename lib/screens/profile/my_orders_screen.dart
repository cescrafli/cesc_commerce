import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/core/localization.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/order_service.dart';
import 'package:cesc_commerce/screens/product/write_review_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});
  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedTabIndex = 0;
  late Future<List<Map<String, dynamic>>> _ordersFuture;
  final List<Map<String, dynamic>> tabs = [
    {'name': 'All'},
    {'name': 'Pending'},
    {'name': 'In Transit'},
    {'name': 'Completed'},
    {'name': 'Cancelled'},
  ];

  @override
  void initState() {
    super.initState();
    _ordersFuture = OrderService().getOrders();
    globalOrders.addListener(_refreshOrders);
  }

  Future<void> _refreshOrders() async {
    _ordersFuture = OrderService().getOrders(
      status: tabs[_selectedTabIndex]['name'] == 'All' ? null : tabs[_selectedTabIndex]['name'],
    );
    await _ordersFuture;
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    globalOrders.removeListener(_refreshOrders);
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
      _ordersFuture = OrderService().getOrders(status: tabs[index]['name'] == 'All' ? null : tabs[index]['name']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(tr('my_orders'), style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  final isActive = _selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () => _onTabChanged(index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFF00BCD4) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade300),
                        boxShadow: isActive ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : [],
                      ),
                      child: Row(
                        children: [
                          Text(tabs[index]['name'], style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade700, fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: isActive ? Colors.white.withOpacity(0.2) : Colors.grey.shade100,
                              shape: BoxShape.circle
                            ),
                            child: Builder(
                              builder: (context) {
                                final count = tabs[index]['name'] == 'All' ? globalOrders.value.length : globalOrders.value.where((o) => o['status'] == tabs[index]['name']).length;
                                return Text('$count', style: TextStyle(color: isActive ? Colors.white : Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold));
                              }
                            ),
                          )
                        ]
                      )
                    )
                  );
                }),
              )
            ),
            
            // Orders List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async { await _refreshOrders(); },
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _ordersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) return const Center(child: Text('Error loading orders'));
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text(tr('no_orders_yet'), style: const TextStyle(color: Colors.grey)));
                    }
                    
                    final filtered = snapshot.data!;

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 10, bottom: 30, left: 20, right: 20),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final order = filtered[index];
                        final items = (order['items'] as List?) ?? [];
                        final firstItem = items.isNotEmpty ? items[0] : {};
                        return _buildOrderCard(
                          id: order['id'] ?? '#ORD',
                          date: order['date']?.toString().split('T')[0] ?? '-',
                          status: order['status'] ?? 'Pending',
                          total: order['total']?.toString() ?? '0',
                          itemCount: items.length,
                          firstItemImage: firstItem['image'] ?? 'https://picsum.photos/100',
                          firstItemName: firstItem['title'] ?? 'Product',
                          orderData: order,
                        );
                      }
                    );
                  }
                )
              )
            )
          ]
        )
      )
    );
  }

  Widget _buildOrderCard({required String id, required String date, required String status, required String total, required int itemCount, required String firstItemImage, required String firstItemName, required Map<String, dynamic> orderData}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Order $id', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(status, style: TextStyle(color: status == 'Completed' ? Colors.green : (status == 'Cancelled' ? Colors.red : Colors.orange), fontWeight: FontWeight.bold, fontSize: 12))
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(firstItemImage, width: 60, height: 60, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(firstItemName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text('$itemCount items - $date', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  ],
                )
              ),
              Text('\$$total', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF00BCD4))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: orderData['id']?.toString(), orderData: orderData))),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Details', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                ),
              ),
              if (status != 'Cancelled') const SizedBox(width: 12),
              if (status != 'Cancelled')
                Expanded(
                  child: status == 'Completed'
                    ? ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WriteReviewScreen(product: ((orderData['items'] as List?)?.isNotEmpty == true) ? (orderData['items'] as List).first : null))),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Write Review', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      )
                    : ElevatedButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => OrderTrackingScreen(orderId: orderData['id']?.toString(), orderData: orderData))),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Track', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                ),
            ],
          )
        ],
      )
    );
  }
}
