import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cesc_commerce/core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';

class ProductDetailScreen extends StatefulWidget {

  final Map<String, dynamic> product;
  const ProductDetailScreen({super.key, required this.product});



  @override

  State<ProductDetailScreen> createState() => _ProductDetailScreenState();

}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  @override
  void initState() {
    super.initState();
    globalLanguage.addListener(_onLangChange);
  }

  int _qty = 1;

  int _selectedColorIndex = 0;

  int _selectedSizeIndex = 0;



  List<Map<String, dynamic>> get _colorsData {
    if (widget.product['colors'] == null) return [];
    return List<Map<String, dynamic>>.from(widget.product['colors']);
  }

  List<String> get _sizes {
    if (widget.product['sizes'] == null) return [];
    return List<String>.from(widget.product['sizes']);
  }



  @override

  Widget build(BuildContext context) {
    final rawPrice = widget.product['price'];
    final double productPrice = (rawPrice is String) ? double.tryParse(rawPrice.replaceAll('\$', '').trim()) ?? 0.0 : (rawPrice as num?)?.toDouble() ?? 0.0;
    final rawOrig = widget.product['originalPrice'];
    final double? origPrice = rawOrig != null ? ((rawOrig is String) ? double.tryParse(rawOrig.replaceAll('\$', '').trim()) : (rawOrig as num?)?.toDouble()) : null;
    final int discount = (origPrice != null && origPrice > productPrice) ? ((origPrice - productPrice) / origPrice * 100).round() : 0;

    return Scaffold(

      backgroundColor: Colors.white,

      bottomNavigationBar: Container(

        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),

        child: SafeArea(

          child: Row(

            children: [

              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen()));
                },
                child: Container(

                  width: 50, height: 50,

                  decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), shape: BoxShape.circle),

                  child: const Icon(Icons.chat_bubble_outline, color: Colors.grey),

                ),
              ),

              const SizedBox(width: 15),

              Expanded(

                child: OutlinedButton(

                  onPressed: () {

                    addToCartObj(widget.product, _qty, _sizes.isNotEmpty ? _sizes[_selectedSizeIndex] : 'N/A', _colorsData.isNotEmpty ? _colorsData[_selectedColorIndex]['name'] : 'N/A', context);

                  },

                  style: OutlinedButton.styleFrom(side: BorderSide(color: Theme.of(context).primaryColor, width: 2), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_bag_outlined, color: Theme.of(context).primaryColor, size: 18), const SizedBox(width: 8), Text(tr('add_to_cart'), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15))]),

                ),

              ),

              const SizedBox(width: 15),

              Expanded(

                child: ElevatedButton(

                                    onPressed: () {

                    final singleItem = {

                      'title': widget.product['title'],

                      'subtitle': 'Size: ${_sizes.isNotEmpty ? _sizes[_selectedSizeIndex] : 'N/A'}',

                      'price': productPrice,

                      'qty': _qty,

                      'image': widget.product['image'] ?? ''

                    };

                    

                    Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: [singleItem])));

                  },

                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),

                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.flash_on, color: Colors.white, size: 18), const SizedBox(width: 4), Text(tr('buy_now'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))]),

                ),

              ),

            ],

          ),

        ),

      ),

      body: SingleChildScrollView(

        child: Stack(

          children: [

            // Background Image

            Image.network(
              widget.product['image'] ?? '',
              height: 420,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 80),
            ),

            

            // Top Floating Buttons

            SafeArea(

              child: Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    CircleAvatar(

                      backgroundColor: Colors.black45,

                      child: IconButton(icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18), onPressed: () => Navigator.pop(context)),

                    ),

                    Row(

                      children: [

                        ValueListenableBuilder(
  valueListenable: globalWishlist,
  builder: (context, List<Map<String, dynamic>> wishlist, child) {
    bool isFav = wishlist.any((item) => item['id']?.toString() == widget.product['id']?.toString());
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey, size: 20),
        onPressed: () { toggleWishlistObj(widget.product, context); },
      ),
    );
  },
),

                        const SizedBox(width: 10),

                        CircleAvatar(backgroundColor: Colors.black45, child: IconButton(icon: const Icon(Icons.share, color: Colors.white, size: 20), onPressed: () { Clipboard.setData(ClipboardData(text: 'https://cesc_commerce.com/product/${widget.product['id']}')); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied!'))); })),

                      ],

                    ),

                  ],

                ),

              ),

            ),

            

            // White Details Container

            Container(

              margin: const EdgeInsets.only(top: 390), // Overlaps the image slightly

              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),

              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Title and Price Row

                  Row(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Expanded(child: Text(widget.product['title']?.toString() ?? 'Product', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2))),

                      Column(

                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [

                          Text('\$${productPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),

                          if (origPrice != null && origPrice > productPrice)
                            Row(
                              children: [
                                Text('\$${origPrice.toStringAsFixed(2)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
                                const SizedBox(width: 5),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)), child: Text('$discount% OFF', style: TextStyle(color: Colors.red.shade700, fontSize: 10, fontWeight: FontWeight.bold))),
                              ],
                            )
                        ],

                      )

                    ],

                  ),

                  const SizedBox(height: 10),

                  

                  if (widget.product['tags'] != null && (widget.product['tags'] as List).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Wrap(
                        spacing: 8,
                        children: (widget.product['tags'] as List).map((tag) => 
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text(tag.toString(), style: TextStyle(fontSize: 12, color: Colors.grey.shade800)))
                        ).toList(),
                      ),
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber.shade500, size: 18),
                          const SizedBox(width: 4),
                          Text(widget.product['rating']?.toString() ?? '4.5', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(width: 4),
                          Text('(${widget.product['reviews']?.toString() ?? '0'} Verified Reviews)', style: const TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  

                  // Color Picker
                  if (_colorsData.isNotEmpty) ...[
                    Text('COLOR: ${_colorsData[_selectedColorIndex]['name']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(_colorsData.length, (index) => GestureDetector(
                          onTap: () => setState(() => _selectedColorIndex = index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _selectedColorIndex == index ? Theme.of(context).primaryColor : Colors.transparent, width: 2)),
                            child: CircleAvatar(backgroundColor: _colorsData[index]['color'], radius: 15),
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],



                  // Size Picker
                  if (_sizes.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tr('select_size'), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                content: Text("S: 36, M: 38, L: 40, XL: 42"),
                              ),
                            );
                          },
                          child: Row(children: [Icon(Icons.straighten, color: Theme.of(context).primaryColor, size: 14), const SizedBox(width: 4), Text(tr('size_guide'), style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold))])
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(_sizes.length, (index) => GestureDetector(
                          onTap: () => setState(() => _selectedSizeIndex = index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            width: 50, height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: _selectedSizeIndex == index ? Theme.of(context).primaryColor : Colors.grey.shade300, width: _selectedSizeIndex == index ? 2 : 1)
                            ),
                            child: Text(_sizes[index], style: TextStyle(fontWeight: FontWeight.bold, color: _selectedSizeIndex == index ? Theme.of(context).primaryColor : Colors.black87)),
                          ),
                        )),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],



                  // Quantity

                  Container(

                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text(tr('quantity'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                        Row(

                          children: [

                            GestureDetector(onTap: () { if (_qty > 1) setState(() => _qty--); }, child: const Text('-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey))),

                            const SizedBox(width: 20),

                            Text('$_qty', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

                            const SizedBox(width: 20),

                            GestureDetector(onTap: () => setState(() => _qty++), child: const Text('+', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey))),

                          ],

                        )

                      ],

                    ),

                  ),

                  const SizedBox(height: 30),



                  // Description

                  Text(tr('description_caps'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),

                  const SizedBox(height: 10),
                  Text(widget.product['description']?.toString() ?? 'No description available.', style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.5)),

                  const SizedBox(height: 20),

                  

                  // Features Grid

                  Builder(
                    builder: (context) {
                      final rawFeatures = widget.product['features'];
                      final List<String> features = (rawFeatures is List)
                          ? rawFeatures.map((e) => e.toString()).toList()
                          : ['100% Organic Cotton', 'Pre-shrunk Fabric', 'Machine Wash Cold', 'Non-Toxic Eco Dyes'];

                      return GridView.count(
                        crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 4.5, mainAxisSpacing: 10, crossAxisSpacing: 10,
                        children: features.map((f) => _buildFeatureItem(f)).toList(),
                      );
                    }
                  ),

                  const SizedBox(height: 25),



                  // Policies

                  Row(

                    children: [

                      Expanded(child: _buildPolicyItem(Icons.local_shipping_outlined, 'Free Delivery', 'Orders above \$35')),

                      Container(width: 1, height: 40, color: Colors.grey.shade300),

                      Expanded(child: _buildPolicyItem(Icons.sync, '30-Day Returns', 'Hassle-free guarantee')),

                    ],

                  ),

                  const SizedBox(height: 30),



                  // Review

                  if (widget.product['reviewsList'] != null && (widget.product['reviewsList'] as List).isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tr('top_customer_review'), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => WriteReviewScreen(product: widget.product)));
                          },
                          child: Text('View all (${widget.product['reviews']?.toString() ?? '0'})', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Builder(
                      builder: (context) {
                        final firstReview = (widget.product['reviewsList'] as List).first;
                        final name = firstReview['name']?.toString() ?? 'Anonymous';
                        final comment = firstReview['comment']?.toString() ?? '';
                        final rating = (firstReview['rating'] as num?)?.toInt() ?? 5;
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 16, child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                                  const SizedBox(width: 10),
                                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Row(children: [const Icon(Icons.verified, color: Colors.green, size: 12), const SizedBox(width: 4), Text(tr('verified_buyer'), style: TextStyle(color: Colors.green, fontSize: 10))])])),
                                  Row(children: List.generate(rating.clamp(0, 5), (index) => const Icon(Icons.star, color: Colors.amber, size: 12))),
                                ],
                              ),
                              if (comment.isNotEmpty) const SizedBox(height: 10),
                              if (comment.isNotEmpty) Text('"$comment"', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey.shade700)),
                            ],
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                  ],

                ],

              ),

            ),

          ],

        ),

      ),

    );

  }



  Widget _buildFeatureItem(String text) {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),

      child: Row(children: [Icon(Icons.check, color: Theme.of(context).primaryColor, size: 14), const SizedBox(width: 6), Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: Colors.grey.shade700)))]),

    );

  }



  Widget _buildPolicyItem(IconData icon, String title, String subtitle) {

    return Row(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: Icon(icon, color: Theme.of(context).primaryColor, size: 20)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 10))])
      ],
    );
  }

  @override
  void dispose() {
    globalLanguage.removeListener(_onLangChange);
    super.dispose();
  }

  void _onLangChange() => setState(() {});
}
