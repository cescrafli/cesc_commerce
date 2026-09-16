// ----------------------------------------------------------------------
// WIDGET UTAMA (BOTTOM NAVIGATION)
// ----------------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(), 
    const CartScreen(),         
    const FavoriteScreen(),     
    const ProfileScreen(),      
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 5))],
        ),
        child: FloatingActionButton(
          onPressed: () => setState(() => _currentIndex = 2),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          shape: const CircleBorder(),
          child: ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: globalCart,
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  if (cart.isNotEmpty)
                    Positioned(
                      top: 8, right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                        child: Text('${cart.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    )
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(Icons.home_filled, Icons.home_outlined, 0),
                  const SizedBox(width: 15),
                  _buildNavItem(Icons.grid_view_rounded, Icons.grid_view, 1),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNavItem(Icons.favorite, Icons.favorite_border, 3),
                  const SizedBox(width: 15),
                  _buildNavItem(Icons.person, Icons.person_outline, 4),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData activeIcon, IconData inactiveIcon, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        color: Colors.transparent,
        width: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isActive ? activeIcon : inactiveIcon, color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade400, size: 26),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(width: 4, height: 4, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle))
            ]
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                        Text('Good Morning,', style: TextStyle(fontSize: 14, color: Colors.grey.shade500)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Text('Cesc Fabregas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                            const SizedBox(width: 5),
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle)),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.notifications_none, size: 22, color: Colors.black87)),
                            Positioned(top: 10, right: 10, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                          ],
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())), child: const CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'))),
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
                          child: Row(children: [Icon(Icons.search, color: Colors.grey.shade400), const SizedBox(width: 10), Text('Search clothes, collections...', style: TextStyle(color: Colors.grey.shade400, fontSize: 15))]),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: const DecorationImage(image: NetworkImage('https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'), fit: BoxFit.cover),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(colors: [Colors.black.withOpacity(0.7), Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)), child: const Text('SUMMER 2024', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                        const SizedBox(height: 12),
                        const Text('Eco-Collection\nMountain Series', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
                        const SizedBox(height: 8),
                        const Text('Up to 40% OFF this week', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                              child: const Row(children: [Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), SizedBox(width: 4), Icon(Icons.arrow_forward, size: 14)]),
                            ),
                            Row(
                              children: [
                                Container(width: 16, height: 4, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(2))),
                                const SizedBox(width: 4),
                                Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white54, shape: BoxShape.circle)),
                                const SizedBox(width: 4),
                                Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white54, shape: BoxShape.circle)),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

              // 4. Categories (KEEPING EXISTING LOGOS)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen())), child: Text('See All', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12),
                  children: const [
                    CategoryItem(title: 'T-Shirts', iconUrl: 'assets/images/categories/tshirt.png', isSelected: true),
                    CategoryItem(title: 'Shirts', iconUrl: 'assets/images/categories/shirt.png', isSelected: false),
                    CategoryItem(title: 'Pants', iconUrl: 'assets/images/categories/pants.png', isSelected: false),
                    CategoryItem(title: 'Jackets', iconUrl: 'assets/images/categories/jacket.png', isSelected: false),
                    CategoryItem(title: 'Shoes', iconUrl: 'assets/images/categories/shoe.png', isSelected: false),
                  ],
                ),
              ),

              // 5. Popular Deals
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Popular Deals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10)), child: Text('Hot', style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteScreen())), child: Text('See All', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))
                  ],
                ),
              ),
              
              // 6. Product Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58,
                  children: [
                    ProductCard(title: 'Basic Eco-Cotton T-Shirt', subtitle: '100% Organic Cotton', price: '\$15.00', oldPrice: '\$22.00', imageUrl: 'https://picsum.photos/seed/101/300/400', rating: '4.8', reviews: '124', tag1: '-30%', tag2: 'Eco', isFav: true),
                    ProductCard(title: 'Denim Classic Jacket', subtitle: 'Cotton 100% Rigid', price: '\$30.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/102/300/400', rating: '4.9', reviews: '89', tag1: 'Bestseller', tag2: '', isFav: false),
                    ProductCard(title: 'Cargo Utility Pants', subtitle: 'Relaxed Fit Canvas', price: '\$28.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/103/300/400', rating: '4.7', reviews: '52', tag1: '', tag2: '', isFav: false),
                    ProductCard(title: 'Botanical Casual Shirt', subtitle: 'Lightweight Breathable', price: '\$18.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/104/300/400', rating: '4.6', reviews: '38', tag1: 'New', tag2: '', isFav: false),
                  ],
                ),
              ),
              const SizedBox(height: 80), 
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN KERANJANG 
// ----------------------------------------------------------------------
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const Text('My Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                  for (var item in cartItems) { totalPrice += (item['price'] as double) * (item['qty'] as int); }

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
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Total:', style: TextStyle(fontSize: 18, color: Colors.grey)), Text('\$${totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))]),
                            const SizedBox(height: 20),
                            SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen())), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Checkout', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))))
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
          const Text('Your Cart is Empty', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A24))),
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
            onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8))]
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Start Shopping', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
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
                    const Text('Popular Deals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(10)), child: Text('Hot', style: TextStyle(color: Colors.orange.shade800, fontSize: 10, fontWeight: FontWeight.bold))),
                  ],
                ),
                GestureDetector(onTap: () {}, child: Text('See All', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Product Horizontal List
          SizedBox(
            height: 290,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SizedBox(width: 170, child: ProductCard(title: 'Basic Eco-Cotton T-Shirt', subtitle: '100% Organic Cotton', price: '\$15.00', oldPrice: '\$22.00', imageUrl: 'https://picsum.photos/seed/101/300/400', rating: '4.8', reviews: '124', tag1: '-30%', tag2: 'Eco', isFav: true)),
                const SizedBox(width: 16),
                SizedBox(width: 170, child: ProductCard(title: 'Denim Classic Jacket', subtitle: 'Cotton 100% Rigid', price: '\$30.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/102/300/400', rating: '4.9', reviews: '89', tag1: 'Bestseller', tag2: '', isFav: false)),
                const SizedBox(width: 16),
                SizedBox(width: 170, child: ProductCard(title: 'Cargo Utility Pants', subtitle: 'Relaxed Fit Canvas', price: '\$28.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/103/300/400', rating: '4.7', reviews: '52', tag1: 'Popular', tag2: '', isFav: false)),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index, String title, String subtitle, double price, int qty, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.network(img, width: 70, height: 70, fit: BoxFit.cover)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis)), GestureDetector(onTap: () => removeCartItem(index), child: const Icon(Icons.delete_outline, color: Colors.red, size: 20))]),
                const SizedBox(height: 4), Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('\$${price.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 16)), Row(children: [GestureDetector(onTap: () => updateCartItemQty(index, -1), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.remove, size: 16))), Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold))), GestureDetector(onTap: () => updateCartItemQty(index, 1), child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add, size: 16, color: Colors.white)))])])
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN PERSONAL INFO 
// ----------------------------------------------------------------------
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const Text('Personal Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.edit_outlined, size: 20, color: Colors.cyan),
                    ),
                  ],
                ),
              ),

              // 2. Profile Avatar
              const SizedBox(height: 10),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),
                      color: Colors.white
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: Icon(Icons.person, size: 50, color: Colors.grey.shade400),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    )
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Cesc Fabregas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  const Icon(Icons.verified, color: Colors.orange, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)),
                child: Text('GOLD VIP MEMBER', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),

              // 3. Basic Information Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('BASIC INFORMATION', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                        Text('Auto-saved', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTextField('Full Name', 'Cesc Fabregas', Icons.person_outline),
                    const SizedBox(height: 20),
                    _buildTextField('Email Address', 'cesc.fabregas@clubmail.com', Icons.mail_outline, rightLabel: _buildVerifiedBadge()),
                    const SizedBox(height: 20),
                    _buildTextField('Phone Number', '(555) 382-9014', Icons.phone_outlined, rightLabel: _buildVerifiedBadge(), prefix: Row(children: [Text('ðŸ‡ºðŸ‡¸ +1', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)), const SizedBox(width: 8), Container(height: 20, width: 1, color: Colors.grey.shade300)])),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Date of Birth', 'May 4, 1987', Icons.calendar_today_outlined)),
                        const SizedBox(width: 15),
                        Expanded(child: _buildTextField('Gender', 'Male', Icons.keyboard_arrow_down)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // 4. Primary Delivery Address Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: 20),
                        const SizedBox(width: 10),
                        const Expanded(child: Text('Primary Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text('DEFAULT', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)))
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Home Residence', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                              const SizedBox(height: 4),
                              Text('742 Evergreen Terrace\nSpringfield, OR 97477', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.4)),
                            ],
                          ),
                          Text('Edit', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // 5. Account & Security Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ACCOUNT & SECURITY', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle), child: Icon(Icons.lock_outline, color: Colors.grey.shade600, size: 20)),
                        const SizedBox(width: 15),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text('â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢â€¢', style: TextStyle(color: Colors.grey.shade400, fontSize: 16))])),
                        Text('Change', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13, fontWeight: FontWeight.bold))
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle), child: const Icon(Icons.security, color: Colors.green, size: 20)),
                        const SizedBox(width: 15),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('2-Step Verification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text('Enhanced protection', style: TextStyle(color: Colors.grey.shade400, fontSize: 12))])),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.green.shade200), borderRadius: BorderRadius.circular(15)), child: const Text('Enabled', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)))
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 6. Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity, height: 55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.check, color: Colors.white, size: 20)]),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(child: Text('Discard Changes', style: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.bold))),
              const SizedBox(height: 40),
            ]
          )
        )
      )
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
          const SizedBox(width: 4),
          const Text('Verified', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String value, IconData icon, {Widget? rightLabel, Widget? prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
            if (rightLabel != null) rightLabel
          ]
        ),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
          child: Row(
            children: [
              if (prefix != null) ...[prefix, const SizedBox(width: 10)],
              Expanded(child: Text(value, style: const TextStyle(fontSize: 14, color: Colors.black87))),
              Icon(icon, size: 18, color: Colors.grey.shade400)
            ]
          )
        )
      ]
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET BANTUAN UI 
// ----------------------------------------------------------------------
class ProductCard extends StatelessWidget { 
  final String title; final String subtitle; final String price; final String oldPrice; final String imageUrl; 
  final String rating; final String reviews; final String tag1; final String tag2; final bool isFav;
  
  const ProductCard({super.key, required this.title, required this.subtitle, required this.price, this.oldPrice = '', required this.imageUrl, required this.rating, required this.reviews, this.tag1 = '', this.tag2 = '', this.isFav = false}); 
  
  @override 
  Widget build(BuildContext context) { 
    return GestureDetector(
      onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(title: title, price: price, imageUrl: imageUrl))); }, 
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(20)), child: Image.network(imageUrl, width: double.infinity, height: double.infinity, fit: BoxFit.cover)), 
                  // Favorite Button
                  Positioned(
                    top: 10, right: 10, 
                    child: Container(
                      padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), shape: BoxShape.circle), 
                      child: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 16, color: isFav ? Colors.red : Colors.grey)
                    )
                  ),
                  // Tags
                  Positioned(
                    top: 10, left: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tag1.isNotEmpty) Container(margin: const EdgeInsets.only(bottom: 4), padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: tag1.contains('%') ? Theme.of(context).primaryColor : Colors.black87, borderRadius: BorderRadius.circular(6)), child: Text(tag1, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
                        if (tag2.isNotEmpty) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(6)), child: Text(tag2, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  )
                ]
              )
            ), 
            Padding(
              padding: const EdgeInsets.all(12.0), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber.shade500, size: 14), const SizedBox(width: 4),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)), const SizedBox(width: 4),
                      Text('($reviews)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2), maxLines: 2, overflow: TextOverflow.ellipsis), 
                  const SizedBox(height: 2), 
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis), 
                  const SizedBox(height: 10), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(price, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
                          if (oldPrice.isNotEmpty) Text(oldPrice, style: TextStyle(color: Colors.grey.shade400, decoration: TextDecoration.lineThrough, fontSize: 10)),
                        ],
                      ), 
                      GestureDetector(
                        onTap: () { addToCart(title, subtitle, price, imageUrl, context); }, 
                        child: Container(
                          padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(8)), 
                          child: const Icon(Icons.add, color: Colors.white, size: 18)
                        )
                      )
                    ]
                  )
                ]
              )
            )
          ]
        )
      )
    ); 
  } 
}

class ProductDetailScreen extends StatefulWidget {
  final String title;
  final String price;
  final String imageUrl;
  const ProductDetailScreen({super.key, required this.title, required this.price, required this.imageUrl});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 1;
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 2;

