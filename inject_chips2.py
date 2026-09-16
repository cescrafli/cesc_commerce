import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"class _FavoriteScreenState extends State<FavoriteScreen> \{.*?// 3\. Sub-header"

new_state = """class _FavoriteScreenState extends State<FavoriteScreen> {
  String _selectedCategory = 'All';

  String _getCategory(String title) {
    title = title.toLowerCase();
    if (title.contains('jacket') || title.contains('coat') || title.contains('hoodie')) return 'Outerwear';
    if (title.contains('pant') || title.contains('jeans') || title.contains('short')) return 'Pants';
    if (title.contains('shirt') || title.contains('tee')) return 'Apparel';
    if (title.contains('shoe') || title.contains('sneaker')) return 'Shoes';
    return 'Other';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: ValueListenableBuilder<List<Map<String, dynamic>>>(
          valueListenable: globalWishlist,
          builder: (context, wishlist, _) {
            // Count categories
            Map<String, int> catCounts = {'All': wishlist.length};
            for (var item in wishlist) {
              String cat = _getCategory(item['title'] ?? '');
              catCounts[cat] = (catCounts[cat] ?? 0) + 1;
            }
            
            // Build chips list
            List<String> activeCats = ['All'];
            for (var c in ['Apparel', 'Outerwear', 'Pants', 'Shoes', 'Other']) {
              if ((catCounts[c] ?? 0) > 0) activeCats.add(c);
            }

            // Filter items
            List<Map<String, dynamic>> filteredItems = _selectedCategory == 'All' 
                ? wishlist 
                : wishlist.where((i) => _getCategory(i['title'] ?? '') == _selectedCategory).toList();

            return SingleChildScrollView(
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
                            Text('${wishlist.length} saved items' , style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
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
                  if (wishlist.isNotEmpty) SizedBox(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: activeCats.length,
                      itemBuilder: (context, index) {
                        String cat = activeCats[index];
                        String label = '${cat} (${catCounts[cat]})';
                        bool isSelected = _selectedCategory == cat;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedCategory = cat),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black54, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  // 3. Sub-header"""

content = re.sub(pattern, new_state, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Regex replace completed")
