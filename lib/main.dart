import 'package:flutter/material.dart';

void main() {
  runApp(const CescCommerceApp());
}

// ----------------------------------------------------------------------
// STATE MANAGEMENT GLOBAL (Sederhana)
// ----------------------------------------------------------------------
final ValueNotifier<List<Map<String, dynamic>>> globalCart = ValueNotifier([]);

void addToCart(String title, String subtitle, String priceStr, String image, BuildContext context) {
  double price = 0.0;
  try { price = double.parse(priceStr.replaceAll('\$', '').trim()); } catch (e) { price = 10.0; }

  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  int existingIndex = currentCart.indexWhere((item) => item['title'] == title);
  
  if (existingIndex >= 0) { currentCart[existingIndex]['qty']++; } 
  else { currentCart.add({'title': title, 'subtitle': subtitle, 'price': price, 'qty': 1, 'image': image}); }
  
  globalCart.value = currentCart;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('$title added to cart!'), backgroundColor: const Color(0xFF18C5DF), duration: const Duration(seconds: 1))
  );
}

void updateCartItemQty(int index, int change) {
  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  currentCart[index]['qty'] += change;
  if (currentCart[index]['qty'] <= 0) { currentCart.removeAt(index); }
  globalCart.value = currentCart;
}

void removeCartItem(int index) {
  final currentCart = List<Map<String, dynamic>>.from(globalCart.value);
  currentCart.removeAt(index);
  globalCart.value = currentCart;
}

class CescCommerceApp extends StatelessWidget {
  const CescCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cescrafli',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // WARNA UTAMA DIUBAH KE CYAN SESUAI LOGO BARU
        primaryColor: const Color(0xFF18C5DF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF18C5DF)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(), 
    );
  }
}