  final List<Color> _colors = [const Color(0xFF507A60), const Color(0xFF2E2E2E), const Color(0xFF8B6C55), const Color(0xFFF0EBE1)];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
        child: SafeArea(
          child: Row(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), shape: BoxShape.circle),
                child: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    for(int i=0; i<_qty; i++) { addToCart(widget.title, 'Size: ${_sizes[_selectedSizeIndex]}', widget.price, widget.imageUrl, context); }
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(side: BorderSide(color: Theme.of(context).primaryColor, width: 2), padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_bag_outlined, color: Theme.of(context).primaryColor, size: 18), const SizedBox(width: 8), Text('Add to Cart', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 15))]),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    for(int i=0; i<_qty; i++) { addToCart(widget.title, 'Size: ${_sizes[_selectedSizeIndex]}', widget.price, widget.imageUrl, context); }
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, padding: const EdgeInsets.symmetric(vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.flash_on, color: Colors.white, size: 18), SizedBox(width: 4), Text('Buy Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15))]),
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
            Image.network(widget.imageUrl, height: 420, width: double.infinity, fit: BoxFit.cover),
            
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
                        CircleAvatar(backgroundColor: Colors.black45, child: IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white, size: 20), onPressed: () {})),
                        const SizedBox(width: 10),
                        CircleAvatar(backgroundColor: Colors.black45, child: IconButton(icon: const Icon(Icons.share, color: Colors.white, size: 20), onPressed: () {})),
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
                      Expanded(child: Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.2))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.price, style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              const Text('\$22.00', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 12)),
                              const SizedBox(width: 5),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(4)), child: Text('30% OFF', style: TextStyle(color: Colors.red.shade700, fontSize: 10, fontWeight: FontWeight.bold))),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  // Tags and Rating
                  Row(
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(border: Border.all(color: Colors.green), borderRadius: BorderRadius.circular(4)), child: const Text('In Stock', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))),
                      const SizedBox(width: 10),
                      Text('â€¢ Mountain Series', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber.shade500, size: 18),
                          const SizedBox(width: 4),
                          const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(width: 4),
                          const Text('(124 Verified Reviews)', style: TextStyle(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline)),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.green, size: 16),
                          const SizedBox(width: 4),
                          Text('Eco Certified', style: TextStyle(color: Colors.green.shade700, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  
                  // Color Picker
                  Text('COLOR: Moss Green', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                  const SizedBox(height: 10),
                  Row(
                    children: List.generate(_colors.length, (index) => GestureDetector(
                      onTap: () => setState(() => _selectedColorIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _selectedColorIndex == index ? Theme.of(context).primaryColor : Colors.transparent, width: 2)),
                        child: CircleAvatar(backgroundColor: _colors[index], radius: 15),
                      ),
                    )),
                  ),
                  const SizedBox(height: 25),

                  // Size Picker
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('SELECT SIZE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                      Row(children: [Icon(Icons.straighten, color: Theme.of(context).primaryColor, size: 14), const SizedBox(width: 4), Text('Size Guide', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold))])
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_sizes.length, (index) => GestureDetector(
                      onTap: () => setState(() => _selectedSizeIndex = index),
                      child: Container(
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
                  const SizedBox(height: 25),

                  // Quantity
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
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
                  const Text('DESCRIPTION', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text('Premium 100% organic cotton apparel designed for everyday comfort and outdoor durability. Breathable, sweat-absorbent, and sustainably crafted to endure rugged adventures or relaxed casual wear.', style: TextStyle(fontSize: 13, color: Colors.grey.shade700, height: 1.5)),
                  const SizedBox(height: 20),
                  
                  // Features Grid
                  GridView.count(
                    crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 4.5, mainAxisSpacing: 10, crossAxisSpacing: 10,
                    children: [
                      _buildFeatureItem('100% Organic Cotton'), _buildFeatureItem('Pre-shrunk Fabric'),
                      _buildFeatureItem('Machine Wash Cold'), _buildFeatureItem('Non-Toxic Eco Dyes'),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('TOP CUSTOMER REVIEW', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('View all (124)', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(backgroundColor: Theme.of(context).primaryColor, radius: 16, child: const Text('E', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                            const SizedBox(width: 10),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Elena R.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Row(children: const [Icon(Icons.verified, color: Colors.green, size: 12), SizedBox(width: 4), Text('Verified Buyer', style: TextStyle(color: Colors.green, fontSize: 10))])])),
                            Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 12))),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text('"The fit is immaculate and the cotton feels super breathable during weekend hikes. Loved it so much I ordered two more shades!"', style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey.shade700)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
}

// ----------------------------------------------------------------------
// HALAMAN-HALAMAN LAINNYA 
// ----------------------------------------------------------------------
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedShipping = 'Standard Eco';

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
                  Column(
                    children: [
                      const Text('Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('ORDER #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade100)),
                    child: const Row(
                      children: [
                        Icon(Icons.lock, color: Colors.green, size: 12),
                        SizedBox(width: 4),
                        Text('Secure', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Progress Bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(padding: const EdgeInsets.all(6), decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14)),
                  const SizedBox(width: 6),
                  const Text('Cart', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(width: 10),
                  Container(width: 20, height: 2, color: const Color(0xFF00BCD4)),
                  const SizedBox(width: 10),
                  Container(width: 24, height: 24, alignment: Alignment.center, decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 6),
                  const Text('Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(width: 10),
                  Container(width: 20, height: 2, color: Colors.grey.shade200),
                  const SizedBox(width: 10),
                  Container(width: 24, height: 24, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)), child: Text('3', style: TextStyle(color: Colors.grey.shade400, fontSize: 12, fontWeight: FontWeight.bold))),
                  const SizedBox(width: 6),
                  Text('Payment', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3. Delivery Address
                    Row(
                      children: [
                        const Text('Delivery Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen())),
                          child: const Text('Change', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.location_on, color: Color(0xFF00BCD4), size: 20)),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Home Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                        const SizedBox(width: 6),
                                        Text('â€¢ Primary', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    RichText(text: TextSpan(style: const TextStyle(fontSize: 13, color: Colors.black87), children: [const TextSpan(text: 'Cesc Fabregas ', style: TextStyle(fontWeight: FontWeight.w600)), TextSpan(text: '(+1858-555-0192)', style: TextStyle(color: Colors.grey.shade500))])),
                                    const SizedBox(height: 4),
                                    Text('123 Main Street, Apt 4B, San Diego, CA 92101', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.only(top: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, color: Color(0xFF0F8A9E), size: 16),
                                    const SizedBox(width: 6),
                                    RichText(text: TextSpan(style: TextStyle(color: Colors.grey.shade600, fontSize: 12), children: [const TextSpan(text: 'Delivery by '), const TextSpan(text: 'Tomorrow, 14:00', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))])),
                                  ],
                                ),
                                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('Fast Transit', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 4. Shipping Method
                    const Text('Shipping Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedShipping = 'Standard Eco'),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selectedShipping == 'Standard Eco' ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: selectedShipping == 'Standard Eco' ? 1.5 : 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Standard Eco', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      Icon(selectedShipping == 'Standard Eco' ? Icons.check_circle : Icons.circle_outlined, color: selectedShipping == 'Standard Eco' ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 18),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('2-3 Business Days', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                  const SizedBox(height: 10),
                                  const Text('FREE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedShipping = 'Express Priority'),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: selectedShipping == 'Express Priority' ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: selectedShipping == 'Express Priority' ? 1.5 : 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Express Priority', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      Icon(selectedShipping == 'Express Priority' ? Icons.check_circle : Icons.circle_outlined, color: selectedShipping == 'Express Priority' ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 18),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text('Next Day by 10 AM', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                  const SizedBox(height: 10),
                                  const Text('+\$6.99', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // 5. Payment Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen())),
                          child: const Text('Manage', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
                            child: const Text('VISA', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16, fontStyle: FontStyle.italic)),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Visa ending in 4242', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    const SizedBox(width: 8),
                                    Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('Expires 08/27 â€¢ Debit Card', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: const Color(0xFF16161D), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          const Icon(Icons.apple, color: Colors.white, size: 30),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Apple Pay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('1-Touch Instant Checkout Enabled', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              const Text('Ready', style: TextStyle(color: Colors.green, fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 6. Order Items
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Order Items (2)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditBagScreen())),
                          child: Text('Edit Bag', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildOrderItemCard(Icons.checkroom, 'Denim Classic Jacket', 'Size: L â€¢ Indigo Blue â€¢ Qty: 1', '\$30.00'),
                    _buildOrderItemCard(Icons.eco, 'Basic Eco-Cotton T-Shirt', 'Size: M â€¢ Sand Linen â€¢ Qty: 1', '\$15.00', iconColor: Colors.green),
                    const SizedBox(height: 25),

                    // 7. Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Delivery Fee', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const Text('FREE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.local_offer, color: Colors.green, size: 14), const SizedBox(width: 6), Text('Eco Member Discount (-10%)', style: TextStyle(color: Colors.green.shade600, fontSize: 13))]), const Text('-\$4.50', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 15),
                          Row(
                            children: List.generate(40, (index) => Expanded(child: Container(color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300, height: 1))),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text('Includes all local taxes & duties', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                                ],
                              ),
                              const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () { globalCart.value = []; Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())); },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.shield, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Place Order', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('\$40.50', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.grey.shade400, size: 12),
                      const SizedBox(width: 6),
                      Text('100% Secure 256-bit Encrypted Checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemCard(IconData icon, String title, String subtitle, String price, {Color iconColor = Colors.grey}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: iconColor == Colors.grey ? Colors.blueGrey.shade700 : iconColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int selectedAddress = 0;
  bool prefLeaveAtDoor = true;
  bool prefEco = true;

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
                  Column(
                    children: [
                      const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('SELECT SHIPPING LOCATION', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                    child: const Icon(Icons.add, color: Color(0xFF00BCD4), size: 20),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Bar
                    Container(
                      height: 50,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                          const SizedBox(width: 10),
                          Expanded(child: TextField(decoration: InputDecoration(hintText: 'Search saved addresses, zip codes...', hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14), border: InputBorder.none))),
                          Icon(Icons.filter_alt_outlined, color: Colors.grey.shade400, size: 20),
                          const SizedBox(width: 15),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Current GPS
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.my_location, color: Colors.white, size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Use Current GPS Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('Downtown, San Diego, CA', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)), child: const Text('Locate', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Saved Addresses Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('SAVED ADDRESSES (3)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                        Text('Tap to select', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Address 1
                    _buildAddressCard(
                      index: 0,
                      icon: Icons.home_outlined,
                      title: 'Home Address',
                      pillText: 'DEFAULT',
                      subtitle1: 'Primary residence',
                      nameAndPhone: 'Cesc Fabregas  |  (+1 858-555-0192)',
                      addressText: '123 Main Street, Apt 4B, San Diego, CA 92101',
                      extraWidget: Container(margin: const EdgeInsets.only(top: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.green.shade100)), child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.check_circle, color: Colors.green, size: 12), SizedBox(width: 4), Text('Fast Transit â€¢ Door concierge delivery', style: TextStyle(color: Colors.green, fontSize: 11))])),
                    ),
                    const SizedBox(height: 15),

                    // Address 2
                    _buildAddressCard(
                      index: 1,
                      icon: Icons.business_center_outlined,
                      title: 'Office / Work',
                      pillText: 'OFFICE',
                      isGreyPill: true,
                      subtitle1: 'Weekdays delivery',
                      nameAndPhone: 'Cesc Fabregas  |  (+1 858-555-0192)',
                      addressText: '789 Innovation Parkway, Suite 300, San Diego, CA 92121',
                      extraWidget: Container(margin: const EdgeInsets.only(top: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('Office hours only (09:00 - 18:00)', style: TextStyle(color: Colors.grey.shade600, fontSize: 11))),
                    ),
                    const SizedBox(height: 15),

                    // Address 3
                    _buildAddressCard(
                      index: 2,
                      icon: Icons.apartment_outlined,
                      title: 'Parents\' House',
                      pillText: 'FAMILY',
                      isGreyPill: true,
                      subtitle1: 'Weekend delivery',
                      nameAndPhone: 'Elena Fabregas  |  (+1 858-772-4091)',
                      addressText: '45 Ocean Breeze Terrace, La Jolla, CA 92037',
                      extraWidget: Container(margin: const EdgeInsets.only(top: 8), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)), child: Text('Ring doorbell twice upon arrival', style: TextStyle(color: Colors.grey.shade600, fontSize: 11))),
                    ),
                    const SizedBox(height: 25),

                    // Add New Address Button
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewAddressScreen())),
                      child: Container(
                        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.5), width: 2)), 
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.add, color: Color(0xFF00BCD4), size: 16)),
                            const SizedBox(width: 10),
                            const Text('Add New Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Delivery Preferences
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.gpp_good_outlined, color: Color(0xFF0F8A9E), size: 20),
                              SizedBox(width: 8),
                              Text('Delivery Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Leave at door if not home', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                  const SizedBox(height: 4),
                                  Text('Driver will take photo proof of delivery', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                ],
                              ),
                              Switch(value: prefLeaveAtDoor, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => prefLeaveAtDoor = val)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Divider(height: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Eco-friendly minimal packaging', style: TextStyle(fontSize: 13, color: Colors.black87)),
                                        const SizedBox(width: 6),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.eco, color: Colors.green, size: 10), SizedBox(width: 2), Text('Eco', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))])),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('100% biodegradable corrugated box', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Switch(value: prefEco, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => prefEco = val)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Deliver to This Address', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('CONFIRM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_user, color: Color(0xFF0F8A9E), size: 14),
                      const SizedBox(width: 6),
                      Text('100% Guaranteed On-Time Safe Delivery', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard({
    required int index, required IconData icon, required String title, required String pillText, bool isGreyPill = false,
    required String subtitle1, required String nameAndPhone, required String addressText, Widget? extraWidget,
  }) {
    bool isSelected = selectedAddress == index;
    return GestureDetector(
      onTap: () => setState(() => selectedAddress = index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSelected ? 2 : 1),
          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))] : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: isSelected ? Colors.white : Colors.grey.shade600, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(width: 8),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isGreyPill ? Colors.grey.shade100 : const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(6)), child: Text(pillText, style: TextStyle(color: isGreyPill ? Colors.grey.shade600 : Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(subtitle1, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),
              ],
            ),
            const SizedBox(height: 15),
            Text(nameAndPhone, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
            const SizedBox(height: 6),
            Text(addressText, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),
            if (extraWidget != null) extraWidget,
            const SizedBox(height: 15),
            Divider(height: 1, color: Colors.grey.shade100),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isSelected ? 'Selected for this order' : 'Select this address', style: TextStyle(color: isSelected ? const Color(0xFF0F8A9E) : const Color(0xFF00BCD4), fontSize: 12, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditAddressScreen())),
                  child: Row(
                    children: [
                      const Icon(Icons.edit, size: 14, color: Colors.black87),
                      const SizedBox(width: 4),
                      const Text('Edit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    if (isSelected) ...[
                      const SizedBox(width: 10),
                      const Icon(Icons.more_vert, size: 16, color: Colors.grey),
                    ]
                  ],
                ),
               )
              ],
            )
          ],
        ),
      ),
    );
  }
}
class EditBagScreen extends StatefulWidget {
  const EditBagScreen({super.key});

