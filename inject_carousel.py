import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# 1. Insert dart:async
if "import 'dart:async';" not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'dart:async';")

# 2. Add PromoCarousel class before HomeScreen
carousel_class = """class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});
  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, String>> promos = [
    {
      'tag': 'SUMMER 2024',
      'title': 'Eco-Collection\\nMountain Series',
      'subtitle': 'Up to 40% OFF this week',
      'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'
    },
    {
      'tag': 'NEW ARRIVAL',
      'title': 'Urban Street\\nFashion 2.0',
      'subtitle': 'Exclusive for members',
      'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'
    },
    {
      'tag': 'LIMITED EDITION',
      'title': 'Winter Coat\\nPremium Collection',
      'subtitle': 'Buy 1 Get 1 Free',
      'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'
    }
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < promos.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        height: 180,
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemCount: promos.length,
          itemBuilder: (context, index) {
            final promo = promos[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(title: promo['title']!.replaceAll('\\n', ' '), price: 'Promo', imageUrl: promo['image']!)));
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(image: NetworkImage(promo['image']!), fit: BoxFit.cover),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)), child: Text(promo['tag']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                      const SizedBox(height: 12),
                      Text(promo['title']!, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
                      const SizedBox(height: 8),
                      Text(promo['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      const Spacer(),
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
                            children: List.generate(promos.length, (dotIndex) {
                              return Container(
                                margin: const EdgeInsets.only(left: 4),
                                width: _currentPage == dotIndex ? 16 : 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: _currentPage == dotIndex ? Theme.of(context).primaryColor : Colors.white54,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {"""

content = content.replace("class HomeScreen extends StatelessWidget {", carousel_class)

# 3. Replace the Promo Banner block with const PromoCarousel(),
# I will use a regex to replace the entire 3. Promo Banner section
pattern = r"// 3\. Promo Banner.*?// 4\. Categories"
replacement = "// 3. Promo Banner\n              const PromoCarousel(),\n\n              // 4. Categories"

content = re.sub(pattern, replacement, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Injected Carousel successfully")