// ----------------------------------------------------------------------
// HALAMAN AUTENTIKASI (LOGIN & SIGN UP) DENGAN LOGO BARU
// ----------------------------------------------------------------------
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Menampilkan Gambar Logo Ikon dan Teks
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/images/logo_icon.png', height: 100),
                    const SizedBox(height: 15),
                    Image.asset('assets/images/logo_text.png', height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Welcome Back',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF1A3B8B)), // Menggunakan warna biru gelap logo
              ),
              const SizedBox(height: 10),
              const Text('Log in to continue shopping', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              // Field Email
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email or Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(height: 20),
              // Field Password
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
              const SizedBox(height: 15),
              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                  child: Text('Forgot Password?', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),
              // Tombol Log In
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Log In', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Tombol Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                    child: Text('Sign up', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Create an Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2, color: Color(0xFF1A3B8B))),
              const SizedBox(height: 10),
              const Text('Join Cescrafli and start shopping!', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 40),
              TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 20),
              TextField(decoration: InputDecoration(labelText: 'Email Address', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 20),
              TextField(obscureText: true, decoration: InputDecoration(labelText: 'Password', suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()), (route) => false);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Sign Up', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Forgot Password', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2, color: Color(0xFF1A3B8B))),
              const SizedBox(height: 10),
              const Text('Enter your phone number or email and we will send you a code to reset your password.', style: TextStyle(color: Colors.grey, fontSize: 16)),
              const SizedBox(height: 40),
              TextField(decoration: InputDecoration(labelText: 'Phone Number / Email', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity, height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recovery code sent!')));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Send the code', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _currentIndex = 2),
        backgroundColor: Theme.of(context).primaryColor,
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
                      padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                      child: Text('${cart.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(minWidth: 40, onPressed: () => setState(() => _currentIndex = 0), child: Icon(Icons.home_filled, color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey.shade400)),
                  MaterialButton(minWidth: 40, onPressed: () => setState(() => _currentIndex = 1), child: Icon(Icons.grid_view_rounded, color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey.shade400)),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(minWidth: 40, onPressed: () => setState(() => _currentIndex = 3), child: Icon(Icons.favorite_outline, color: _currentIndex == 3 ? Theme.of(context).primaryColor : Colors.grey.shade400)),
                  MaterialButton(minWidth: 40, onPressed: () => setState(() => _currentIndex = 4), child: Icon(Icons.person_outline, color: _currentIndex == 4 ? Theme.of(context).primaryColor : Colors.grey.shade400)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// 1. HALAMAN HOME 
// ----------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(context: context, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (context) { return Container(padding: const EdgeInsets.all(20), height: 300, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Filter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))]), const SizedBox(height: 20), const Text('Price Range', style: TextStyle(fontWeight: FontWeight.bold)), RangeSlider(values: const RangeValues(10, 100), min: 0, max: 200, activeColor: Theme.of(context).primaryColor, onChanged: (values) {}), const SizedBox(height: 20), SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white), onPressed: () => Navigator.pop(context), child: const Text('Apply Filter')))])); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Good Morning,', style: TextStyle(fontSize: 14, color: Colors.grey.shade500)), const SizedBox(height: 4), const Text('Cesc Fabregas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A3B8B)))]), GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())), child: const CircleAvatar(radius: 22, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')))])),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), child: Row(children: [Expanded(child: GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())), child: Container(height: 50, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]), child: Row(children: [Icon(Icons.search, color: Colors.grey.shade400), const SizedBox(width: 10), Text('Search clothes...', style: TextStyle(color: Colors.grey.shade400, fontSize: 16))])))), const SizedBox(width: 12), GestureDetector(onTap: () => _showFilterSheet(context), child: Container(height: 50, width: 50, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.tune, color: Colors.white)))])),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryListScreen())), child: Text('See All', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))])),
              const SizedBox(height: 16),
              SizedBox(height: 100, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 12), children: const [CategoryItem(title: 'T-Shirts', iconUrl: 'https://cdn-icons-png.flaticon.com/512/863/863684.png', isSelected: true), CategoryItem(title: 'Shirts', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2503/2503380.png', isSelected: false), CategoryItem(title: 'Pants', iconUrl: 'https://cdn-icons-png.flaticon.com/512/3343/3343940.png', isSelected: false), CategoryItem(title: 'Jackets', iconUrl: 'https://cdn-icons-png.flaticon.com/512/2784/2784534.png', isSelected: false)])),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Popular Deals', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoriteScreen())), child: Text('See All', style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)))])),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.72),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final titles = ['Basic T-Shirt', 'Denim Jacket', 'Cargo Pants', 'Flannel Shirt'];
                    return ProductCard(title: titles[index], subtitle: 'Cotton 100%', price: '\$${(index+1)*15}.00', imageUrl: 'https://picsum.photos/seed/${index + 101}/300/400');
                  },
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
      appBar: AppBar(title: const Text('My Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true, iconTheme: const IconThemeData(color: Colors.black)),
      body: ValueListenableBuilder<List<Map<String, dynamic>>>(
        valueListenable: globalCart,
        builder: (context, cartItems, child) {
          double totalPrice = 0;
          for (var item in cartItems) { totalPrice += (item['price'] as double) * (item['qty'] as int); }

          return Column(
            children: [
              Expanded(
                child: cartItems.isEmpty 
                ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.shopping_basket_outlined, size: 80, color: Colors.grey.shade400), const SizedBox(height: 20), const Text("Your Cart is Empty", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]))
                : ListView.builder(
                    padding: const EdgeInsets.all(20), itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _buildCartItem(context, index, item['title'], item['subtitle'], item['price'], item['qty'], item['image']);
                    },
                  ),
              ),
              if (cartItems.isNotEmpty)
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
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index, String title, String subtitle, double price, int qty, String img) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10)]),
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
// WIDGET BANTUAN UI 
// ----------------------------------------------------------------------
class ProductCard extends StatelessWidget { 
  final String title; final String subtitle; final String price; final String imageUrl; 
  const ProductCard({super.key, required this.title, required this.subtitle, required this.price, required this.imageUrl}); 
  @override Widget build(BuildContext context) { return GestureDetector(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(title: title, price: price, imageUrl: imageUrl))); }, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.08), spreadRadius: 2, blurRadius: 12, offset: const Offset(0, 4))]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Stack(children: [ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.network(imageUrl, width: double.infinity, height: double.infinity, fit: BoxFit.cover)), Positioned(top: 8, right: 8, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.favorite_border, size: 16, color: Colors.grey)))])), Padding(padding: const EdgeInsets.all(12.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 2), Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)), const SizedBox(height: 8), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(price, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14)), GestureDetector(onTap: () { addToCart(title, subtitle, price, imageUrl, context); }, child: Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6)), child: const Icon(Icons.add, color: Colors.white, size: 16)))])]))]))); } 
}