  @override
  State<EditBagScreen> createState() => _EditBagScreenState();
}

class _EditBagScreenState extends State<EditBagScreen> {
  int qty1 = 1;
  String size1 = 'L';
  int color1 = 0; // 0: Indigo, 1: Black, 2: Grey
  
  int qty2 = 1;
  String size2 = 'M';
  int color2 = 0; // 0: Sand, 1: White, 2: Green

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
                  Column(
                    children: [
                      const Text('Edit Bag', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('2 ITEMS SELECTED â€¢ ORDER #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, color: Colors.red.shade400, size: 14),
                        const SizedBox(width: 4),
                        Text('Clear', style: TextStyle(color: Colors.red.shade400, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFE8FAF6), borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.3))),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle), child: const Icon(Icons.eco, color: Colors.greenAccent, size: 18)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Eco Member Discount Active', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(height: 2),
                                Text('Extra -10% automatically deducted on final bag.', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(12)), child: const Text('APPLIED', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Section Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('EDITABLE ITEMS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                            const SizedBox(width: 8),
                            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Text('2', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Text('Auto-saved to checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Item 1
                    _buildEditableItem(
                      icon: Icons.checkroom, iconColor: Colors.blueGrey.shade800,
                      badgeText: 'Eco',
                      title: 'Denim Classic Jacket',
                      desc: 'Classic Fit â€¢ Heavyweight 14oz Cotton',
                      statusColor: Colors.green, statusText: 'In Stock â€¢ Ships Tomorrow 14:00',
                      price: '\$30.00',
                      sizeList: ['S', 'M', 'L', 'XL'],
                      selectedSize: size1,
                      onSizeChanged: (s) => setState(() => size1 = s),
                      colorName: 'INDIGO BLUE',
                      colorList: [const Color(0xFF2C3E50), const Color(0xFF1A1A24), const Color(0xFF95A5A6)],
                      selectedColorIdx: color1,
                      onColorChanged: (c) => setState(() => color1 = c),
                      qty: qty1,
                      onQtyAdd: () => setState(() => qty1++),
                      onQtySub: () => setState(() { if (qty1 > 1) qty1--; }),
                    ),
                    const SizedBox(height: 20),

                    // Item 2
                    _buildEditableItem(
                      icon: Icons.eco, iconColor: Colors.green.shade700,
                      badgeText: '100% Bio', badgeColor: Colors.green,
                      title: 'Basic Eco-Cotton T-Shirt',
                      desc: 'Breathable Organic Weave',
                      statusColor: const Color(0xFF0F8A9E), statusText: 'Carbon Neutral Shipping',
                      price: '\$15.00',
                      sizeList: ['XS', 'S', 'M', 'L'],
                      selectedSize: size2,
                      onSizeChanged: (s) => setState(() => size2 = s),
                      colorName: 'SAND LINEN',
                      colorList: [const Color(0xFFD2B48C), const Color(0xFFF5F5F5), const Color(0xFF2F4F4F)],
                      selectedColorIdx: color2,
                      onColorChanged: (c) => setState(() => color2 = c),
                      qty: qty2,
                      onQtyAdd: () => setState(() => qty2++),
                      onQtySub: () => setState(() { if (qty2 > 1) qty2--; }),
                    ),
                    const SizedBox(height: 25),

                    // Promo Code
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.sell_outlined, color: Color(0xFF0F8A9E), size: 16),
                              const SizedBox(width: 8),
                              const Text('PROMO CODE OR GIFT CARD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 45,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF00BCD4))),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check_circle, color: Color(0xFF0F8A9E), size: 16),
                                      const SizedBox(width: 8),
                                      const Text('ECOMEMBER10', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 45, padding: const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: const Color(0xFF16161D), borderRadius: BorderRadius.circular(12)),
                                child: const Text('Applied', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Live Bag Calculation
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('LIVE BAG CALCULATION', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                          const SizedBox(height: 15),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal (2 items)', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)), const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.check, color: Color(0xFF0F8A9E), size: 14), const SizedBox(width: 6), Text('Standard Eco Delivery', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13))]), const Text('FREE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [const Icon(Icons.local_offer, color: Color(0xFF0F8A9E), size: 14), const SizedBox(width: 6), Text('Eco Member Discount (-10%)', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 13))]), const Text('-\$4.50', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 15),
                          Row(
                            children: List.generate(40, (index) => Expanded(child: Container(color: index % 2 == 0 ? Colors.transparent : Colors.grey.shade300, height: 1))),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text('Taxes & import duties included', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                                ],
                              ),
                              const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // Free shipping banner
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.local_shipping, color: Colors.orange, size: 16),
                        const SizedBox(width: 6),
                        RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12), children: [TextSpan(text: 'You unlocked '), TextSpan(text: 'Free Eco Shipping', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: '!')])),
                        const SizedBox(width: 10),
                        const Text('Saved \$6.99', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 16)),
                          const Text('Update & Return to\nCheckout', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, height: 1.2)),
                          Row(
                            children: [
                              const Text('\$40.50', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock, color: Colors.grey.shade400, size: 12),
                      const SizedBox(width: 6),
                      Text('Changes automatically update your checkout summary', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditableItem({
    required IconData icon, required Color iconColor, required String badgeText, Color badgeColor = const Color(0xFF0F8A9E),
    required String title, required String desc, required Color statusColor, required String statusText, required String price,
    required List<String> sizeList, required String selectedSize, required Function(String) onSizeChanged,
    required String colorName, required List<Color> colorList, required int selectedColorIdx, required Function(int) onColorChanged,
    required int qty, required VoidCallback onQtyAdd, required VoidCallback onQtySub,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: iconColor, size: 30),
                  ),
                  Positioned(
                    bottom: -5, right: -5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                      child: Text(badgeText, style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                        Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(desc, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        Text(statusText, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          
          // Size
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text('SIZE SELECTED: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
                  Text(selectedSize, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F8A9E))),
                ],
              ),
              const Text('Size Guide', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 11, decoration: TextDecoration.underline)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: sizeList.map((s) {
              bool isSel = s == selectedSize;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onSizeChanged(s),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSel ? const Color(0xFF0F8A9E) : Colors.white,
                      border: Border.all(color: isSel ? const Color(0xFF0F8A9E) : Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(s, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: isSel ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Color
          Row(
            children: [
              const Text('COLOR: ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
              Text(colorName, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(colorList.length, (idx) {
              bool isSel = idx == selectedColorIdx;
              return GestureDetector(
                onTap: () => onColorChanged(idx),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: isSel ? const Color(0xFF0F8A9E) : Colors.transparent, width: 1.5)),
                  child: Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(color: colorList[idx], shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                    child: isSel ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Divider(height: 1, color: Colors.grey.shade100),
          const SizedBox(height: 15),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                child: Row(
                  children: [
                    InkWell(onTap: onQtySub, borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Icon(Icons.remove, size: 16, color: Colors.grey.shade600))),
                    Text('$qty', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    InkWell(onTap: onQtyAdd, borderRadius: const BorderRadius.horizontal(right: Radius.circular(20)), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), child: Icon(Icons.add, size: 16, color: Colors.grey.shade600))),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const Text('Save Later', style: TextStyle(color: Colors.black87, fontSize: 12))),
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.delete_outline, color: Colors.red.shade400, size: 18)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  int selectedLabel = 0; // 0: Home, 1: Office, 2: Parents
  bool isDefault = true;
  bool isEco = true;

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
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Add New Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text('SHIPPING & BILLING DETAILS', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 38), // Balance for centering
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map Area
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                        // Simulate grid lines background
                        image: const DecorationImage(
                          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), // Mock map texture
                          repeat: ImageRepeat.repeat,
                          opacity: 0.1,
                        )
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))]),
                                  child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                                ),
                                Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle)),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 15, left: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
                              child: Row(
                                children: [
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                  const SizedBox(width: 6),
                                  const Text('Precise Pin Enabled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15, right: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                children: [
                                  Icon(Icons.pinch, color: Colors.white, size: 14),
                                  SizedBox(width: 6),
                                  Text('Adjust Pin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Current GPS
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.my_location, color: Colors.white, size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Use Current GPS Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('Downtown, San Diego, CA', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)), child: const Text('Locate', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Contact Person Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('CONTACT PERSON', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                        const Text('Saved profile used', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('Full Name *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', suffixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Mobile Phone Number *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                          child: const Row(children: [Text('ðŸ‡ºðŸ‡¸ +1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18)]),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                            child: const TextField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: '(858) 555-0192', suffixIcon: Icon(Icons.check, color: Colors.green, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Couriers will call or SMS for access updates.', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    const SizedBox(height: 25),

                    // Address Details Section
                    Text('ADDRESS DETAILS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                    const SizedBox(height: 15),
                    const Text('Street Address *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '123 Main Street'), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 15),
                    const Text('Apartment, Suite, Unit, Building (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'Apt 4B'), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('City *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'San Diego'), style: TextStyle(fontSize: 14))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('ZIP / Postal Code *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '92101'), style: TextStyle(fontSize: 14))),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),
                    const Text('State / Region *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'California (CA)', suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey), suffixIconConstraints: BoxConstraints(minWidth: 20)), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 25),
                    const Text('Address Label Tag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildLabelPill(0, 'Home', Icons.home_outlined),
                          const SizedBox(width: 10),
                          _buildLabelPill(1, 'Office / Work', Icons.business_center_outlined),
                          const SizedBox(width: 10),
                          _buildLabelPill(2, 'Parents / Fam', Icons.apartment_outlined),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Instructions / Courier Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('Optional', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(maxLines: 3, decoration: InputDecoration(border: InputBorder.none, hintText: 'Ring doorbell twice upon arrival'), style: TextStyle(fontSize: 14)),
                    ),

                    const SizedBox(height: 25),

                    // Settings Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.verified_user_outlined, color: Color(0xFF0F8A9E), size: 20),
                              SizedBox(width: 8),
                              Text('DELIVERY & ADDRESS SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Set as Default Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(width: 8),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Use as primary destination for fast 1-click checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Switch(value: isDefault, activeColor: Colors.blueAccent, onChanged: (val) => setState(() => isDefault = val)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Divider(height: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Eco-friendly minimal packaging', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(width: 6),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.eco, color: Colors.green, size: 10), SizedBox(width: 2), Text('Eco', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))])),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('100% biodegradable corrugated box & paper tape', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Switch(value: isEco, activeColor: Colors.blueAccent, onChanged: (val) => setState(() => isEco = val)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Save & Use This Address', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('CONFIRM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_user, color: Colors.greenAccent, size: 14),
                      const SizedBox(width: 6),
                      Text('100% Guaranteed On-Time Safe Delivery & Encrypted', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelPill(int index, String title, IconData icon) {
    bool isSel = selectedLabel == index;
    return GestureDetector(
      onTap: () => setState(() => selectedLabel = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFF00BCD4) : Colors.white,
          border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSel ? Colors.white : Colors.grey.shade600, size: 16),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  int selectedLabel = 0; // 0: Home, 1: Office, 2: Parents
  bool isDefault = true;
  bool isEco = true;

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
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Edit Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text('UPDATE SHIPPING & BILLING DETAILS', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
                    child: Icon(Icons.delete_outline, color: Colors.red.shade400, size: 22),
                  ), 
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Map Area
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                        image: const DecorationImage(
                          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), 
                          repeat: ImageRepeat.repeat,
                          opacity: 0.1,
                        )
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))]),
                                  child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                                ),
                                Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle)),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 15, left: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),
                              child: Row(
                                children: [
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                  const SizedBox(width: 6),
                                  const Text('Precise Pin Enabled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15, right: 15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(12)),
                              child: const Row(
                                children: [
                                  Icon(Icons.pinch, color: Colors.white, size: 14),
                                  SizedBox(width: 6),
                                  Text('Adjust Pin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Current GPS
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.my_location, color: Colors.white, size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Use Current GPS Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('Downtown, San Diego, CA', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)), child: const Text('Locate', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Contact Person Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('CONTACT PERSON', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                        Row(
                          children: [
                            Icon(Icons.sync, color: const Color(0xFF0F8A9E), size: 14),
                            const SizedBox(width: 4),
                            const Text('Sync with profile', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text('Full Name *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', suffixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Mobile Phone Number *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                          child: const Row(children: [Text('ðŸ‡ºðŸ‡¸ +1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18)]),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                            child: const TextField(
                              decoration: InputDecoration(border: InputBorder.none, hintText: '(858) 555-0192', suffixIcon: Icon(Icons.check, color: Colors.green, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text('Couriers will call or SMS for access updates.', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    const SizedBox(height: 25),

                    // Address Details Section
                    Text('ADDRESS DETAILS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                    const SizedBox(height: 15),
                    const Text('Street Address *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '123 Main Street'), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 15),
                    const Text('Apartment, Suite, Unit, Building (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'Apt 4B'), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('City *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'San Diego'), style: TextStyle(fontSize: 14))),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('ZIP / Postal Code *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '92101'), style: TextStyle(fontSize: 14))),
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),
                    const Text('State / Region *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'California (CA)', suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey), suffixIconConstraints: BoxConstraints(minWidth: 20)), style: TextStyle(fontSize: 14))),
                    
                    const SizedBox(height: 25),
                    const Text('Address Label Tag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildLabelPill(0, 'Home', Icons.home_outlined),
                          const SizedBox(width: 10),
                          _buildLabelPill(1, 'Office / Work', Icons.business_center_outlined),
                          const SizedBox(width: 10),
                          _buildLabelPill(2, 'Parents / Fam', Icons.apartment_outlined),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Delivery Instructions / Courier Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('Optional', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: const TextField(maxLines: 3, decoration: InputDecoration(border: InputBorder.none, hintText: 'Ring doorbell twice upon arrival'), style: TextStyle(fontSize: 14)),
                    ),

                    const SizedBox(height: 25),

                    // Settings Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.verified_user_outlined, color: Color(0xFF0F8A9E), size: 20),
                              SizedBox(width: 8),
                              Text('DELIVERY & ADDRESS SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Set as Default Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(width: 8),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('Use as primary destination for fast 1-click checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Switch(value: isDefault, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => isDefault = val)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Divider(height: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Eco-friendly minimal packaging', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(width: 6),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.eco, color: Colors.green, size: 10), SizedBox(width: 2), Text('Eco', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))])),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text('100% biodegradable corrugated box & paper tape', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                                  ],
                                ),
                              ),
                              Switch(value: isEco, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => isEco = val)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('UPDATE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 6),
                              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified_user, color: Colors.greenAccent, size: 14),
                      const SizedBox(width: 6),
                      Text('100% Guaranteed On-Time Safe Delivery & Encrypted', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLabelPill(int index, String title, IconData icon) {
    bool isSel = selectedLabel == index;
    return GestureDetector(
      onTap: () => setState(() => selectedLabel = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSel ? const Color(0xFF00BCD4) : Colors.white,
          border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSel ? Colors.white : Colors.grey.shade600, size: 16),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Selected Payment Method: 0=Visa, 1=Mastercard, 2=ApplePay, 3=PayPal, 4=COD
  int selectedMethod = 0; 
  bool rememberCheckout = true;

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
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        const Text('Select Payment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text('ORDER #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Color(0xFF00BCD4), size: 16),
                        SizedBox(width: 4),
                        Text('Add', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Checkout Total Banner
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF00BCD4), size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Checkout Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('2 items including shipping', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                          const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // SAVED CARDS Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SAVED CARDS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                        Text('2 on file', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildActiveVisaCard(),
                    const SizedBox(height: 12),
                    _buildInactiveCard(1, 'Mastercard ending in 8831', 'Expires 11/26 â€¢ Credit Card', Icons.circle, Colors.orange, 'Set Default'),
                    const SizedBox(height: 15),
                    
                    // Add New Card Button
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewCardScreen())),
                      child: Container(
                        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100, width: 2, style: BorderStyle.solid)), 
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Color(0xFF0F8A9E), size: 18),
                            SizedBox(width: 8),
                            Text('Add New Credit or Debit Card', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),

                    // EXPRESS & DIGITAL WALLETS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('EXPRESS & DIGITAL WALLETS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                        Row(
                          children: [
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                            const SizedBox(width: 4),
                            const Text('Instant', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 11)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildExpressOption(2, 'Apple Pay', '1-Touch Instant Checkout Enabled', Icons.apple, Colors.black, 'Ready', Colors.green, const ApplePayScreen()),
                    const SizedBox(height: 12),
                    _buildExpressOption(3, 'PayPal', 'cesc.fabregas@clubmail.com', Icons.paypal, Colors.blue.shade50, 'Connected', const Color(0xFF00BCD4), const PayPalScreen()),
                    const SizedBox(height: 25),

                    // OTHER METHODS
                    Text('OTHER METHODS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                    const SizedBox(height: 15),
                    _buildExpressOption(4, 'Cash on Delivery', 'Pay upon package arrival', Icons.local_mall_outlined, Colors.orange.shade50, 'Verified Area', Colors.orange, const CODScreen()),
                    
                    const SizedBox(height: 25),
                    
                    // Remember Toggle
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Remember for faster checkout', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                const SizedBox(height: 4),
                                Text('Use Visa 4242 as default on future purchases', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                              ],
                            ),
                          ),
                          Switch(value: rememberCheckout, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => rememberCheckout = val)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.verified_user_outlined, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Use Selected Method', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('\$40.50', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline, color: Colors.blueGrey, size: 12),
                      const SizedBox(width: 6),
                      Text('256-bit Bank-grade Encryption & PCI-DSS Compliant', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildActiveVisaCard() {
    bool isSel = selectedMethod == 0;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1),
          boxShadow: isSel ? [BoxShadow(color: Colors.cyan.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))] : [],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),
                  child: const Text('VISA', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 14, fontStyle: FontStyle.italic)),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Visa ending in 4242', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Row(
                            children: [
                              Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('DEFAULT', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 9, fontWeight: FontWeight.bold))),
                              const SizedBox(width: 5),
                              const Icon(Icons.more_vert, color: Colors.grey, size: 16),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text('Expires 08/27 â€¢ Debit Card', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                      const SizedBox(height: 4),
                      Text('Cesc Fabregas', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  ),
                )
              ],
            ),
            if (isSel) ...[
              const SizedBox(height: 20),
              Divider(height: 1, color: Colors.grey.shade200),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.lock_outline, color: Color(0xFF0F8A9E), size: 16),
                      SizedBox(width: 8),
                      Text('Confirm Security Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                    ],
                  ),
                  Row(
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('â€¢â€¢â€¢', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                      const SizedBox(width: 10),
                      const Text('Verified', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  )
                ],
              )
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInactiveCard(int index, String title, String sub, IconData icon, Color iconColor, String rightPill) {
    bool isSel = selectedMethod == index;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade100)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 12, height: 12, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                  Transform.translate(offset: const Offset(-4, 0), child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.amber.withOpacity(0.8), shape: BoxShape.circle))),
                ],
              ) 
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: Text(rightPill, style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }

  Widget _buildExpressOption(int index, String title, String sub, IconData icon, Color iconBg, String badgeTxt, Color badgeColor, Widget targetScreen) {
    bool isSel = selectedMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMethod = index);
        Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen));
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),
        child: Row(
          children: [
            Icon(isSel ? Icons.check_circle : Icons.circle_outlined, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: icon == Icons.paypal 
                  ? const Text('PP', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))
                  : Icon(icon, color: iconBg == Colors.black ? Colors.white : Colors.orange, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(width: 8),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: badgeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Row(children: [if(badgeTxt == 'Ready') const Icon(Icons.circle, color: Colors.green, size: 6), if(badgeTxt == 'Ready') const SizedBox(width: 4), Text(badgeTxt, style: TextStyle(color: badgeColor, fontSize: 9, fontWeight: FontWeight.bold))])),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
          ],
        ),
      ),
    );
  }
}
class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});
  @override State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}
class _AddNewCardScreenState extends State<AddNewCardScreen> {
  bool isSameAddress = true;
  bool saveCard = true;
  bool setAsDefault = true;

  @override Widget build(BuildContext context) {
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
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  ),
                  Column(
                    children: [
                      const Text('Add New Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('CREDIT OR DEBIT CARD', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.security, color: Color(0xFF0F8A9E), size: 18)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Scan Card Banner
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.camera_alt, color: Colors.white, size: 20)),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Scan Your Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(height: 2),
                                Text('Auto-fill card details instantly', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
                              ],
                            ),
                          ),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)), child: const Text('Scan Now', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Credit Card UI
                    Container(
                      height: 200, width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(colors: [Color(0xFF0A4F5C), Color(0xFF00BCD4)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        boxShadow: [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 10))],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(width: 40, height: 30, decoration: BoxDecoration(color: Colors.amber.shade200, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.sim_card, size: 20, color: Colors.black54)),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.wifi, color: Colors.white70, size: 24),
                                ],
                              ),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(6)), child: const Text('VISA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('CARD NUMBER', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                              const SizedBox(height: 4),
                              const Text('4242   â€¢â€¢â€¢â€¢   â€¢â€¢â€¢â€¢   8821', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CARD HOLDER', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  const SizedBox(height: 4),
                                  const Text('CESC FABREGAS', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('EXPIRES', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  const SizedBox(height: 4),
                                  const Text('08/28', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Form fields
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Cardholder Name *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                            child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', prefixIcon: Icon(Icons.person_outline, size: 20, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 15),
                          const Text('Card Number *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                            child: TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '4242 8821 9012 3456', prefixIcon: const Icon(Icons.credit_card, size: 20, color: Colors.grey), prefixIconConstraints: const BoxConstraints(minWidth: 30), suffixIcon: Padding(padding: const EdgeInsets.only(top:12, bottom:12), child: Container(padding: const EdgeInsets.symmetric(horizontal: 8), decoration: const BoxDecoration(color: Color(0xFFE0F7FA), borderRadius: BorderRadius.all(Radius.circular(6))), child: const Text('VISA', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 10, height: 1.5))))), style: const TextStyle(fontSize: 14)),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Expiry Date *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                                      child: const TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '08 / 28', prefixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: TextStyle(fontSize: 14)),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('CVV / CVC *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                        Row(children: [const Icon(Icons.help_outline, size: 12, color: Color(0xFF0F8A9E)), const SizedBox(width: 2), const Text('3 digits', style: TextStyle(fontSize: 10, color: Color(0xFF0F8A9E)))])
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                                      child: const TextField(obscureText: true, decoration: InputDecoration(border: InputBorder.none, hintText: 'â€¢â€¢â€¢', prefixIcon: Icon(Icons.lock_outline, size: 18, color: Colors.grey), prefixIconConstraints: BoxConstraints(minWidth: 30)), style: TextStyle(fontSize: 14, letterSpacing: 2)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => setState(() => isSameAddress = !isSameAddress),
                                child: Container(
                                  width: 18, height: 18, margin: const EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(color: isSameAddress ? const Color(0xFF0F8A9E) : Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: isSameAddress ? const Color(0xFF0F8A9E) : Colors.grey.shade300)),
                                  child: isSameAddress ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12, height: 1.4),
                                    children: const [
                                      TextSpan(text: 'Billing address is the same as delivery address: '),
                                      TextSpan(text: '123 Main Street, Apt 4B, San Diego', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                                    ]
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Toggles
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Save card for future checkouts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text('Encrypted tokenization via PCI-DSS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              ),
                              Switch(value: saveCard, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => saveCard = val)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Divider(height: 1, color: Colors.grey.shade100),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Set as default payment card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  const SizedBox(height: 4),
                                  Text('Use for 1-click order authorizations', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              ),
                              Switch(value: setAsDefault, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => setAsDefault = val)),
                            ],
                          ),
                        ],
                      )
                    ),
                    const SizedBox(height: 25),
                    Center(child: Text('Accepted Networks:  VISA  MC  AMEX', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Bottom Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text('Save & Use Card', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Row(
                            children: [
                              Text('\$40.50', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('256-bit Bank-grade Encryption â€¢ PCI-DSS Compliant', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }
}

class ApplePayScreen extends StatelessWidget {
  const ApplePayScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  ),
                  Column(
                    children: [
                      const Text('Apple Pay Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('FAST 1-TOUCH AUTHORIZATION', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  const Text('Cancel', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    // Order Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CURRENT ORDER', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)),
                                  const SizedBox(height: 4),
                                  const Text('#ORD-9302', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 16)),
                                ],
                              ),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.cyan.shade100)), child: const Text('2 Items', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 12))),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Denim Jacket + Basic T-Shirt', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13)), const Text('\$35.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 10),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Standard Shipping & Taxes', style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13)), const Text('\$5.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))]),
                          const SizedBox(height: 20),
                          Divider(height: 1, color: Colors.grey.shade200),
                          const SizedBox(height: 20),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Total Due', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Apple Pay Sheet UI Mimic
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(color: const Color(0xFF131A26), borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20, offset: const Offset(0, 10))]),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white24)), child: const Icon(Icons.apple, color: Colors.white, size: 24)),
                                  const SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('PAYMENT GATEWAY', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Text('Apple Pay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                          const SizedBox(width: 6),
                                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('Authorization', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),
                                  const SizedBox(height: 4),
                                  const Text('\$40.50', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Divider(height: 1, color: Colors.white.withOpacity(0.1)),
                          const SizedBox(height: 25),
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white.withOpacity(0.1))),
                            child: Row(
                              children: [
                                Container(width: 45, height: 30, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.credit_card, size: 20)),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Apple Card', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                                      const SizedBox(height: 2),
                                      Text('Mastercard â€¢â€¢â€¢â€¢ 9924', style: TextStyle(color: Colors.blueGrey.shade200, fontSize: 12)),
                                    ],
                                  ),
                                ),
                                const Text('Change', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 13)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          _buildAppleDetailRow('SHIPPING', 'Cesc Fabregas\n123 Main Street, San Diego, CA 92101'),
                          const SizedBox(height: 15),
                          _buildAppleDetailRow('DELIVERY', 'Standard (2-3 Business Days)', badge: 'FREE'),
                          const SizedBox(height: 15),
                          _buildAppleDetailRow('CONTACT', 'cesc.fabregas@clubmail.com'),
                          const SizedBox(height: 35),
                          Container(padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: const Color(0xFF00BCD4).withOpacity(0.2), shape: BoxShape.circle), child: const Icon(Icons.face_retouching_natural, color: Color(0xFF00BCD4), size: 30)),
                          const SizedBox(height: 15),
                          const Text('Double-Click Side Button to Pay', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          const SizedBox(height: 4),
                          Text('or verify with Face ID / Passcode', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('â† Choose a different payment method', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 13)),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Bottom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 60,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Authorize', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Icon(Icons.apple, color: Colors.white, size: 20),
                          Text('Pay', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(width: 15),
                          Text('â€¢', style: TextStyle(color: Colors.blueGrey)),
                          SizedBox(width: 15),
                          Text('\$40.50', style: TextStyle(color: Color(0xFF00BCD4), fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock, color: Colors.blueGrey, size: 12),
                      const SizedBox(width: 6),
                      Text('Protected by Apple Pay Secure Enclave', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),
                    ],
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }
  
  Widget _buildAppleDetailRow(String title, String val, {String? badge}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 90, child: Text(title, style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11, letterSpacing: 0.5))),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(val, textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
              if(badge != null) ...[const SizedBox(height: 4), Text(badge, style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 12))]
            ],
          ),
        )
      ],
    );
  }
}

