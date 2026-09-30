import codecs, re

with codecs.open('lib/screens/profile/my_orders_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace the Expanded(...)
new_list = r"""Expanded(
            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: globalOrders,
              builder: (context, orders, child) {
                if (orders.isEmpty) {
                  return Center(child: Text('No orders yet.', style: TextStyle(color: Colors.grey)));
                }
                final filtered = orders.where((o) {
                   if (_selectedStatus == 'All') return true;
                   if (_selectedStatus == 'Ongoing') return true; # dummy logic for now
                   if (_selectedStatus == 'Completed') return false; 
                   return true;
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
          ),"""

content = re.sub(
    r"Expanded\([\s\S]*?child: ListView\([\s\S]*?children: \[[\s\S]*?_buildOrderCard1\(context\),[\s\S]*?\][\s\S]*?\)[\s\S]*?\),",
    new_list,
    content
)

# Insert _buildDynamicOrderCard at the end
dynamic_card = r"""Widget _buildDynamicOrderCard(BuildContext context, Map<String, dynamic> order) {
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
              Text('Pending', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 13))
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
              Text('\$${order['total'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
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

# Replace the last `}` to inject the new method
content = content.rstrip()
if content.endswith('}'):
    content = content[:-1] + dynamic_card

with codecs.open('lib/screens/profile/my_orders_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