class ProductDetailScreen extends StatelessWidget {
  final String title; final String price; final String imageUrl;
  const ProductDetailScreen({super.key, required this.title, required this.price, required this.imageUrl});
  @override Widget build(BuildContext context) { return Scaffold(backgroundColor: Colors.white, appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, foregroundColor: Colors.black, actions: [IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}), IconButton(icon: const Icon(Icons.share_outlined), onPressed: () {})]), extendBodyBehindAppBar: true, body: Column(children: [Expanded(child: Image.network(imageUrl, width: double.infinity, fit: BoxFit.cover)), Container(padding: const EdgeInsets.all(24), decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30)), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))]), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2))), Text(price, style: TextStyle(fontSize: 22, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold))]), const SizedBox(height: 12), Row(children: [Icon(Icons.star, color: Colors.amber.shade400, size: 20), const SizedBox(width: 4), const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(width: 8), Text('(124 Reviews)', style: TextStyle(color: Colors.grey.shade500))]), const SizedBox(height: 24), const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text('Premium 100% cotton apparel that is very comfortable to wear for everyday activities. Modern design, sweat-absorbent, and perfect to pair with your various clothing styles.', style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.5)), const SizedBox(height: 30), SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () { addToCart(title, 'Cotton 100%', price, imageUrl, context); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Add to Cart', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)))), const SizedBox(height: 10)]))])); }
}

