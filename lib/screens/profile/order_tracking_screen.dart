import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String? orderId;
  final Map<String, dynamic>? orderData;

  const OrderTrackingScreen({super.key, this.orderId, this.orderData});



  @override
  Widget build(BuildContext context) {
    int currentStep = 0;
    final status = orderData?['status'] ?? 'Pending';
    if (status == 'In Transit') {
      currentStep = 2;
    } else if (status == 'Completed') {
      currentStep = 3;
    } else {
      currentStep = 0;
    }

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: Column(

          children: [

            // Header

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: const Icon(Icons.arrow_back_ios_new, size: 20),

                  ),

                  const SizedBox(width: 15),

                  const Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text('Order Tracking', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        Text('ORDER & LOGISTICS', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                      ],

                    ),

                  ),

                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: orderData?['trackingNumber'] ?? orderId ?? ''));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tracking ID copied')));
                    },
                    child: const Icon(Icons.share_outlined, size: 22, color: Colors.black87),
                  ),

                  const SizedBox(width: 15),

                  Container(

                    padding: const EdgeInsets.all(6),

                    decoration: const BoxDecoration(color: Color(0xFF006C7A), shape: BoxShape.circle),

                    child: const Icon(Icons.person, color: Colors.white, size: 16),

                  ),

                ],

              ),

            ),

            

            Expanded(

              child: SingleChildScrollView(

                child: Padding(

                  padding: const EdgeInsets.all(20),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      // Status pill

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Container(

                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                            decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20)),

                            child: Text('ORDER ${orderId ?? '#ORD-DEMO'}  Standard Shipping', style: const TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold)),

                          ),

                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen())),
                            child: const Row(
                              children: [
                                Icon(Icons.help_outline, color: Color(0xFF0F8A9E), size: 16),
                                SizedBox(width: 4),
                                Text('Support', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )

                        ],

                      ),

                      const SizedBox(height: 20),

                      

                      // Estimated Arrival Card
                      if (status != 'Cancelled')
                        Container(

                        padding: const EdgeInsets.all(20),

                        decoration: BoxDecoration(

                          gradient: const LinearGradient(colors: [Colors.white, Color(0xFFE0F7FA)], begin: Alignment.topLeft, end: Alignment.bottomRight),

                          borderRadius: BorderRadius.circular(24),

                        ),

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Text('ESTIMATED ARRIVAL', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                                    const SizedBox(height: 4),

                                    const Text('Tomorrow, Oct 18', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                                    const SizedBox(height: 2),

                                    Text('Guaranteed by 14:00 PM', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),

                                  ],

                                ),

                                Container(

                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                                  decoration: BoxDecoration(color: status == 'Cancelled' ? Colors.red : const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(20)),

                                  child: Row(

                                    children: [

                                      const Icon(Icons.circle, color: Colors.white, size: 8),

                                      const SizedBox(width: 4),

                                      Text(status == 'Cancelled' ? 'CANCELLED' : (orderData?['status']?.toString().toUpperCase() ?? 'PENDING'), style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),

                                    ],

                                  ),

                                )

                              ],

                            ),

                            const SizedBox(height: 20),

                            Container(

                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),

                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),

                              child: Row(

                                children: [

                                  const Icon(Icons.local_shipping_outlined, color: Color(0xFF0F8A9E), size: 24),

                                  const SizedBox(width: 12),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [

                                        Text(orderData?['courier'] ?? 'Standard Delivery', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

                                        Text(orderData?['trackingNumber'] ?? 'N/A', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                      ],

                                    ),

                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(text: orderData?['trackingNumber'] ?? orderId ?? ''));
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied!')));
                                    },
                                    child: Container(

                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),

                                      child: Row(

                                        children: [

                                          Icon(Icons.copy, color: Colors.grey.shade600, size: 14),

                                          const SizedBox(width: 4),

                                          Text('Copy', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),

                                        ],

                                      ),

                                    ),
                                  )

                                ],

                              ),

                            )

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 20),

                      

                      // Map Image

                      if (status != 'Cancelled') ...[
                        ClipRRect(

                          borderRadius: BorderRadius.circular(20),

                          child: Stack(

                            children: [

                              Image.network('https://picsum.photos/seed/map/600/300', height: 120, width: double.infinity, fit: BoxFit.cover),

                              Positioned(

                                bottom: 0, left: 0, right: 0,

                                child: Container(

                                  padding: const EdgeInsets.all(12),

                                  decoration: BoxDecoration(

                                    gradient: LinearGradient(colors: [Colors.black.withOpacity(0.7), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter)

                                  ),

                                  child: const Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [

                                      Row(

                                        children: [

                                          Icon(Icons.near_me_outlined, color: Colors.white, size: 16),

                                          SizedBox(width: 6),

                                          Text('Springfield Regional Hub (34m ago)', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),

                                        ],

                                      ),

                                      Text('Route #IL-402', style: TextStyle(color: Colors.white70, fontSize: 10)),

                                    ],

                                  ),

                                ),

                              )

                            ],

                          ),

                        ),

                        

                        const SizedBox(height: 30),
                      ],

                      

                      // Shipment Timeline
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipment Timeline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          if (status == 'Cancelled')
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('CANCELLED', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)))
                          else
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('ON SCHEDULE', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      if (status == 'Cancelled')
                        _buildTimelineItem(true, false, Icons.cancel_outlined, Colors.red, 'Order Cancelled', 'This order has been cancelled', '', isLast: true, isHighlight: true)
                      else ...[
                        _buildTimelineItem(currentStep >= 0, currentStep >= 1, Icons.check, currentStep >= 0 ? Colors.green : Colors.grey.shade400, 'Order Placed', 'Order received by system', '', isHighlight: currentStep == 0),
                        _buildTimelineItem(currentStep >= 1, currentStep >= 2, Icons.inventory_2_outlined, currentStep >= 1 ? Colors.green : Colors.grey.shade400, 'Order Packed', 'Fulfillment Center', '', isHighlight: currentStep == 1),
                        _buildTimelineItem(currentStep >= 2, currentStep >= 3, Icons.local_shipping_outlined, currentStep >= 2 ? const Color(0xFF0F8A9E) : Colors.grey.shade400, 'In Transit', 'Out for delivery', '', isHighlight: currentStep == 2),
                        _buildTimelineItem(currentStep >= 3, false, Icons.home_outlined, currentStep >= 3 ? Colors.green : Colors.grey.shade400, 'Package Delivered', 'Recipient front door release', '', isLast: true, isHighlight: currentStep == 3),
                      ],
                      
                      const SizedBox(height: 30),

                      

                      // Delivery Destination
                      const Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: Color(0xFF0F8A9E), size: 20),
                          SizedBox(width: 8),
                          Text('Delivery Destination', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(orderData?['address']?['name'] ?? 'Recipient', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text(orderData?['address']?['address'] ?? 'Unknown Address', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),

                            const SizedBox(height: 15),

                            Row(

                              children: [

                                const Icon(Icons.notifications_active_outlined, color: Color(0xFF0F8A9E), size: 16),

                                const SizedBox(width: 8),

                                Expanded(child: Text('Instruction: "${orderData?['address']?['instructions'] ?? 'None'}"', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontStyle: FontStyle.italic))),

                              ],

                            )

                          ],

                        ),

                      ),

                      

                      const SizedBox(height: 30),

                      

                      // Package Contents
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.shopping_bag_outlined, color: Color(0xFF0F8A9E), size: 20),
                              SizedBox(width: 8),
                              Text('Package Contents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                            child: Text('${(orderData?['items'] as List?)?.length ?? 0} Items', style: const TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ...((orderData?['items'] as List?) ?? []).map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(item['image'] ?? 'https://picsum.photos/100', width: 50, height: 50, fit: BoxFit.cover)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title'] ?? 'Product', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text('Qty ${item['qty'] ?? item['quantity'] ?? 1}', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Text('\$${item['price'] ?? '0.00'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ],
                          )
                        ),
                      )),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Paid (Tax & Shipping incl.)', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                          Text('\$${orderData?['total'] ?? '0.0'}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),

                      const SizedBox(height: 40),

                    ],

                  ),

                ),

              ),

            ),

            

            // Bottom Action Bar

            Container(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),

              child: Row(

                children: [

                  if (status == 'Cancelled')
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.headset_mic_outlined, size: 18),
                              SizedBox(width: 8),
                              Text('Help', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                    )
                  else ...[
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpSupportScreen())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                        child: const Row(
                          children: [
                            Icon(Icons.headset_mic_outlined, size: 18),
                            SizedBox(width: 8),
                            Text('Help', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                  ],

                  if (status != 'Cancelled')
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingLiveScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                        ),

                      child: const Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Icon(Icons.map_outlined, color: Colors.white, size: 18),

                          SizedBox(width: 8),

                          Text('View Live Courier Map', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),

                          SizedBox(width: 8),

                          Icon(Icons.arrow_forward, color: Colors.white, size: 18),

                        ],

                      ),

                    ),

                  )

                ],

              ),

            )

          ],

        ),

      ),

    );

  }



  Widget _buildTimelineItem(bool isDone, bool isLineSolid, IconData icon, Color color, String title, String sub, String time, {bool isLast = false, bool isHighlight = false}) {

    return IntrinsicHeight(

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Column(

            children: [

              Container(

                width: 32, height: 32,

                decoration: BoxDecoration(

                  color: isHighlight ? color : (isDone ? color : Colors.white),

                  shape: BoxShape.circle,

                  border: Border.all(color: isDone || isHighlight ? color : Colors.grey.shade300, width: 2),

                ),

                child: Icon(icon, size: 16, color: isHighlight || isDone ? Colors.white : Colors.grey.shade400),

              ),

              if (!isLast)

                Expanded(

                  child: Container(

                    width: 2,

                    color: isLineSolid ? Colors.green : Colors.grey.shade300,

                  ),

                )

            ],

          ),

          const SizedBox(width: 15),

          Expanded(

            child: Container(

              padding: isHighlight ? const EdgeInsets.all(12) : const EdgeInsets.only(bottom: 25, top: 4),

              decoration: isHighlight ? BoxDecoration(color: const Color(0xFFF0FBFF), borderRadius: BorderRadius.circular(12)) : null,

              child: Row(

                crossAxisAlignment: CrossAxisAlignment.start,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(title, style: TextStyle(fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600, fontSize: 14, color: isDone || isHighlight ? Colors.black87 : Colors.grey.shade500)),

                        const SizedBox(height: 4),

                        Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                      ],

                    ),

                  ),

                  Text(time, style: TextStyle(color: isHighlight ? color : Colors.grey.shade500, fontSize: 11, fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal)),

                ],

              ),

            ),

          )

        ],

      ),

    );

  }

}
