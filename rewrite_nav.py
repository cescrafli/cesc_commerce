import codecs

content = """import 'package:flutter/material.dart';
import '../../core/localization.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

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
    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, lang, _) {
        return Scaffold(
          body: _screens[_currentIndex],
          floatingActionButton: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.4), blurRadius: 15, offset: const Offset(0, 5))]
            ),
            child: FloatingActionButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  Positioned(
                    right: 0, top: 0,
                    child: ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: globalCart,
                      builder: (context, cart, child) {
                        if (cart.isEmpty) return const SizedBox.shrink();
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(color: const Color(0xFFE91E63), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                          child: Text('${cart.length}', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                        );
                      }
                    )
                  )
                ]
              ),
            )
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            color: Colors.white,
            elevation: 10,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Icons.home, Icons.home_outlined, 0, tr('home')),
                        _buildNavItem(Icons.grid_view_rounded, Icons.grid_view_outlined, 1, tr('categories')),
                      ]
                    )
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Icons.favorite, Icons.favorite_outline, 3, tr('favorite')),
                        _buildNavItem(Icons.person, Icons.person_outline, 4, tr('profile')),
                      ]
                    )
                  )
                ]
              )
            )
          )
        );
      }
    );
  }

  Widget _buildNavItem(IconData activeIcon, IconData inactiveIcon, int index, String label) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: Container(
        color: Colors.transparent,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isActive ? activeIcon : inactiveIcon, color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade400, size: 26),
            if (isActive) ...[
              const SizedBox(height: 4),
              Container(width: 4, height: 4, decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle))
            ]
          ]
        )
      )
    );
  }
}
"""
with codecs.open('lib/screens/home/main_navigation_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Nav fixed")
