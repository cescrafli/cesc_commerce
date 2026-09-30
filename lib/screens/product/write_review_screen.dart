import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/core/services/product_service.dart';


class WriteReviewScreen extends StatefulWidget {
  final Map<String, dynamic>? product;
  final Map<String, dynamic>? orderData;

  const WriteReviewScreen({super.key, this.product, this.orderData});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  int _starRating = 5;
  bool _showName = true;

  @override
  void initState() {
    super.initState();
    _reviewController.addListener(_onReviewChanged);
  }

  void _onReviewChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _reviewController.removeListener(_onReviewChanged);
    _reviewController.dispose();
    super.dispose();
  }

  String _getRatingText(int stars) {
    const texts = ['Terrible', 'Poor', 'Okay', 'Good', 'Excellent!'];
    if (stars < 1 || stars > 5) return '';
    return texts[stars - 1];
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.product?['title'] ?? 'Product';
    final dynamic priceRaw = widget.product?['price'];
    double parsedPrice = 0.0;
    if (priceRaw is num) {
      parsedPrice = priceRaw.toDouble();
    } else if (priceRaw is String) {
      parsedPrice = double.tryParse(priceRaw.replaceAll('\$', '').trim()) ?? 0.0;
    }
    final String priceFormatted = '\$${parsedPrice.toStringAsFixed(2)}';
    final String? imageUrl = widget.product?['image'];
    final String orderId = widget.product?['id']?.toString() ?? 'ITEM';
    
    final orderDate = widget.orderData?['date'] != null ? DateTime.tryParse(widget.orderData!['date'].toString()) : DateTime.now();
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final dateObj = orderDate ?? DateTime.now();
    final String formattedDate = '${months[dateObj.month - 1]} ${dateObj.day}, ${dateObj.year}';
    
    final String userName = globalUser.value?['name']?.toString() ?? 'Anonymous';

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

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text('Write a Review', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        Text('ORDER #$orderId  DELIVERED', style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

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

                            if (imageUrl != null && imageUrl.isNotEmpty)
                              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(imageUrl, width: 55, height: 55, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 55)))
                            else
                              const Icon(Icons.image, size: 55),

                            const SizedBox(width: 15),

                            Expanded(

                              child: Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis)), const SizedBox(width: 8), Text(priceFormatted, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),

                                  const SizedBox(height: 2),

                                  Text('Order: #$orderId', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                  const SizedBox(height: 6),

                                  Row(children: [const Icon(Icons.check_circle, color: Colors.green, size: 12), const SizedBox(width: 4), Text('Delivered on $formattedDate', style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold))])

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

                              children: List.generate(5, (index) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: GestureDetector(onTap: () => setState(() => _starRating = index + 1), child: Icon(index < _starRating ? Icons.star : Icons.star_border, color: Colors.amber, size: 36)))),

                            ),

                            const SizedBox(height: 20),

                            Container(

                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20)),

                              child: Row(

                                mainAxisSize: MainAxisSize.min,

                                children: [

                                  const Icon(Icons.verified, color: Color(0xFF0F8A9E), size: 14),

                                  const SizedBox(width: 6),

                                  Text('$_starRating.0  ${_getRatingText(_starRating)}', style: const TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),

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

                                Text('${_reviewController.text.length} / 500', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                              ],

                            ),

                            const SizedBox(height: 15),

                            Container(

                              padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(16)),

                              child: Column(

                                children: [

                                  TextField(

                                    maxLines: 4,

                                    decoration: const InputDecoration(

                                      border: InputBorder.none,

                                      hintText: 'Share your experience with this product...',

                                    ),

                                    style: const TextStyle(fontSize: 13, height: 1.5),

                                    controller: _reviewController,

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

                                      Text(widget.orderData?['courier']?.toString() ?? 'Standard Delivery', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

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

                                  Text('Show as $userName (Verified Buyer)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),

                                ],

                              ),

                            ),

                            Switch(value: _showName, activeColor: const Color(0xFF006C7A), onChanged: (v){
                              setState(() {
                                _showName = v;
                              });
                            }),

                          ],

                        )

                      ),

                      

                      const SizedBox(height: 30),

                      

                      // Submit Button

                      SizedBox(

                        width: double.infinity, height: 55,

                        child: ElevatedButton(

                          onPressed: () async {
                            if (_reviewController.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please write your review'))); return; }
                            final productId = widget.product?['id']?.toString() ?? 'unknown';
                            try {
                              await ProductService().submitReview(productId, _starRating.toDouble(), _reviewController.text.trim());
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Review Submitted! 50 Points Earned!')));
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to submit review: $e')));
                              }
                            }
                          },

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
