import 'package:flutter/material.dart';
import '../../core/localization.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/user_service.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning,';
    if (hour < 17) return 'Good Afternoon,';
    return 'Good Evening,';
  }

  



  void _showFilterSheet(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
    if (!mounted) return;
    if (result != null && result is Map<String, dynamic>) {
      if (result.containsKey('categories') && (result['categories'] is List ? result['categories'] as List : []).isNotEmpty) {
        setState(() {
          _selectedCategory = result['categories'][0].toString();
        });
      }
    }
  }



  @override

  Widget build(BuildContext context) {

    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, lang, _) {
        return Scaffold(

      backgroundColor: Colors.white,

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // 1. Header Row

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(_getGreeting(), style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),

                        const SizedBox(height: 4),

                        Row(

                          children: [

                            ValueListenableBuilder<Map<String, dynamic>?>(
                              valueListenable: globalUser,
                              builder: (context, user, _) {
                                final name = user?['name'] ?? UserService.mockProfile.value['name'] ?? 'Guest';
                                return Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black));
                              }
                            ),

                            const SizedBox(width: 5),

                            Container(width: 8, height: 8, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle)),

                          ],

                        )

                      ],

                    ),

                    Row(

                      children: [

                        ValueListenableBuilder<List<Map<String, dynamic>>>(
                          valueListenable: globalNotifications,
                          builder: (context, notifs, _) {
                            final hasUnread = notifs.any((n) => n['isRead'] == false);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                              },
                              child: Stack(
                                children: [
                                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.notifications_none, size: 22, color: Colors.black87)),
                                  if (hasUnread) Positioned(top: 10, right: 10, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                                ],
                              ),
                            );
                          }
                        ),

                        const SizedBox(width: 12),

                        GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())), child: ValueListenableBuilder<Map<String, dynamic>?>(
                          valueListenable: globalUser,
                          builder: (context, user, _) {
                            return CircleAvatar(radius: 22, backgroundImage: NetworkImage(user?['avatar'] ?? UserService.mockProfile.value['avatar'] ?? 'https://i.pravatar.cc/150?img=11'));
                          }
                        )),

                      ],

                    )

                  ],

                ),

              ),



              // 2. Search & Filter

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Row(

                  children: [

                    Expanded(

                      child: GestureDetector(

                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),

                        child: Container(

                          height: 55, padding: const EdgeInsets.symmetric(horizontal: 16),

                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),

                          child: Row(children: [Icon(Icons.search, color: Colors.grey.shade400), const SizedBox(width: 10), Text(tr('search_hint'), style: TextStyle(color: Colors.grey.shade400, fontSize: 15))]),

                        ),

                      ),

                    ),

                    const SizedBox(width: 12),

                    GestureDetector(

                      onTap: () => _showFilterSheet(context),

                      child: Container(

                        height: 55, width: 55,

                        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),

                        child: const Icon(Icons.tune, color: Colors.white),

                      ),

                    )

                  ],

                ),

              ),



              // 3. Promo Banner
              const PromoCarousel(),

              // 4. Categories (KEEPING EXISTING LOGOS)

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Text(tr('categories'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen())), child: Text(tr('see_all'), style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))

                  ],

                ),

              ),

              const SizedBox(height: 16),

              ValueListenableBuilder<List<Map<String, dynamic>>>(
                valueListenable: globalProducts,
                builder: (context, products, _) {
                  final cats = products.map((p) => p['category'].toString()).toSet().toList()..sort();
                  final _categories = ['All', ...cats];
                  
                  return SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        String iconUrl = 'assets/images/categories/tshirt.png';
                        final lowerCat = cat.toLowerCase();
                        if (lowerCat == 'shirts') iconUrl = 'assets/images/categories/shirt.png';
                        else if (lowerCat == 'pants') iconUrl = 'assets/images/categories/pants.png';
                        else if (lowerCat == 'jackets') iconUrl = 'assets/images/categories/jacket.png';
                        else if (lowerCat == 'shoes') iconUrl = 'assets/images/categories/shoe.png';
                        else if (lowerCat == 'bags') iconUrl = 'assets/images/categories/bag.png';
                        else if (lowerCat == 'accessories') iconUrl = 'assets/images/categories/watch.png';
                        
                        return CategoryItem(
                          title: cat,
                          iconUrl: iconUrl,
                          isSelected: _selectedCategory == cat,
                          onTap: () => setState(() => _selectedCategory = cat),
                        );
                      },
                    ),
                  );
                },
              ),



              // 5. Popular Deals

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    Row(

                      children: [

                        Text(tr('popular_deals'), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        const SizedBox(width: 8),

                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10)), child: Text('Hot', style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold))),

                      ],

                    ),

                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen())), child: Text(tr('see_all'), style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))

                  ],

                ),

              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: globalProducts,
                  builder: (context, products, _) {
                    final deals = products.take(4).toList();
                    return SizedBox(
                      height: 250,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: deals.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 160,
                            child: ProductCard(product: deals[index]),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),

              

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: Row(

                  children: [

                    Text(tr('new_arrivals'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                  ],

                ),

              ),
              const SizedBox(height: 15),
              // 6. Product Grid


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                  valueListenable: globalProducts,
                  builder: (context, products, child) {
                    final filtered = _selectedCategory.toLowerCase() == 'all'
                        ? products
                        : products.where((p) => p['category'].toString().toLowerCase() == _selectedCategory.toLowerCase()).toList();
                    final displayProducts = filtered.isNotEmpty ? filtered : <Map<String, dynamic>>[];
                    if (displayProducts.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 48, color: Colors.grey),
                              SizedBox(height: 12),
                              Text('No products found for this category.', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58),
                      itemCount: displayProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: displayProducts[index]);
                      }
                    );
                  }
                ),

              ),

              const SizedBox(height: 80), 


            ],
          ),
        ),
      ),
    );
      }
    );
  }
}

