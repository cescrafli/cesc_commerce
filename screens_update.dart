class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const Icon(Icons.share_outlined, size: 22, color: Colors.black87),
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
                            child: const Text('ORDER #ORD-9284 • Standard Shipping', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.help_outline, color: Color(0xFF0F8A9E), size: 16),
                              SizedBox(width: 4),
                              Text('Support', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Estimated Arrival Card
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
                                  decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(20)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.circle, color: Colors.white, size: 8),
                                      SizedBox(width: 4),
                                      Text('IN TRANSIT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
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
                                        const Text('FedEx Express', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        Text('FDX-8829194', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.copy, color: Colors.grey.shade600, size: 14),
                                        const SizedBox(width: 4),
                                        Text('Copy', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                                      ],
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
                      
                      // Shipment Timeline
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Shipment Timeline', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('ON SCHEDULE', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      _buildTimelineItem(true, true, Icons.check, Colors.green, 'Order Placed', 'Authorized via Aura Checkout', 'Oct 16, 10:30 AM'),
                      _buildTimelineItem(true, true, Icons.check, Colors.green, 'Payment Confirmed', 'PayPal verified (\.00)', 'Oct 16, 10:32 AM'),
                      _buildTimelineItem(true, true, Icons.check, Colors.green, 'Order Packed & Processed', 'Springfield Fulfillment Center', 'Oct 16, 16:45 PM'),
                      _buildTimelineItem(true, false, Icons.warehouse, const Color(0xFF0F8A9E), 'At Distribution Hub', 'Springfield Regional Sorting Facility - Inbound scan processed', 'Today, 09:15 AM', isHighlight: true),
                      _buildTimelineItem(false, false, Icons.local_shipping_outlined, Colors.grey.shade400, 'Out for Delivery', 'Local delivery courier dispatch', 'Oct 18, ~08:30 AM'),
                      _buildTimelineItem(false, false, Icons.home_outlined, Colors.grey.shade400, 'Package Delivered', 'Recipient front door release', 'Oct 18, ~14:00 PM', isLast: true),
                      
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
                            const Text('Cesc Fabregas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 4),
                            Text('123 Main Street, Apt 4B\nSan Diego, CA 92101', style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const Icon(Icons.notifications_active_outlined, color: Color(0xFF0F8A9E), size: 16),
                                const SizedBox(width: 8),
                                Expanded(child: Text('Instruction: "Ring doorbell twice upon arrival"', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontStyle: FontStyle.italic))),
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
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)), child: const Text('2 Items', style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network('https://picsum.photos/seed/102/100/100', width: 50, height: 50, fit: BoxFit.cover)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Denim Classic Jacket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 2),
                                  Text('Size L • Indigo Blue • Qty 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              ),
                            ),
                            const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        )
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network('https://picsum.photos/seed/101/100/100', width: 50, height: 50, fit: BoxFit.cover)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Basic Eco-Cotton T-Shirt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 2),
                                  Text('Size M • Chalk White • Qty 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              ),
                            ),
                            const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        )
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Paid (Tax & Shipping incl.)', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                          const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
                  Container(
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
                  const SizedBox(width: 15),
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
class OrderTrackingLiveScreen extends StatelessWidget {
  const OrderTrackingLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const Icon(Icons.share_outlined, size: 22, color: Colors.black87),
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
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)),
                            child: const Row(
                              children: [
                                Icon(Icons.circle, color: Colors.green, size: 8),
                                SizedBox(width: 6),
                                Text('ORDER #ORD-8910 • EXPRESS', style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            )
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)),
                            child: const Row(
                              children: [
                                Icon(Icons.bolt, color: Colors.green, size: 14),
                                SizedBox(width: 4),
                                Text('Live GPS', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Live Map Card
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Stack(
                          children: [
                            Image.network('https://picsum.photos/seed/map3/600/500', height: 250, width: double.infinity, fit: BoxFit.cover),
                            Container(height: 250, width: double.infinity, color: const Color(0xFFE8EAF6).withOpacity(0.5)),
                            // Faux Map details
                            Positioned(
                              top: 20, left: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                                child: Row(
                                  children: [
                                    const Icon(Icons.circle, color: Color(0xFF00BCD4), size: 10),
                                    const SizedBox(width: 6),
                                    const Text('Arriving in ~25 mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    const SizedBox(width: 6),
                                    Text('• 1.8 mi away', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20, right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
                                child: const Row(
                                  children: [
                                    Icon(Icons.traffic_outlined, color: Colors.green, size: 14),
                                    SizedBox(width: 4),
                                    Text('Light', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                  ],
                                ),
                              ),
                            ),
                            // Map Markers
                            const Positioned(
                              top: 90, left: 160,
                              child: Icon(Icons.location_on, color: Color(0xFF006C7A), size: 30),
                            ),
                            const Positioned(
                              top: 150, left: 240,
                              child: Icon(Icons.location_on, color: Colors.red, size: 30),
                            ),
                            Positioned(
                              bottom: 20, right: 20,
                              child: Column(
                                children: [
                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.my_location, size: 20)),
                                  const SizedBox(height: 10),
                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.add, size: 20)),
                                  const SizedBox(height: 5),
                                  Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]), child: const Icon(Icons.remove, size: 20)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Courier Info Card
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network('https://picsum.photos/seed/dave/100/100', width: 50, height: 50, fit: BoxFit.cover)),
                                    Positioned(bottom: 0, right: 0, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.check_circle, color: Colors.green, size: 14))),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Text('Dave Miller', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                          SizedBox(width: 4),
                                          Icon(Icons.verified, color: Color(0xFF0F8A9E), size: 14),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Row(
                                        children: [
                                          const Icon(Icons.star, color: Colors.orange, size: 12),
                                          const SizedBox(width: 4),
                                          const Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                          Text(' (420+ trips)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                        ],
                                      ),
                                      const SizedBox(height: 2),
                                      Text('Honda PCX160 • CA8K...', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF0F8A9E), size: 20)),
                                    const SizedBox(width: 10),
                                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.phone_outlined, color: Colors.white, size: 20)),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(color: const Color(0xFFF0FBFF), borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade100, shape: BoxShape.circle), child: const Icon(Icons.location_on_outlined, color: Color(0xFF0F8A9E), size: 16)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('You are the next delivery stop!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        Text('Dave just completed 3 of 4 neighborhood...', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Route Progress
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Route Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('Stage 3 of 4', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Order Packed & Prepared', 'Pacific Distribution Hub • 9:15 AM', false),
                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Courier Picked Up', 'Dave Miller on route • 9:32 AM', false),
                            _buildExpressTimeline(true, Icons.circle, const Color(0xFF00BCD4), 'Out for Delivery', 'Navigating Evergreen Terr. toward 123 Main St.', true, isCurrent: true),
                            _buildExpressTimeline(false, Icons.circle, Colors.grey.shade300, 'Delivered & Handed Over', 'Expected by 10:05 AM', false, isLast: true),
                            
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network('https://picsum.photos/seed/103/100/100', width: 40, height: 40, fit: BoxFit.cover)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('Cargo Utility Pants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        Text('Size 32 • Olive Green', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                  const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 25),
                      
                      // Handover Security
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lock_outline, color: Colors.black87, size: 20),
                              SizedBox(width: 8),
                              Text('Handover Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Row(children: [Icon(Icons.verified_user_outlined, color: Color(0xFF0F8A9E), size: 10), SizedBox(width: 4), Text('VERIFIED', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))])),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.contactless_outlined, color: Color(0xFF0F8A9E), size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Contactless Drop-off', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text('Leave at front door or hand directly to resident. Ring doorbell upon leaving.', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, height: 1.3)),
                                ],
                              ),
                            )
                          ],
                        )
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('DELIVERY SECURITY PIN', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                const SizedBox(height: 4),
                                Text('Share with Dave upon arrival', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
                              child: const Text('4  9  2  0', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
                            )
                          ],
                        )
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Action button
                      SizedBox(
                        width: double.infinity, height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BCD4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.ios_share, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Share Live Location / ETA', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(child: Text('Automatic SMS updates will be sent when courier is 2 minutes\naway.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 10, height: 1.5))),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildExpressTimeline(bool isDone, IconData icon, Color color, String title, String sub, bool isHighlight, {bool isLast = false, bool isCurrent = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: isCurrent ? Colors.white : color,
                  shape: BoxShape.circle,
                  border: isCurrent ? Border.all(color: color, width: 4) : null,
                ),
                child: !isCurrent ? Icon(icon, size: 14, color: Colors.white) : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCurrent ? Colors.grey.shade200 : color, // after current it's grey
                  ),
                )
            ],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: TextStyle(fontWeight: isCurrent || isDone ? FontWeight.bold : FontWeight.normal, fontSize: 13, color: isCurrent || isDone ? Colors.black87 : Colors.grey.shade500)),
                      if (isCurrent) ...[
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('CURRENT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold))),
                      ]
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(sub, style: TextStyle(color: isCurrent ? Colors.black87 : Colors.grey.shade500, fontSize: 11)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
class WriteReviewScreen extends StatelessWidget {
  const WriteReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    child: const Icon(Icons.arrow_back, size: 20),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Write a Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('ORDER #ORD-7741 • DELIVERED', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                  ),
                  const Icon(Icons.help_outline, size: 20, color: Colors.black87),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Product Card
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://picsum.photos/seed/104/100/100', width: 55, height: 55, fit: BoxFit.cover)),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Botanical Casual Shirt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                                  const SizedBox(height: 2),
                                  Text('Size: L • Floral Hawaii Print', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                  const SizedBox(height: 6),
                                  Row(children: [const Icon(Icons.check_circle, color: Colors.green, size: 12), const SizedBox(width: 4), Text('Delivered on Oct 12, 2024', style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold))])
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Rating Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(25), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          children: [
                            Text('PRODUCT SATISFACTION', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            const SizedBox(height: 10),
                            const Text('How was your product?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Tap the stars to adjust your overall impression', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 4), child: Icon(Icons.star, color: Colors.amber, size: 36))),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20)),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.verified, color: Color(0xFF0F8A9E), size: 14),
                                  SizedBox(width: 6),
                                  Text('5.0 • Excellent! Highly recommended', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Detailed Impressions
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Detailed Impressions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('Step 2 of 3', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Fit & Sizing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('True to Size (L)', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 11))]),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(10)), child: const Text('Runs Small', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)))),
                                const SizedBox(width: 10),
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(10)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.check, color: Colors.white, size: 14), SizedBox(width: 4), Text('True to Size', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white))]))),
                                const SizedBox(width: 10),
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(10)), child: const Text('Runs Large', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Fabric & Breathability', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('Soft & Breathable', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 11))]),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(10)), child: const Text('Rough', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)))),
                                const SizedBox(width: 10),
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(10)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.check, color: Colors.white, size: 14), SizedBox(width: 4), Text('Soft & Airy', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white))]))),
                                const SizedBox(width: 10),
                                Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 12), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(10)), child: const Text('Silk Feel', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)))),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            const Text('Color & Visual Accuracy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Exact match with photo gallery', style: TextStyle(fontSize: 12, color: Colors.black87)),
                                  Icon(Icons.check_circle_outline, color: Colors.green, size: 18),
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Add Photos
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Add Photos or Video', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('+10 Pts', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('Help others see the real texture & fit (2/5)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Container(
                                  width: 70, height: 70, decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(16)),
                                  child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.camera_alt_outlined, color: Color(0xFF0F8A9E), size: 24), SizedBox(height: 4), Text('Add Media', style: TextStyle(color: Colors.black54, fontSize: 9, fontWeight: FontWeight.bold))]),
                                ),
                                const SizedBox(width: 10),
                                Stack(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network('https://picsum.photos/seed/201/100/100', width: 70, height: 70, fit: BoxFit.cover)),
                                    Positioned(top: 4, right: 4, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 10))),
                                    Positioned(bottom: 4, left: 4, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: const Text('Photo', style: TextStyle(color: Colors.white, fontSize: 8)))),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Stack(
                                  children: [
                                    ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network('https://picsum.photos/seed/202/100/100', width: 70, height: 70, fit: BoxFit.cover)),
                                    Positioned(top: 4, right: 4, child: Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 10))),
                                    Positioned(bottom: 4, left: 4, child: Container(padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)), child: const Text('Detail', style: TextStyle(color: Colors.white, fontSize: 8)))),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Your Thoughts
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Your Thoughts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text('168 / 500', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  const TextField(
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Share your experience with this product...',
                                    ),
                                    style: TextStyle(fontSize: 13, height: 1.5),
                                    controller: TextEditingController.fromValue(TextEditingValue(text: 'The fabric is super lightweight and comfortable for tropical weather! The floral print looks even more vibrant in person. Fits perfectly on size L. Will definitely order again.')),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.sentiment_very_satisfied, color: Colors.green, size: 16),
                                          const SizedBox(width: 4),
                                          Text('High detail review!', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Icon(Icons.auto_fix_high, color: Color(0xFF0F8A9E), size: 16),
                                          SizedBox(width: 4),
                                          Text('Polish', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Courier & Delivery
                      Container(
                        padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.local_shipping_outlined, color: Color(0xFF0F8A9E), size: 18)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Courier & Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      Text('Aura Express • 2-Day Priority', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                    ],
                                  ),
                                ),
                                Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 14))),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('"Fast 2-day delivery & polite courier"', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                                  Icon(Icons.check_circle_outline, color: Colors.green.shade400, size: 16),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Display Name toggle
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF0F5FF), shape: BoxShape.circle), child: const Icon(Icons.badge_outlined, color: Color(0xFF0F8A9E), size: 18)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Display Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  Text('Show as Cesc F. (Verified Buyer)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              ),
                            ),
                            Switch(value: true, activeColor: const Color(0xFF006C7A), onChanged: (v){}),
                          ],
                        )
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Submit Button
                      SizedBox(
                        width: double.infinity, height: 55,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4DD0E1), // Cyan lighter
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Submit Review & Earn 50 Points', style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.black87, size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline, color: Colors.grey, size: 12),
                          SizedBox(width: 4),
                          Text('Your verified review helps millions shop with confidence', style: TextStyle(color: Colors.grey, fontSize: 10)),
                        ],
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