class PayPalScreen extends StatelessWidget {
  const PayPalScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('PayPal Checkout', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.shield, color: Colors.blue, size: 16),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text('CONNECTED ACCOUNT â€¢ #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.lock, color: Color(0xFF0F8A9E), size: 18)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PayPal Banner
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: const Color(0xFF003087), borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFF003087), Color(0xFF0079C1)])),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text('PP', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                  const SizedBox(width: 10),
                                  const Text('PayPal', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
                                ],
                              ),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.5))), child: const Row(children: [Icon(Icons.check, color: Colors.white, size: 14), SizedBox(width: 4), Text('Verified', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))])),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Divider(color: Colors.white.withOpacity(0.2), height: 1),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CONNECTED ACCOUNT', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  const SizedBox(height: 4),
                                  const Text('cesc.fabregas@clubmail.com', style: TextStyle(color: Colors.white, fontSize: 13)),
                                ],
                              ),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: const Text('Switch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Row(
                        children: [
                          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.shopping_bag, color: Color(0xFF00BCD4))),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: const [Text('E-Commerce Store', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), SizedBox(width: 6), Icon(Icons.verified, color: Colors.blue, size: 14)]),
                                const SizedBox(height: 4),
                                Text('Order #ORD-9302 â€¢ 2 items', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Total', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                              const Text('\$40.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PAY WITH', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
                        const Text('3 sources linked', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildPPOption(true, 'PayPal Balance', '\$142.80 available', Icons.account_balance_wallet, Colors.blue, 'Preferred', Colors.blue.shade50, Colors.blue),
                    const SizedBox(height: 12),
                    _buildPPOption(false, 'Chase Checking', 'Primary Bank Account', Icons.account_balance, Colors.grey.shade700, 'â€¢â€¢â€¢â€¢ 5120', Colors.transparent, Colors.grey),
                    const SizedBox(height: 12),
                    _buildPPOption(false, 'Pay in 4 Interest-Free', '4 payments of \$10.12 every 2 weeks', Icons.money, Colors.orange, '0% APR', Colors.green.shade50, Colors.green),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.security, color: Color(0xFF0F8A9E), size: 18),
                          const SizedBox(width: 10),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4),
                                children: [
                                  TextSpan(text: 'PayPal Purchase Protection: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: 'Eligible purchases are covered if items don\'t arrive or match description.'),
                                ]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Billing Currency', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                        const Text('ðŸŒ USD (\$40.50) â€¢ No conversion fee', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Bottom
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Text('Agree & Pay \$40.50 with PayPal  â†’', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Cancel and return to checkout', style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock, color: Colors.grey, size: 12),
                      const SizedBox(width: 6),
                      Text('Protected by PayPal 256-bit encryption & PCI-DSS standards', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                    ],
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }

  Widget _buildPPOption(bool isSel, String title, String sub, IconData icon, Color iconColor, String badgeTxt, Color badgeBg, Color badgeColor) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSel ? 2 : 1)),
      child: Row(
        children: [
          Icon(isSel ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),
          const SizedBox(width: 15),
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: iconColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: iconColor, size: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(sub, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
          ),
          if(badgeTxt.isNotEmpty)
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(8)), child: Text(badgeTxt, style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

class CODScreen extends StatelessWidget {
  const CODScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: const Icon(Icons.arrow_back_ios_new, size: 18)),
                  ),
                  Column(
                    children: [
                      const Text('Cash on Delivery', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('ORDER CONFIRMATION #ORD-9302', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.cyan.shade100)), child: const Text('COD Mode', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 11, fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Delivery Dest
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.location_on, color: Color(0xFF00BCD4), size: 16)),
                                  const SizedBox(width: 10),
                                  Text('DELIVERY\nDESTINATION', style: TextStyle(color: Colors.blueGrey.shade300, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 0.5)),
                                ],
                              ),
                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.green.shade100)), child: Row(children: const [Icon(Icons.circle, color: Colors.green, size: 8), SizedBox(width: 4), Text('COD Available in Your Area', style: TextStyle(color: Colors.green, fontSize: 10))])),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text('Cesc Fabregas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text('Home', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 12))]),
                          const SizedBox(height: 8),
                          const Text('123 Main Street, Apt 4B, San Diego, CA 92101', style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4)),
                          const SizedBox(height: 12),
                          Row(children: [const Icon(Icons.phone_outlined, size: 14, color: Colors.grey), const SizedBox(width: 6), Text('(858) 555-0192', style: TextStyle(color: Colors.grey.shade600, fontSize: 13))]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Breakdown
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PAYMENT BREAKDOWN', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                          const SizedBox(height: 15),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Subtotal', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const Text('\$35.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Standard Shipping', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const Text('\$5.50', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
                          const SizedBox(height: 12),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Row(children: [Text('COD Handling Fee', style: TextStyle(color: Colors.blueGrey.shade700, fontSize: 14)), const SizedBox(width: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('WAIVED', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)))]), const Text('\$0.00 (Free)', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14))]),
                          const SizedBox(height: 15),
                          Divider(color: Colors.grey.shade200, height: 1), // Actually dashed in mockup, but solid is fine
                          const SizedBox(height: 15),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Total to Pay at Door', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 4), Text('Inclusive of all local taxes', style: TextStyle(color: Colors.grey.shade400, fontSize: 11))]), const Text('\$40.50', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 24))]),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Notice
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.amber.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.info, color: Colors.brown, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('COURIER NOTICE', style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                                    const SizedBox(height: 4),
                                    RichText(text: const TextSpan(style: TextStyle(color: Colors.brown, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Please prepare exact change of '), TextSpan(text: '\$40.50', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)), TextSpan(text: ' when the courier arrives to expedite handover.')])),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 15),
                          Divider(color: Colors.amber.shade200, height: 1),
                          const SizedBox(height: 15),
                          Row(children: [const Icon(Icons.sms_outlined, color: Colors.brown, size: 14), const SizedBox(width: 6), Text('Courier will call or send SMS prior to delivery.', style: TextStyle(color: Colors.brown.shade800, fontSize: 11))])
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Buyer Protection
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('COD BUYER PROTECTION', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.check, color: Color(0xFF00BCD4), size: 14)),
                              const SizedBox(width: 10),
                              Expanded(child: RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Unboxing check allowed ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'before cash payment handover.')])))
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(padding: const EdgeInsets.all(2), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.check, color: Color(0xFF00BCD4), size: 14)),
                              const SizedBox(width: 10),
                              Expanded(child: RichText(text: const TextSpan(style: TextStyle(color: Colors.black87, fontSize: 12, height: 1.4), children: [TextSpan(text: 'Instant digital receipt & invoice ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'sent via SMS and email immediately upon collection.')])))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            // Bottom Action
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity, height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                      child: const Text('Confirm Order via COD â€¢ \$40.50  â†’', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.verified, color: Colors.green, size: 14),
                      const SizedBox(width: 6),
                      Text('Safe, contactless or cash handover guarantee', style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 11)),
                    ],
                  )
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
class OrderSuccessScreen extends StatelessWidget { const OrderSuccessScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(30.0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: const EdgeInsets.all(30), decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.check_circle, size: 80, color: Theme.of(context).primaryColor)), const SizedBox(height: 30), const Text('Yay! Order Placed', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Text('Your order has been placed successfully\nand will be processed soon.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 16)), const SizedBox(height: 50), SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TrackingScreen())), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 16)))), const SizedBox(height: 15), TextButton(onPressed: () => Navigator.pop(context), child: Text('Back to Home', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16)))])))); } }
class TrackingScreen extends StatelessWidget { const TrackingScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Track Order', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.local_shipping, size: 100, color: Theme.of(context).primaryColor), const SizedBox(height: 30), const Text('Your order is on the way!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 20), ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor), child: const Text('Done', style: TextStyle(color: Colors.white)))]))); } }
class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedChipIndex = 0;

  final categories = ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hats', 'Socks', 'Watches', 'Bags']; 
  final itemsCount = [148, 92, 85, 64, 110, 42, 38, 57, 73];
  final icons = [
    'assets/images/categories/tshirt.png',
    'assets/images/categories/shirt.png',
    'assets/images/categories/pants.png',
    'assets/images/categories/jacket.png',
    'assets/images/categories/shoe.png',
    'assets/images/categories/hat.png',
    'assets/images/categories/socks.png',
    'assets/images/categories/watch.png',
    'assets/images/categories/bag.png',
  ]; 

  final chips = ['All (12)', 'Apparel', 'Footwear', 'Accessories'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Light greyish background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    Column(
                      children: [
                        const Text('Choose a Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Explore 12 vibrant styles', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.notifications_none, size: 20),
                    ),
                  ],
                ),
              ),

              // 2. Search & Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55, padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                        child: Row(children: [Icon(Icons.search, color: Colors.grey.shade400), const SizedBox(width: 10), Text('Search categories, items...', style: TextStyle(color: Colors.grey.shade400, fontSize: 13))]),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 55, width: 55,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),
                      child: const Icon(Icons.tune, color: Colors.white),
                    )
                  ],
                ),
              ),

              // 3. Chips
              const SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chips.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedChipIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedChipIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300),
                        ),
                        child: Text(chips[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),

              // 4. Main Collections Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('MAIN COLLECTIONS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    Text('Select Multi', style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // 5. Grid of Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 25, childAspectRatio: 0.72
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedCategoryIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() => _selectedCategoryIndex = index);
                        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: categories[index])));
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.cyan.shade50 : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.white, width: isSelected ? 1.5 : 0),
                              boxShadow: [if (!isSelected) BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(flex: 2),
                                // We use the existing circular icons as requested
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(icons[index], width: 45, height: 45, fit: BoxFit.cover),
                                ),
                                const Spacer(flex: 2),
                                Text(categories[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                const SizedBox(height: 4),
                                Text('${itemsCount[index]} items', style: TextStyle(fontSize: 10, color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade500)),
                                const Spacer(),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: -10, left: 0, right: 0,
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
                                  child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryProductsScreen extends StatelessWidget { final String categoryName; const CategoryProductsScreen({super.key, required this.categoryName}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text(categoryName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: GridView.builder(padding: const EdgeInsets.all(20), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58), itemCount: 6, itemBuilder: (context, index) { return ProductCard(title: '$categoryName Item ${index + 1}', subtitle: 'Best Quality', price: '\$${(index+1)*12}.00', imageUrl: 'https://picsum.photos/seed/${index + 300}/300/400', rating: '4.${index%9}', reviews: '${index*12+5}', isFav: index%2==0); })); } }
class SearchScreen extends StatelessWidget { const SearchScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black), title: Container(height: 40, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: const TextField(autofocus: true, decoration: InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search, color: Colors.grey), border: InputBorder.none)))), body: Padding(padding: const EdgeInsets.all(20.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 15), ListTile(leading: const Icon(Icons.history), title: const Text('T-Shirt Mens'), trailing: const Icon(Icons.close, size: 16), onTap: (){})]))); } }
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _selectedChipIndex = 0;
  final chips = ['All (4)', 'Apparel (2)', 'Outerwear (1)', 'Pants (1)'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    Column(
                      children: [
                        const Text('Favorites', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('4 saved items', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.more_horiz, size: 20),
                    ),
                  ],
                ),
              ),

              // 2. Chips
              const SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chips.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedChipIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedChipIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(chips[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                      ),
                    );
                  },
                ),
              ),
              
              // 3. Sub-header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        const Text('All items in stock', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Move All to Cart', style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        Icon(Icons.arrow_forward_ios, size: 12, color: Theme.of(context).primaryColor),
                      ],
                    )
                  ],
                ),
              ),

              // 4. Grid View
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                  crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58,
                  children: [
                    ProductCard(title: 'Basic Eco-Cotton T-Shirt', subtitle: '100% Organic Cotton', price: '\$15.00', oldPrice: '\$22.00', imageUrl: 'https://picsum.photos/seed/101/300/400', rating: '4.8', reviews: '124', tag1: '-30%', tag2: 'Eco', isFav: true),
                    ProductCard(title: 'Denim Classic Jacket', subtitle: 'Cotton 100% Rigid', price: '\$30.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/102/300/400', rating: '4.9', reviews: '89', tag1: 'Bestseller', tag2: '', isFav: true),
                    ProductCard(title: 'Cargo Utility Pants', subtitle: 'Relaxed Fit Canvas', price: '\$28.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/103/300/400', rating: '4.7', reviews: '52', tag1: 'Popular', tag2: '', isFav: true),
                    ProductCard(title: 'Botanical Casual Shirt', subtitle: 'Lightweight Breathable', price: '\$18.00', oldPrice: '', imageUrl: 'https://picsum.photos/seed/104/300/400', rating: '4.6', reviews: '38', tag1: 'New', tag2: '', isFav: true),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    const Text('Account & Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.more_horiz, size: 20),
                    ),
                  ],
                ),
              ),

              // 2. Profile Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Theme.of(context).primaryColor, const Color(0xFF137A8C)], 
                    begin: Alignment.topLeft, end: Alignment.bottomRight
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                              child: const CircleAvatar(radius: 35, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
                            ),
                            Positioned(
                              right: 0, bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: Icon(Icons.camera_alt, color: Theme.of(context).primaryColor, size: 14)
                              )
                            )
                          ]
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('Cesc Fabregas', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.verified, color: Colors.orange, size: 16),
                                ]
                              ),
                              const SizedBox(height: 4),
                              const Text('cesc.fabregas@clubmail.com', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white54)),
                                child: const Text('GOLD VIP MEMBER', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
                              )
                            ]
                          )
                        )
                      ]
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white.withOpacity(0.2), height: 1),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(child: Column(children: [const Text('14', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text('Orders', style: TextStyle(color: Colors.white70, fontSize: 12))])),
                        Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2)),
                        Expanded(child: Column(children: [const Text('4', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text('Wishlist', style: TextStyle(color: Colors.white70, fontSize: 12))])),
                        Container(height: 30, width: 1, color: Colors.white.withOpacity(0.2)),
                        Expanded(child: Column(children: [const Text('6', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Text('Vouchers', style: TextStyle(color: Colors.white70, fontSize: 12))])),
                      ]
                    )
                  ]
                )
              ),

              // 3. Menu Group 1
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),
                child: Column(
                  children: [
                    _buildMenuTile(context, Icons.person_outline, 'Personal Info', 'Name, Email, Phone number', null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PersonalInfoScreen()))),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMenuTile(context, Icons.inventory_2_outlined, 'My Orders', 'Order history & tracking', _buildPill(context, '2 In Transit', isCyan: true), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MyOrdersScreen()))),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMenuTile(context, Icons.notifications_none, 'Notifications', 'Promos & status alerts', Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()))),
                  ]
                )
              ),

              // 4. Menu Group 2
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]),
                child: Column(
                  children: [
                    _buildMenuTile(context, Icons.settings_outlined, 'Settings', 'Language, currency, privacy', null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()))),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMenuTile(context, Icons.payment_outlined, 'Payment Methods', 'Visa ending in 4242', _buildPill(context, 'VISA', isCyan: false), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()))),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMenuTile(context, Icons.help_outline, 'Help & Support', 'FAQ & Customer Service', null, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpSupportScreen()))),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMenuTile(context, Icons.logout, 'Log Out', 'Sign out of your account', null, isLogout: true, onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false)),
                  ]
                )
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, String subtitle, Widget? trailingExtra, {bool isLogout = false, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: isLogout ? Colors.red.shade50 : Colors.cyan.shade50, shape: BoxShape.circle),
          child: Icon(icon, color: isLogout ? Colors.red : const Color(0xFF0F8A9E)),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isLogout ? Colors.red : Colors.black87)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey.shade400)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailingExtra != null) ...[trailingExtra, const SizedBox(width: 10)],
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300),
          ],
        ),
        onTap: onTap ?? () {},
      ),
    );
  }

  Widget _buildPill(BuildContext context, String text, {required bool isCyan}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isCyan ? Colors.cyan.shade50 : Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: TextStyle(color: isCyan ? const Color(0xFF0F8A9E) : Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN NOTIFICATIONS
// ----------------------------------------------------------------------
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Row(
                      children: [
                        const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(12)),
                          child: const Text('3 New', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.check, size: 20),
                    ),
                  ],
                ),
              ),

              // 2. Chips
              SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 20), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))]), child: const Text('All (8)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Text('Orders', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12))),
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Text('Promos & Deals', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12))),
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Text('Account', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12))),
                  ]
                )
              ),
              const SizedBox(height: 25),

              // 3. TODAY Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TODAY', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    Text('Mark group read', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Notif 1
                    _buildNotifCard(
                      context: context,
                      iconBox: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.local_shipping_outlined, color: Color(0xFF00BCD4), size: 24)),
                      title: 'Order Dispatched! ðŸšš',
                      body: Text('Your package with Basic Eco-Cotton T-Shirt has been shipped via Express Courier.', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                      actionButton: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(20)), child: const Row(children: [Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)), SizedBox(width: 4), Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10)])),
                      time: '10m ago',
                      isUnread: true
                    ),
                    
                    // Notif 2
                    _buildNotifCard(
                      context: context,
                      iconBox: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.local_fire_department_outlined, color: Colors.orange, size: 24)),
                      title: 'Flash Sale Alert: Up to 40% OFF ðŸ”¥',
                      body: Text('Mountain Series Summer 2024 collection is now on limited-time discount. Don\'t miss out!', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                      actionButton: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF0B1221), borderRadius: BorderRadius.circular(20)), child: const Text('Shop Deals', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),
                      time: '1h ago',
                      isUnread: true
                    ),

                    // Notif 3
                    _buildNotifCard(
                      context: context,
                      iconBox: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.favorite, color: Color(0xFFF75555), size: 24)),
                      title: 'Price Drop on Denim Classic Jacket',
                      body: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4),
                          children: [
                            const TextSpan(text: 'An item in your wishlist dropped from '),
                            TextSpan(text: '\$38.00', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey.shade400)),
                            const TextSpan(text: ' to '),
                            const TextSpan(text: '\$30.00', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF00BCD4))),
                            const TextSpan(text: '.'),
                          ]
                        )
                      ),
                      actionButton: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.pink.shade50, borderRadius: BorderRadius.circular(8)), child: const Text('Save \$8.00', style: TextStyle(color: Color(0xFFF75555), fontSize: 11, fontWeight: FontWeight.bold))),
                      time: '3h ago',
                      isUnread: true
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // 4. EARLIER THIS WEEK Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text('EARLIER THIS WEEK', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildNotifCard(
                  context: context,
                  iconBox: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.check_circle_outline, color: Colors.green, size: 24)),
                  title: 'Payment Confirmed (\$30.00)',
                  body: Text('Payment for order #ORD-9284 via Visa ending in 4242 was processed successfully.', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, height: 1.4)),
                  actionButton: null,
                  time: 'Tue, 14:30',
                  isUnread: false
                ),
              ),

              const SizedBox(height: 60),
            ]
          )
        )
      )
    );
  }

  Widget _buildNotifCard({
    required BuildContext context,
    required Widget iconBox,
    required String title,
    required Widget body,
    required Widget? actionButton,
    required String time,
    required bool isUnread
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isUnread ? const Color(0xFF00BCD4).withOpacity(0.3) : Colors.grey.shade100, width: isUnread ? 1.5 : 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           iconBox,
           const SizedBox(width: 15),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                       if (isUnread) Container(margin: const EdgeInsets.only(top: 4, left: 10), width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFFF75555), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)]))
                    ]
                  ),
                  const SizedBox(height: 6),
                  body,
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                       actionButton ?? const SizedBox(),
                       Text(time, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ]
                  )
               ]
             )
           )
        ]
      )
    );
  }
}