// ----------------------------------------------------------------------
// HALAMAN-HALAMAN LAINNYA 
// ----------------------------------------------------------------------
class CheckoutScreen extends StatelessWidget { const CheckoutScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Checkout', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Delivery Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 10), ListTile(contentPadding: const EdgeInsets.all(15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)), leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.location_on, color: Theme.of(context).primaryColor)), title: const Text('Home Address', style: TextStyle(fontWeight: FontWeight.bold)), subtitle: const Text('123 Main Street, San Diego, CA 92101'), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen()))), const SizedBox(height: 25), const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(height: 10), ListTile(contentPadding: const EdgeInsets.all(15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)), leading: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.credit_card, color: Colors.blue)), title: const Text('Visa **** 1234', style: TextStyle(fontWeight: FontWeight.bold)), trailing: const Icon(Icons.arrow_forward_ios, size: 16), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PaymentScreen()))), const SizedBox(height: 40), SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () { globalCart.value = []; Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrderSuccessScreen())); }, style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Place Order', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold))))]))); } }
class AddressScreen extends StatelessWidget { const AddressScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('New Address', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: Padding(padding: const EdgeInsets.all(20), child: Column(children: [TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), const SizedBox(height: 15), TextField(decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), const SizedBox(height: 15), TextField(decoration: InputDecoration(labelText: 'Street Address', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), const SizedBox(height: 15), TextField(decoration: InputDecoration(labelText: 'City', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))), const SizedBox(height: 30), SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Save Address', style: TextStyle(color: Colors.white, fontSize: 16))))]))); } }
class PaymentScreen extends StatelessWidget { const PaymentScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Payment Method', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: ListView(padding: const EdgeInsets.all(20), children: [_buildPaymentOption(context, 'Credit Card', Icons.credit_card, true), _buildPaymentOption(context, 'PayPal', Icons.paypal, false), _buildPaymentOption(context, 'Cash on Delivery', Icons.money, false)])); } Widget _buildPaymentOption(BuildContext context, String title, IconData icon, bool isSelected) { return Container(margin: const EdgeInsets.only(bottom: 15), child: ListTile(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300)), leading: Icon(icon, color: isSelected ? Theme.of(context).primaryColor : Colors.grey), title: Text(title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)), trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).primaryColor) : null, onTap: () => Navigator.pop(context))); } }
class OrderSuccessScreen extends StatelessWidget { const OrderSuccessScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(body: Center(child: Padding(padding: const EdgeInsets.all(30.0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: const EdgeInsets.all(30), decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.1), shape: BoxShape.circle), child: Icon(Icons.check_circle, size: 80, color: Theme.of(context).primaryColor)), const SizedBox(height: 30), const Text('Yay! Order Placed', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), const SizedBox(height: 10), Text('Your order has been placed successfully\nand will be processed soon.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 16)), const SizedBox(height: 50), SizedBox(width: double.infinity, height: 55, child: ElevatedButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TrackingScreen())), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Track Order', style: TextStyle(color: Colors.white, fontSize: 16)))), const SizedBox(height: 15), TextButton(onPressed: () => Navigator.pop(context), child: Text('Back to Home', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16)))])))); } }
class TrackingScreen extends StatelessWidget { const TrackingScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Track Order', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.local_shipping, size: 100, color: Theme.of(context).primaryColor), const SizedBox(height: 30), const Text('Your order is on the way!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 20), ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor), child: const Text('Done', style: TextStyle(color: Colors.white)))]))); } }
class CategoryListScreen extends StatelessWidget { const CategoryListScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Choose a Category', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, centerTitle: true, iconTheme: const IconThemeData(color: Colors.black)), body: GridView.builder(padding: const EdgeInsets.all(20), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 30, childAspectRatio: 0.8), itemCount: 9, itemBuilder: (context, index) { final categories = ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hats', 'Socks', 'Watches', 'Bags']; final icons = [Icons.checkroom, Icons.person, Icons.accessibility_new, Icons.ac_unit, Icons.do_not_step, Icons.face, Icons.snowshoeing, Icons.watch, Icons.shopping_bag]; return CategoryItem(title: categories[index], iconUrl: 'https://cdn-icons-png.flaticon.com/512/863/863684.png', isSelected: false); })); } }
class CategoryProductsScreen extends StatelessWidget { final String categoryName; const CategoryProductsScreen({super.key, required this.categoryName}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: Text(categoryName, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: GridView.builder(padding: const EdgeInsets.all(20), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.72), itemCount: 6, itemBuilder: (context, index) { return ProductCard(title: '$categoryName Item ${index + 1}', subtitle: 'Best Quality', price: '\$${(index+1)*12}.00', imageUrl: 'https://picsum.photos/seed/${index + 300}/300/400'); })); } }
class SearchScreen extends StatelessWidget { const SearchScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black), title: Container(height: 40, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)), child: const TextField(autofocus: true, decoration: InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search, color: Colors.grey), border: InputBorder.none)))), body: Padding(padding: const EdgeInsets.all(20.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 15), ListTile(leading: const Icon(Icons.history), title: const Text('T-Shirt Mens'), trailing: const Icon(Icons.close, size: 16), onTap: (){})]))); } }
class FavoriteScreen extends StatelessWidget { const FavoriteScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Favorites', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: GridView.builder(padding: const EdgeInsets.all(20), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.72), itemCount: 8, itemBuilder: (context, index) {return ProductCard(title: 'Item $index', subtitle: 'Fashion', price: '\$${(index+1)*10}.00', imageUrl: 'https://picsum.photos/seed/${index + 200}/300/400');})); } }
class ProfileScreen extends StatelessWidget { const ProfileScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(body: Column(children: [Container(height: 220, width: double.infinity, decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40))), child: const SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('My Profile', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)), SizedBox(height: 20), CircleAvatar(radius: 40, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')), SizedBox(height: 10), Text('Cesc Fabregas', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))]))), const SizedBox(height: 20), Expanded(child: ListView(padding: const EdgeInsets.symmetric(horizontal: 20), children: [_buildProfileMenu(Icons.person_outline, 'My Profile'), _buildProfileMenu(Icons.notifications_none, 'Notifications'), _buildProfileMenu(Icons.settings_outlined, 'Settings'), _buildProfileMenu(Icons.payment, 'Payment'), _buildProfileMenu(Icons.help_outline, 'Help & Support'), const SizedBox(height: 20), _buildProfileMenu(Icons.logout, 'Log Out', isLogout: true)]))])); } Widget _buildProfileMenu(IconData icon, String title, {bool isLogout = false}) { return Container(margin: const EdgeInsets.only(bottom: 15), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]), child: Row(children: [Icon(icon, color: isLogout ? Colors.red : Colors.black54), const SizedBox(width: 20), Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: isLogout ? Colors.red : Colors.black87))), if (!isLogout) const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)])); } }

// ----------------------------------------------------------------------
// WIDGET BANTUAN KATEGORI
// ----------------------------------------------------------------------
class CategoryItem extends StatelessWidget { final String title; final String iconUrl; final bool isSelected; const CategoryItem({super.key, required this.title, required this.iconUrl, required this.isSelected}); @override Widget build(BuildContext context) { return Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: GestureDetector(onTap: () { Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: title))); }, child: Column(children: [Container(padding: const EdgeInsets.all(12), height: 65, width: 65, decoration: BoxDecoration(color: isSelected ? Theme.of(context).primaryColor : Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]), child: Image.network(iconUrl, color: isSelected ? Colors.white : Colors.grey.shade600)), const SizedBox(height: 8), Text(title, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? Colors.black87 : Colors.grey.shade600))]))); } }
