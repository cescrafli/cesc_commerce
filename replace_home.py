import codecs

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# For Popular Items (horizontal list)
start_str = "SingleChildScrollView(scrollDirection: Axis.horizontal"
end_str = ")),\n\n\n\n            const SizedBox(height: 30),"
if start_str in content:
    start_idx = content.find(start_str)
    end_idx = content.find(end_str, start_idx)
    if end_idx != -1:
        new_str = '''ValueListenableBuilder(
      valueListenable: globalProducts,
      builder: (context, List<Map<String, dynamic>> products, child) {
        final popular = products.where((p) => p['isPopular'] == true).toList();
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: popular.map((p) => Padding(padding: const EdgeInsets.only(right: 16), child: SizedBox(width: 160, child: ProductCard(product: p)))).toList()
          )
        );
      }
    )'''
        content = content[:start_idx] + new_str + content[end_idx:]

# For New Arrivals (grid)
start_str2 = "GridView.count("
end_str2 = "),\n\n          ),\n\n          const SizedBox(height: 80),"
if start_str2 in content:
    start_idx = content.find(start_str2)
    end_idx = content.find(end_str2, start_idx)
    if end_idx != -1:
        new_str = '''ValueListenableBuilder(
      valueListenable: globalProducts,
      builder: (context, List<Map<String, dynamic>> products, child) {
        final newArrivals = products.where((p) => p['isPopular'] == false).toList();
        return GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.58,
          children: newArrivals.map((p) => ProductCard(product: p)).toList(),
        );
      }
    )'''
        content = content[:start_idx] + new_str + content[end_idx:]

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