// ----------------------------------------------------------------------
// FILTER BOTTOM SHEET
// ----------------------------------------------------------------------
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(15, 85);
  
  List<String> selectedCategories = ['T-Shirts', 'Pants'];
  String selectedSort = 'Popular Deals';
  String selectedRating = '4.5 & up';
  List<String> selectedEco = ['Eco-Friendly', 'Organic Cotton'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              width: 40, height: 5,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))
            )
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                   children: [
                     const Text('Filter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                     const SizedBox(width: 12),
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                       decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.cyan.shade100)),
                       child: Text('3 Active', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 11, fontWeight: FontWeight.bold))
                     )
                   ]
                 ),
                 Row(
                   children: [
                     Text('Reset', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.bold)),
                     const SizedBox(width: 15),
                     GestureDetector(
                       onTap: () => Navigator.pop(context),
                       child: Container(
                         padding: const EdgeInsets.all(6),
                         decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                         child: Icon(Icons.close, color: Colors.grey.shade600, size: 18)
                       )
                     )
                   ]
                 )
              ]
            )
          ),
          const SizedBox(height: 15),
          Divider(height: 1, color: Colors.grey.shade100),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Price Range
                  _buildSectionTitle('Price Range', Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Text('\$${_priceRange.start.toInt()} â€” \$${_priceRange.end.toInt()}', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))
                  )),
                  const SizedBox(height: 20),
                  SliderTheme(
                    data: SliderThemeData(
                      activeTrackColor: const Color(0xFF00BCD4),
                      inactiveTrackColor: Colors.grey.shade200,
                      trackHeight: 6,
                      thumbColor: Colors.white,
                      overlayColor: const Color(0xFF00BCD4).withOpacity(0.2),
                      rangeThumbShape: const RoundRangeSliderThumbShape(enabledThumbRadius: 10, elevation: 4),
                    ),
                    child: RangeSlider(
                      values: _priceRange,
                      min: 10, max: 150,
                      onChanged: (values) => setState(() => _priceRange = values),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['\$10', '\$50', '\$100', '\$150+'].map((l) => Text(l, style: TextStyle(color: Colors.grey.shade400, fontSize: 11, fontWeight: FontWeight.bold))).toList(),
                    ),
                  ),
                  const SizedBox(height: 35),

                  // 2. Categories
                  _buildSectionTitle('Categories', Text('Clear', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hoodies'].map((cat) {
                      bool isSelected = selectedCategories.contains(cat);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                             if (isSelected) selectedCategories.remove(cat);
                             else selectedCategories.add(cat);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF00BCD4) : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200),
                            boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : []
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (cat == 'T-Shirts' && isSelected) ...[
                                const Icon(Icons.checkroom, color: Colors.white, size: 14),
                                const SizedBox(width: 4)
                              ],
                              Text(cat, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12))
                            ]
                          )
                        )
                      );
                    }).toList()
                  ),
                  const SizedBox(height: 35),

                  // 3. Sort By
                  _buildSectionTitle('Sort By', null),
                  const SizedBox(height: 15),
                  GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 3.5,
                    crossAxisSpacing: 12, mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: ['Popular Deals', 'Newest', 'Price: Low to High', 'Price: High to Low'].map((sort) {
                      bool isSelected = selectedSort == sort;
                      return GestureDetector(
                        onTap: () => setState(() => selectedSort = sort),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSelected ? 1.5 : 1)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Expanded(child: Text(sort, style: TextStyle(color: isSelected ? const Color(0xFF0F8A9E) : Colors.black87, fontWeight: FontWeight.bold, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis)),
                               Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 18)
                            ]
                          )
                        )
                      );
                    }).toList()
                  ),
                  const SizedBox(height: 35),

                  // 4. Customer Rating
                  _buildSectionTitle('Customer Rating', null),
                  const SizedBox(height: 15),
                  Row(
                    children: ['4.5 & up', '4.0+', '3.5+'].map((rating) {
                      bool isSelected = selectedRating == rating;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => selectedRating = rating),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF00BCD4) : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200),
                              boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : []
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: isSelected ? Colors.amberAccent : Colors.amber, size: 14),
                                const SizedBox(width: 4),
                                Text(rating, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 11))
                              ]
                            )
                          )
                        )
                      );
                    }).toList()
                  ),
                  const SizedBox(height: 35),

                  // 5. Eco & Offers
                  Row(
                    children: [
                       const Text('Eco & Offers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                       const SizedBox(width: 10),
                       Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)), child: const Text('GREEN', style: TextStyle(color: Colors.green, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1)))
                    ]
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10, runSpacing: 10,
                    children: ['Eco-Friendly', 'Organic Cotton', 'On Discount (-20%)', 'In Stock Only'].map((offer) {
                      bool isSelected = selectedEco.contains(offer);
                      Color bgColor = Colors.white;
                      Color borderColor = Colors.grey.shade200;
                      Color textColor = Colors.grey.shade700;
                      IconData? icon;
                      
                      if (isSelected) {
                         if (offer == 'Eco-Friendly') {
                           bgColor = Colors.green.shade50; borderColor = Colors.green; textColor = Colors.green.shade700; icon = Icons.eco_outlined;
                         } else if (offer == 'Organic Cotton') {
                           bgColor = Colors.blue.shade50; borderColor = Colors.blue; textColor = Colors.blue.shade700;
                         } else {
                           bgColor = Colors.cyan.shade50; borderColor = Colors.cyan; textColor = Colors.cyan.shade700;
                         }
                      }
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                             if (isSelected) selectedEco.remove(offer);
                             else selectedEco.add(offer);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (icon != null && isSelected) ...[Icon(icon, color: textColor, size: 14), const SizedBox(width: 4)],
                              Text(offer, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 11)),
                              if (isSelected) ...[const SizedBox(width: 6), Container(width: 6, height: 6, decoration: BoxDecoration(color: textColor, shape: BoxShape.circle))]
                            ]
                          )
                        )
                      );
                    }).toList()
                  ),
                  const SizedBox(height: 40),
                ],
              )
            )
          ),
          
          // 6. Action Bar
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]
            ),
            child: Row(
              children: [
                 Expanded(
                   flex: 1,
                   child: GestureDetector(
                     onTap: () => setState(() { selectedCategories.clear(); selectedSort = ''; selectedRating = ''; selectedEco.clear(); }),
                     child: Container(
                       height: 50, alignment: Alignment.center,
                       decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
                       child: const Text('Clear', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                     ),
                   )
                 ),
                 const SizedBox(width: 15),
                 Expanded(
                   flex: 2,
                   child: GestureDetector(
                     onTap: () => Navigator.pop(context),
                     child: Container(
                       height: 50,
                       decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(16)),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                            const Text('Apply Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(width: 8),
                            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)), child: const Text('24', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))
                         ]
                       )
                     ),
                   )
                 )
              ]
            )
          )
        ],
      )
    );
  }

  Widget _buildSectionTitle(String title, Widget? rightWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        if (rightWidget != null) rightWidget,
      ]
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN HELP & SUPPORT
// ----------------------------------------------------------------------
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text('Help & Support', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen())),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.chat_outlined, size: 20, color: Color(0xFF0F8A9E)),
                            Positioned(
                              right: -2, top: -2,
                              child: Container(width: 8, height: 8, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 1.5)))
                            )
                          ]
                        )
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search FAQ, topics, orders, refunds...',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                      suffixIcon: Icon(Icons.mic_none, color: Colors.grey.shade400, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Gradient Banner
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF26D0CE), Color(0xFF0072FF)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFF26D0CE).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                           child: Row(children: [Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)), const SizedBox(width: 6), const Text('24/7 Live Support', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))])
                         ),
                         const Text('Wait time: ~2m', style: TextStyle(color: Colors.white, fontSize: 12))
                      ]
                    ),
                    const SizedBox(height: 15),
                    const Text('How can we help you?', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Reach out directly or explore quick answers to\nresolve order and account questions.', style: TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         _buildContactOption(Icons.chat_bubble_outline, 'Live Chat', 'Online Now'),
                         _buildContactOption(Icons.phone_outlined, 'Call Center', 'Toll Free'),
                         _buildContactOption(Icons.mail_outline, 'Email', 'Response <4h'),
                      ]
                    )
                  ]
                )
              ),
              const SizedBox(height: 30),

              // 4. MY SUPPORT TICKET
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFF0F8A9E), shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Text('MY SUPPORT TICKET', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ],
                    ),
                    const Text('History', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('#TK-4821', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        const SizedBox(width: 8),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: const Text('In Progress', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold))),
                      ]
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(child: Text('Shipping delay query on #ORD-9284', style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500))),
                        Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)), child: Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade400))
                      ]
                    ),
                    const SizedBox(height: 12),
                    Text('Updated 2 hours ago â€¢ Assigned to Sarah M.', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                  ]
                )
              ),
              const SizedBox(height: 30),

              // 5. Explore FAQ
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     const Text('Explore FAQ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                     Text('Browse categories', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  ]
                )
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 20), alignment: Alignment.center, decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(20)), child: const Text('All', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Text('Orders & Shipping', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12))),
                     Container(margin: const EdgeInsets.only(right: 10), padding: const EdgeInsets.symmetric(horizontal: 16), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)), child: Text('Payments & Refunds', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: 12))),
                  ]
                )
              ),
              const SizedBox(height: 15),

              // FAQ Accordion Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.access_time, color: Color(0xFF0F8A9E), size: 16)),
                         const SizedBox(width: 15),
                         const Expanded(child: Text('How do I track my order in real-time?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.4))),
                         const SizedBox(width: 10),
                         const Icon(Icons.keyboard_arrow_up, color: Color(0xFF0F8A9E), size: 20)
                       ]
                     ),
                     const SizedBox(height: 15),
                     Padding(
                       padding: const EdgeInsets.only(left: 45),
                       child: RichText(
                         text: TextSpan(
                           style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.6),
                           children: const [
                              TextSpan(text: 'Navigate to '),
                              TextSpan(text: 'My Orders', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              TextSpan(text: ' > Select your active purchase > Tap '),
                              TextSpan(text: 'Track Shipment', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                              TextSpan(text: ' to see live carrier coordinates and estimated doorstep arrival.'),
                           ]
                         )
                       )
                     )
                  ]
                )
              ),
              const SizedBox(height: 60),
            ]
          )
        )
      )
    );
  }

  Widget _buildContactOption(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
             Container(padding: const EdgeInsets.all(8), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, color: const Color(0xFF0072FF), size: 18)),
             const SizedBox(height: 8),
             Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
             const SizedBox(height: 2),
             Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 9)),
          ]
        )
      )
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN PAYMENT METHODS
// ----------------------------------------------------------------------
class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text('Payment Methods', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.add, size: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // 2. DEFAULT PAYMENT Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('DEFAULT PAYMENT', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    Text('Manage', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // Gradient Card
              Container(
                height: 200,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF26D0CE), Color(0xFF0F8A9E)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFF26D0CE).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8))]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Row(
                           children: [
                             Container(
                               width: 42, height: 28,
                               decoration: BoxDecoration(
                                 color: Colors.amber.shade400,
                                 borderRadius: BorderRadius.circular(6),
                                 border: Border.all(color: Colors.amber.shade200),
                                 boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))]
                               )
                             ),
                             const SizedBox(width: 12),
                             const Icon(Icons.contactless_outlined, color: Colors.white70, size: 24),
                           ]
                         ),
                         Container(
                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white30)),
                           child: const Row(children: [Icon(Icons.check, color: Colors.white, size: 12), SizedBox(width: 4), Text('DEFAULT', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5))])
                         )
                      ]
                    ),
                    const Spacer(),
                    const Text('â€¢â€¢â€¢â€¢   â€¢â€¢â€¢â€¢   â€¢â€¢â€¢â€¢   4242', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text('CARDHOLDER NAME', style: TextStyle(color: Colors.white70, fontSize: 9, letterSpacing: 1)),
                             const SizedBox(height: 2),
                             const Text('CESC FABREGAS', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                           ]
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text('EXPIRES', style: TextStyle(color: Colors.white70, fontSize: 9, letterSpacing: 1)),
                             const SizedBox(height: 2),
                             const Text('08/27', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                           ]
                         ),
                         const Text('VISA', style: TextStyle(color: Colors.white, fontSize: 24, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900))
                      ]
                    )
                  ]
                )
              ),
              const SizedBox(height: 30),

              // 3. SAVED CARDS & METHODS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('SAVED CARDS & METHODS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  children: [
                    _buildMethodTile(
                      Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), alignment: Alignment.center, child: Text('VISA', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 11))),
                      'Visa ending in 4242', 
                      Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text('Default', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 9, fontWeight: FontWeight.bold))),
                      'Expires 08/27 â€¢ Debit Card', 
                      Icon(Icons.more_vert, color: Colors.grey.shade400)
                    ),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMethodTile(
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 24, height: 16,
                          child: Stack(
                            children: [
                              Positioned(left: 0, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.red.withOpacity(0.8), shape: BoxShape.circle))),
                              Positioned(right: 0, child: Container(width: 16, height: 16, decoration: BoxDecoration(color: Colors.amber.withOpacity(0.8), shape: BoxShape.circle))),
                            ]
                          )
                        )
                      ),
                      'Mastercard ending in 8831', 
                      null,
                      'Expires 11/26 â€¢ Credit Card', 
                      Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(20)), child: Text('Set\nDefault', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold, height: 1.2)))
                    ),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildMethodTile(
                      Container(width: 44, height: 44, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle), alignment: Alignment.center, child: const Icon(Icons.apple, color: Colors.white, size: 24)),
                      'Apple Pay', 
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                      '1-Touch Instant Checkout Enabled', 
                      Row(children: [const Text('Ready', style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 4), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade300)])
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // 4. DIGITAL WALLETS & BANK ACCOUNTS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('DIGITAL WALLETS & BANK ACCOUNTS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  children: [
                    _buildMethodTile(
                      Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle), alignment: Alignment.center, child: Text('PP', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16))),
                      'PayPal', 
                      null,
                      'cesc.fabregas@clubmail.com', 
                      Row(children: [Text('Connected', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)), const SizedBox(width: 4), Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade300)])
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ]
          )
        )
      )
    );
  }

  Widget _buildMethodTile(Widget iconWidget, String title, Widget? titleBadge, String subtitle, Widget trailingWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
           iconWidget,
           const SizedBox(width: 15),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Row(
                    children: [
                      Flexible(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis)),
                      if (titleBadge != null) ...[const SizedBox(width: 6), titleBadge]
                    ]
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
               ]
             )
           ),
           trailingWidget,
        ]
      )
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN SETTINGS
// ----------------------------------------------------------------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotif = true;
  bool trackingAlerts = true;
  bool promoDeals = false;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.search, size: 20),
                    ),
                  ],
                ),
              ),

              // 2. Search Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search preferences, orders, security...',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14)
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // 3. Card 1: REGIONAL & PREFERENCES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('REGIONAL & PREFERENCES', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  children: [
                    _buildSettingsTile(Icons.language, 'Language', 'Application display language', _buildCyanPill('English\n(US)'), showChevron: true),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildSettingsTile(Icons.attach_money, 'Currency', 'Pricing and checkout', _buildCyanPill('USD (\$)'), showChevron: true),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildSettingsTile(Icons.location_on_outlined, 'Country / Region', 'United States', Text('Default', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)), showChevron: true),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 4. Card 2: NOTIFICATIONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('NOTIFICATIONS', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  children: [
                    _buildSettingsTile(Icons.notifications_none, 'Push Notifications', 'Order updates and delivery', _buildToggle(pushNotif, (v) => setState(() => pushNotif = v)), showChevron: false),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildSettingsTile(Icons.local_shipping_outlined, 'Order Tracking Alerts', 'Real-time shipping notifications', _buildToggle(trackingAlerts, (v) => setState(() => trackingAlerts = v)), showChevron: false),
                    Divider(height: 1, color: Colors.grey.shade100, indent: 70),
                    _buildSettingsTile(Icons.local_offer_outlined, 'Promotions & Deals', 'VIP discounts and seasonal coupons', _buildToggle(promoDeals, (v) => setState(() => promoDeals = v)), showChevron: false),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 5. Card 3: DISPLAY & APPEARANCE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('DISPLAY & APPEARANCE', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Column(
                  children: [
                    _buildSettingsTile(Icons.dark_mode_outlined, 'Dark Mode', 'Adjust application theme', _buildToggle(darkMode, (v) => setState(() => darkMode = v)), showChevron: false),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ]
          )
        )
      )
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle, Widget trailingWidget, {bool showChevron = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
           Container(
             padding: const EdgeInsets.all(10),
             decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.cyan.shade100)),
             child: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
           ),
           const SizedBox(width: 15),
           Expanded(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
               ]
             )
           ),
           trailingWidget,
           if (showChevron) ...[
             const SizedBox(width: 8),
             Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey.shade300)
           ]
        ]
      )
    );
  }

  Widget _buildCyanPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(12)),
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildToggle(bool value, ValueChanged<bool> onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48, height: 26,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? Theme.of(context).primaryColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: value ? Theme.of(context).primaryColor : Colors.grey.shade300)
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20, height: 20,
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1))]),
          )
        )
      )
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN MY ORDERS
// ----------------------------------------------------------------------
class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _selectedTabIndex = 1;
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
                  Column(
                    children: [
                      const Text('My Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text('CESC â€¢ GOLD VIP', style: TextStyle(fontSize: 10, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                    child: const Icon(Icons.tune, size: 20),
                  ),
                ],
              ),
            ),
            
            // 2. Search & Filters
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 45,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search order ID or item...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
                    suffixIcon: Icon(Icons.qr_code_scanner, color: Colors.grey.shade400, size: 18),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12)
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 15),
            
            // 3. Tabs
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: tabs.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTabIndex = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          if (isSelected && index == 1) ...[
                            Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                          ],
                          Text(tabs[index]['name']!, style: TextStyle(color: isSelected ? Colors.white : Colors.grey.shade600, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                          const SizedBox(width: 6),
                          Text(tabs[index]['count']!, style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.bold)),
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
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  _buildOrderCard1(context),
                  const SizedBox(height: 15),
                  _buildOrderCard2(context),
                  const SizedBox(height: 15),
                  _buildOrderCard3(context),
                  const SizedBox(height: 40),
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget _buildOrderCard1(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('#ORD-9284', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 6),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: Text('Standard', style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Placed on Oct 16, 2024', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)), child: Row(children: [Icon(Icons.local_shipping_outlined, size: 14, color: Theme.of(context).primaryColor), const SizedBox(width: 4), Text('In Transit', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 11, fontWeight: FontWeight.bold))]))
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFF0FBFF), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(top: 4), width: 10, height: 10, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.cyan.shade100, width: 2))),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Package at Distribution Hub', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('Tomorrow, 14:00', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold))]),
                      const SizedBox(height: 2),
                      Text('Springfield Regional Sorting Facility (Inbound)', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                    ]
                  )
                )
              ],
            )
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://picsum.photos/seed/102/300/400', width: 55, height: 55, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Denim Classic Jacket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('Size: L â€¢ Indigo Blue', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('\$30.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('Qty: 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))])
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(top: 10), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade200, style: BorderStyle.solid))), // Dashed is hard, solid is fine
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 24, height: 24, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(6)), child: Text('+1', style: TextStyle(color: Colors.grey.shade600, fontSize: 10, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 8),
                    Text('Basic Eco-Cotton T-Shirt (Size M)', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text('\$15.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
              ],
            )
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Total (2 items)', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)), const SizedBox(height: 2), const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                Row(
                  children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Text('Details', style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 8),
                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen())), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)), SizedBox(width: 4), Icon(Icons.arrow_forward_ios, color: Colors.white, size: 10)]))),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildOrderCard2(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('#ORD-8910', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 6),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.orange.shade200)), child: Text('Express', style: TextStyle(color: Colors.orange.shade700, fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Placed on Oct 17, 2024', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.shade100)), child: Row(children: [Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle)), const SizedBox(width: 4), const Text('Out for Delivery', style: TextStyle(color: Colors.orange, fontSize: 11, fontWeight: FontWeight.bold))]))
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.orange.shade50.withOpacity(0.5), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.orange.shade100)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(width: 28, height: 28, alignment: Alignment.center, decoration: BoxDecoration(color: Colors.orange.shade100, shape: BoxShape.circle), child: const Text('ðŸ›µ', style: TextStyle(fontSize: 12))),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Courier near Evergreen Terr.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 2),
                        Text('Arriving in ~25 mins (Driver: Dave)', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                      ]
                    )
                  ],
                ),
                Text('Call', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold))
              ],
            )
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://picsum.photos/seed/103/300/400', width: 55, height: 55, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cargo Utility Pants', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('Size: 32 â€¢ Olive Green', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('\$30.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('Qty: 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))])
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Total (1 item)', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)), const SizedBox(height: 2), const Text('\$30.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                Row(
                  children: [
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Icon(Icons.info_outline, color: Colors.grey.shade600, size: 16)),
                    const SizedBox(width: 8),
                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingLiveScreen())), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(12)), child: const Row(children: [Icon(Icons.location_on_outlined, color: Colors.white, size: 14), SizedBox(width: 4), Text('Live Tracking', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))]))),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _buildOrderCard3(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade100), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('#ORD-7741', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(width: 6),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)), child: Text('Delivered', style: TextStyle(color: Colors.grey.shade500, fontSize: 10, fontWeight: FontWeight.bold))),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text('Delivered on Oct 12, 2024', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.green.shade100)), child: Row(children: [const Icon(Icons.check, size: 14, color: Colors.green), const SizedBox(width: 4), const Text('Delivered', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold))]))
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network('https://picsum.photos/seed/104/300/400', width: 55, height: 55, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Botanical Casual Shirt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('Size: L â€¢ Floral Hawaii Print', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    const SizedBox(height: 4),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('\$40.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)), Text('Qty: 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11, fontWeight: FontWeight.bold))])
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(top: 15), decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade100))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Total (1 item)', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)), const SizedBox(height: 2), const Text('\$40.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))]),
                Row(
                  children: [
                    GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WriteReviewScreen())), child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.cyan.shade50, border: Border.all(color: Colors.cyan.shade100), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.star, color: Colors.orange, size: 14), const SizedBox(width: 4), Text('Review', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold))]))),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)), child: Row(children: [Icon(Icons.refresh, color: Colors.grey.shade600, size: 14), const SizedBox(width: 4), Text('Reorder', style: TextStyle(color: Colors.grey.shade700, fontSize: 12, fontWeight: FontWeight.bold))])),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// WIDGET BANTUAN KATEGORI
