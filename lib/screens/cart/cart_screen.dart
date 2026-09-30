import 'package:flutter/material.dart';
import 'package:cesc_commerce/core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, lang, _) {
        return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: Column(

          children: [

            // Header

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Navigator.canPop(context) 
                    ? GestureDetector(
                        onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      )
                    : const SizedBox(width: 40),

                  Text(tr('my_cart'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  Container(

                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                    child: const Icon(Icons.more_horiz, size: 20),

                  ),

                ],

              ),

            ),

            

            Expanded(

              child: ValueListenableBuilder<List<Map<String, dynamic>>>(

                valueListenable: globalCart,

                builder: (context, cartItems, child) {

                  if (cartItems.isEmpty) {

                    return _buildEmptyState(context);

                  }



                  double totalPrice = 0;

                  for (var item in cartItems) { 
                    double p = 0.0;
                    if (item['price'] is String) { p = double.tryParse(item['price'].toString().replaceAll('\$', '').trim()) ?? 0.0; } 
                    else if (item['price'] is num) { p = (item['price'] as num).toDouble(); }
                    totalPrice += p * ((item['qty'] as num?)?.toInt() ?? 1); 
                  }



                  return Column(

                    children: [

                      Expanded(

                        child: ListView.builder(

                          padding: const EdgeInsets.all(20), itemCount: cartItems.length,

                          itemBuilder: (context, index) {

                            final item = cartItems[index];

                            return _buildCartItem(context, index, item['title'], item['subtitle'], item['price'], item['qty'], item['image']);

                          },

                        ),

                      ),

                      Container(

                        padding: const EdgeInsets.all(24),

                        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))]),

                        child: Column(

                          mainAxisSize: MainAxisSize.min,

                          children: [

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(tr('total'), style: TextStyle(fontSize: 18, color: Colors.grey)), Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))]),

                            const SizedBox(height: 20),

                            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen(items: globalCart.value))), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: Text(tr('checkout'), style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))))

                          ],

                        ),

                      )

                    ]

                  );

                },

              ),

            ),

          ],

        )

      )

    );
      }
    );
  }

  Widget _buildEmptyState(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        children: [

          const SizedBox(height: 30),

          // Illustration Stack

          SizedBox(

            height: 160,

            child: Stack(

              alignment: Alignment.center,

              clipBehavior: Clip.none,

              children: [

                // Glow background

                Container(

                  width: 140, height: 140,

                  decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.15), shape: BoxShape.circle),

                ),

                // Main Square

                Stack(

                  clipBehavior: Clip.none,

                  children: [

                    Container(

                      width: 90, height: 90,

                      decoration: BoxDecoration(

                        color: Theme.of(context).primaryColor,

                        borderRadius: BorderRadius.circular(25),

                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10))]

                      ),

                      child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 45),

                    ),

                    Positioned(

                      bottom: -5, right: -5,

                      child: Container(

                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(color: const Color(0xFF1A1A24), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),

                        child: const Text('0', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),

                      ),

                    )

                  ],

                ),

                // Pill Top Right

                Positioned(

                  top: -10, right: 30,

                  child: Transform.rotate(

                    angle: 0.15,

                    child: Container(

                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: Text('% Off', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 12)),

                    ),

                  ),

                ),

                // Star Bottom Left

                Positioned(

                  bottom: 5, left: 30,

                  child: Transform.rotate(

                    angle: -0.15,

                    child: Container(

                      padding: const EdgeInsets.all(8),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),

                      child: const Icon(Icons.auto_awesome, color: Colors.orange, size: 16),

                    ),

                  ),

                ),

              ],

            ),

          ),

          const SizedBox(height: 30),

          Text(tr('your_cart_is_empty'), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A24))),

          const SizedBox(height: 12),

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 40),

            child: Text(

              "Looks like you haven't added anything to\nyour cart yet. Explore our summer deals and\ntrending products!",

              textAlign: TextAlign.center,

              style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.5)

            ),

          ),

          const SizedBox(height: 30),

          GestureDetector(

            onTap: () { Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()), (route) => false); },

            child: Container(

              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),

              decoration: BoxDecoration(

                color: Theme.of(context).primaryColor,

                borderRadius: BorderRadius.circular(30),

                boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))]

              ),

              child: Row(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Text(tr('start_shopping'), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),

                  SizedBox(width: 8),

                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),

                ],

              ),

            ),

          ),

          const SizedBox(height: 40),

          // Popular Deals Title

          Padding(

            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Row(

                  children: [

                    Text(tr('popular_deals'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    const SizedBox(width: 8),

                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10)), child: Text(tr('hot'), style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold))),

                  ],

                ),

                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen())), child: Text(tr('see_all'), style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))

              ],

            ),

          ),

          const SizedBox(height: 16),

          // Product Horizontal List

          SizedBox(

            height: 290,

            child: ValueListenableBuilder<List<Map<String, dynamic>>>(
              valueListenable: globalProducts,
              builder: (context, products, child) {
                final suggested = products.take(3).toList();
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: suggested.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return SizedBox(width: 170, child: ProductCard(product: suggested[index]));
                  }
                );
              }
            ),

          ),

          const SizedBox(height: 80),

        ],

      ),

    );

  }



  Widget _buildCartItem(BuildContext context, int index,
      dynamic title, dynamic subtitle, dynamic priceRaw,
      dynamic qty, dynamic img) {
    final safeTitle = title?.toString() ?? 'Product';
    final safeSubtitle = subtitle?.toString() ?? '';
    final safeQty = (qty as num?)?.toInt() ?? 1;
    final safeImg = img?.toString() ?? '';
    double price = 0.0;
    if (priceRaw is String) { price = double.tryParse(priceRaw.toString().replaceAll('\$', '').trim()) ?? 0.0; }
    else if (priceRaw is num) { price = priceRaw.toDouble(); }
    return Container(

      margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(10),

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),

      child: Row(

        children: [

          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(safeImg, width: 70, height: 70, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, size: 60))),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(safeTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)), GestureDetector(onTap: () => removeCartItem(index), child: const Icon(Icons.delete_outline, color: Colors.red, size: 20))]),

                const SizedBox(height: 4), Text(safeSubtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const SizedBox(height: 8),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('\$${price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16)), Row(children: [GestureDetector(onTap: () => updateCartItemQty(index, -1), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.remove, size: 16))), Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('$safeQty', style: const TextStyle(fontWeight: FontWeight.bold))), GestureDetector(onTap: () => updateCartItemQty(index, 1), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add, size: 16, color: Colors.white)))])])

              ],

            ),

          ),

        ],

      ),

    );

  }

}
