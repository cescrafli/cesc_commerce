import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"class _PromoCarouselState extends State<PromoCarousel> \{.*?padding: const EdgeInsets\.symmetric\(horizontal: 20, vertical: 15\),\s*child: SizedBox\(\s*height: 200,\s*child: PageView\.builder\(.*?Icon\(Icons\.arrow_forward_ios, color: Colors\.white, size: 12\),\s*\]\s*\)\s*\]\s*\)\s*\]\s*\),\s*\),\s*\)\s*\]\s*\),\s*\),\s*\]\s*\),\s*\),\s*);\s*\}\s*\),\s*\),\s*\);\s*\}\s*\}"

new_state = '''class _PromoCarouselState extends State<PromoCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, String>> promos = [
    {'title': 'Summer Collection\\nDiscount', 'subtitle': 'Up to 50% Off', 'tag': 'PROMO', 'image': 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
    {'title': 'Urban Fashion\\nArrivals', 'subtitle': 'Discover new styles', 'tag': 'NEW', 'image': 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
    {'title': 'Premium Winter\\nCoats', 'subtitle': 'Buy 1 Get 1 Free', 'tag': 'HOT', 'image': 'https://images.unsplash.com/photo-1539533113208-f6df8cc8b543?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80'},
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
        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: SizedBox(
        height: 220, // Increased height heavily to prevent overflow!
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
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)), child: Text(promo['tag']!, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                        const SizedBox(height: 12),
                        Text(promo['title']!, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, height: 1.2)),
                        const SizedBox(height: 8),
                        Text(promo['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Text('Shop Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(width: 5),
                                Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle), child: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12)),
                              ]
                            )
                          ]
                        )
                      ]
                    )
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}'''

content = re.sub(pattern, new_state, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Injected invincible carousel")