// ----------------------------------------------------------------------
class CategoryItem extends StatelessWidget { 
  final String title; final String iconUrl; final bool isSelected; 
  const CategoryItem({super.key, required this.title, required this.iconUrl, required this.isSelected}); 
  @override 
  Widget build(BuildContext context) { 
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), 
      child: GestureDetector(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: title))); }, 
        child: Column(
          children: [
            // Gambar sekarang sudah memiliki lingkaran putih dan bayangan dari desain asli
            Container(
              height: 70, width: 70, 
              decoration: isSelected ? BoxDecoration(
                shape: BoxShape.circle, 
                border: Border.all(color: Theme.of(context).primaryColor, width: 2)
              ) : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: iconUrl.startsWith('http') 
                    ? Image.network(iconUrl, fit: BoxFit.cover) 
                    : Image.asset(iconUrl, fit: BoxFit.cover),
              )
            ), 
            const SizedBox(height: 8), 
            Text(title, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade600))
          ]
        )
      )
    ); 
  } 
}
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
                            child: const Text('ORDER #ORD-9284 ï¿½ Standard Shipping', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold)),
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
                                  Text('Size L ï¿½ Indigo Blue ï¿½ Qty 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
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
                                  Text('Size M ï¿½ Chalk White ï¿½ Qty 1', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
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
                                Text('ORDER #ORD-8910 ï¿½ EXPRESS', style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold)),
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
                                    Text('ï¿½ 1.8 mi away', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
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
                                      Text('Honda PCX160 ï¿½ CA8K...', style: TextStyle(color: Colors.grey.shade600, fontSize: 11)),
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
                            
                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Order Packed & Prepared', 'Pacific Distribution Hub ï¿½ 9:15 AM', false),
                            _buildExpressTimeline(true, Icons.check, Colors.green, 'Courier Picked Up', 'Dave Miller on route ï¿½ 9:32 AM', false),
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
                                        Text('Size 32 ï¿½ Olive Green', style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
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
                          onPressed: () { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Reset code sent!'))); Navigator.pop(context); },
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
                        Text('ORDER #ORD-7741 ï¿½ DELIVERED', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
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
                                  Text('Size: L ï¿½ Floral Hawaii Print', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
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
                                  Text('5.0 ï¿½ Excellent! Highly recommended', style: TextStyle(color: Color(0xFF0F8A9E), fontSize: 12, fontWeight: FontWeight.bold)),
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
                                  TextField(
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Share your experience with this product...',
                                    ),
                                    style: const TextStyle(fontSize: 13, height: 1.5),
                                    controller: TextEditingController.fromValue(const TextEditingValue(text: 'The fabric is super lightweight and comfortable for tropical weather! The floral print looks even more vibrant in person. Fits perfectly on size L. Will definitely order again.')),
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
                                      Text('Aura Express ï¿½ 2-Day Priority', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
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
class CustomerSupportChatScreen extends StatelessWidget {
  const CustomerSupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FD),
      body: SafeArea(
        child: Column(
          children: [
            // Top Nav
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))]
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 36, height: 36,
                              decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black87),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Avatar
                          Stack(
                            children: [
                              Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: const Color(0xFF00B4D8).withOpacity(0.3), width: 2),
                                ),
                                child: ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', fit: BoxFit.cover)),
                              ),
                              Positioned(
                                bottom: 0, right: 0,
                                child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2))),
                              )
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Name & Status
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text('Sarah Jenkins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                                  SizedBox(width: 4),
                                  Icon(Icons.check_circle, color: Colors.lightBlue, size: 14),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                  const SizedBox(width: 4),
                                  const Text('Online', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                                  Text(' � Replies <1m', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                            child: const Icon(Icons.phone_outlined, size: 18, color: Color(0xFF0096C7)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 36, height: 36,
                            decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                            child: const Icon(Icons.more_vert, size: 18, color: Colors.black87),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Context Chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFFE0F7FA), Color(0xFFE3F2FD)]),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.cyan.shade100)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF00B4D8).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF0096C7), size: 14)),
                            const SizedBox(width: 10),
                            const Text('Order #ORD-9284', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                            const Text(' � ', style: TextStyle(color: Colors.grey)),
                            const Text('In Transit (Denim Jacket)', style: TextStyle(color: Color(0xFF00838F), fontSize: 12, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.cyan.shade200)),
                          child: const Row(
                            children: [
                              Text('View', style: TextStyle(color: Color(0xFF0096C7), fontSize: 11, fontWeight: FontWeight.bold)),
                              Icon(Icons.chevron_right, color: Color(0xFF0096C7), size: 14)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            
            // Chat Stream
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // Date
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(color: Colors.grey.shade200.withOpacity(0.7), borderRadius: BorderRadius.circular(20)),
                      child: Text('TODAY, 10:24 AM', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  
                  // Security Notice
                  Center(
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)]),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.verified_user, color: Color(0xFF00B4D8), size: 16),
                          SizedBox(width: 8),
                          Expanded(child: Text('Cescrafli Priority Support. Conversations are encrypted & verified.', style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Agent Message 1
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', width: 24, height: 24, fit: BoxFit.cover)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                children: [
                                  TextSpan(text: 'Hi Cesc! ?? Thank you for reaching out to Cescrafli Priority Support. I see you\'re inquiring about your recent order '),
                                  TextSpan(text: '#ORD-9284', style: TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '. How can I assist you today?'),
                                ]
                              )
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text('10:24 AM', style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  
                  // Quick Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 32), // indent
                        _buildQuickPill('??', 'Track my package', true),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Change address', true),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Invoice copy', false),
                        const SizedBox(width: 8),
                        _buildQuickPill('??', 'Exchange size', false),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // User Message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF0096C7)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16), bottomRight: Radius.circular(4)),
                              boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]
                            ),
                            child: const Text('Hi Sarah! I wanted to check if the courier can leave the package at my front door if I\'m not home by 2 PM?', style: TextStyle(color: Colors.white, fontSize: 13, height: 1.4)),
                          ),
                          const SizedBox(height: 4),
                          const Row(
                            children: [
                              Text('10:25 AM', style: TextStyle(color: Colors.black38, fontSize: 10, fontWeight: FontWeight.w500)),
                              SizedBox(width: 4),
                              Icon(Icons.done_all, color: Color(0xFF00B4D8), size: 14),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Agent Response 2
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ClipOval(child: Image.network('https://picsum.photos/seed/sarah/100/100', width: 24, height: 24, fit: BoxFit.cover)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                  children: [
                                    TextSpan(text: 'Absolutely! I can update your delivery handover instructions directly in the system for courier '),
                                    TextSpan(text: 'Dave Miller', style: TextStyle(fontWeight: FontWeight.bold)),
                                    TextSpan(text: '.'),
                                  ]
                                )
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Rich Card
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
                              child: Column(
                                children: [
                                  // Product
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade100)),
                                    child: Row(
                                      children: [
                                        ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network('https://picsum.photos/seed/jacket/100/100', width: 45, height: 45, fit: BoxFit.cover)),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Denim Classic Jacket', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))]),
                                              const Text('Size L � Indigo Blue', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                              const SizedBox(height: 4),
                                              Row(children: [const Icon(Icons.two_wheeler, color: Colors.lightBlue, size: 12), const SizedBox(width: 4), Text('Arriving Today, ~2:30 PM', style: TextStyle(color: Colors.lightBlue.shade700, fontSize: 10, fontWeight: FontWeight.bold))])
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // Instruction Status
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: const Color(0xFFE0F7FA).withOpacity(0.7), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.cyan.shade100)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(width: 24, height: 24, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle), child: const Icon(Icons.check, color: Colors.white, size: 14)),
                                            const SizedBox(width: 8),
                                            const Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Front Door Drop-off', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                                Text('Instruction dispatched to Dave', style: TextStyle(color: Colors.black54, fontSize: 10)),
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(6)), child: Text('Confirmed', style: TextStyle(color: Colors.green.shade800, fontSize: 10, fontWeight: FontWeight.bold)))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(height: 1),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Security PIN bypass authorized', style: TextStyle(color: Colors.black54, fontSize: 11)),
                                      Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('#4920', style: TextStyle(color: Color(0xFF0096C7), fontSize: 11, fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Follow up text
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4)), border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 5)]),
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(color: Colors.black87, fontSize: 13, height: 1.4, fontFamily: 'Roboto'),
                                  children: [
                                    TextSpan(text: 'I\'ve tagged order #ORD-9284 as '),
                                    TextSpan(text: '"Safe Contactless Front Porch Drop-off"', style: TextStyle(fontWeight: FontWeight.w600)),
                                    TextSpan(text: '. You\'ll receive a confirmation photo as soon as it\'s delivered!'),
                                  ]
                                )
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text('Was this resolution helpful?', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w500)),
                                const SizedBox(width: 8),
                                _buildFeedbackBtn('??'),
                                const SizedBox(width: 4),
                                _buildFeedbackBtn('??'),
                                const SizedBox(width: 8),
                                Text('10:26 AM', style: TextStyle(color: Colors.grey.shade400, fontSize: 10, fontWeight: FontWeight.w500)),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            
            // Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))),
              child: Row(
                children: [
                  Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle), child: const Icon(Icons.attach_file, color: Colors.black54, size: 20)),
                  const SizedBox(width: 8),
                  Container(width: 40, height: 40, decoration: const BoxDecoration(color: Color(0xFFF1F5F9), shape: BoxShape.circle), child: const Icon(Icons.camera_alt_outlined, color: Colors.black54, size: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(20)),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.black38, fontSize: 13),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          suffixIcon: Icon(Icons.sentiment_satisfied_alt, color: Colors.black38, size: 20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [Color(0xFF00B4D8), Color(0xFF0096C7)]),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: const Color(0xFF00B4D8).withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]
                    ),
                    child: const Icon(Icons.send, color: Colors.white, size: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPill(String emoji, String text, bool isCyan) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isCyan ? const Color(0xFF00B4D8).withOpacity(0.5) : Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 2)]
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(color: isCyan ? const Color(0xFF0077B6) : Colors.black87, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFeedbackBtn(String emoji) {
    return Container(
      width: 24, height: 24,
      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 2)]),
      alignment: Alignment.center,
      child: Text(emoji, style: const TextStyle(fontSize: 10)),
    );
  }
}
