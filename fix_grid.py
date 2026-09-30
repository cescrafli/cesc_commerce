import codecs, re

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

start_str = "GridView.count("
end_str = "],\n\n)"
if start_str in content:
    start_idx = content.find(start_str)
    end_idx = content.find(end_str, start_idx) + len(end_str)
    if end_idx > len(end_str):
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
print("Done")
