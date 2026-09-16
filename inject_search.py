import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

new_search = '''class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['T-Shirt Mens', 'Sneakers White', 'Jacket Denim'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Container(
          height: 44,
          decoration: BoxDecoration(color: const Color(0xFFF7F8FA), borderRadius: BorderRadius.circular(22)),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search products...',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: IconButton(icon: const Icon(Icons.close, color: Colors.grey, size: 18), onPressed: () => _searchController.clear()),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12)
            )
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent Searches
              if (recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Recent Searches', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    TextButton(onPressed: () => setState(() => recentSearches.clear()), child: const Text('Clear All', style: TextStyle(color: Color(0xFF00BCD4))))
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: recentSearches.map((search) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFFF0FBFF), borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE0F4F8))),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.history, size: 14, color: Color(0xFF00BCD4)),
                        const SizedBox(width: 6),
                        Text(search, style: const TextStyle(color: Color(0xFF006C7A), fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )).toList(),
                ),
                const SizedBox(height: 30),
              ],
              
              // Trending
              const Text('Trending Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 15),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Smart Watches', 'Summer Collection', 'Running Shoes', 'Wireless Earbuds'].map((trend) => GestureDetector(
                  onTap: () {
                    _searchController.text = trend;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade300)),
                    child: Text(trend, style: const TextStyle(color: Colors.black87, fontSize: 13)),
                  ),
                )).toList(),
              ),
            ]
          )
        )
      )
    );
  }
}'''

old_search_pattern = r'class SearchScreen extends StatelessWidget \{.*?(?=\nclass FavoriteScreen extends StatefulWidget \{)'

match = re.search(old_search_pattern, content, re.DOTALL)
if match:
    content = content[:match.start()] + new_search + '\n\n' + content[match.end():]
    with open('lib/main.dart', 'w', encoding='utf-8') as f:
        f.write(content)
    print("Successfully replaced SearchScreen")
else:
    print("Could not find SearchScreen")

