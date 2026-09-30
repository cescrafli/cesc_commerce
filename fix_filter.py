import codecs, re

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace the onTap pop
content = re.sub(
    r"onTap: \(\) => Navigator\.pop\(context\),[\s\S]+?const Text\('Apply Filter'",
    r"onTap: () => Navigator.pop(context, {'price': _currentRangeValues, 'categories': _selectedCategories, 'brands': _selectedBrands, 'colors': _selectedColors}),\n                     child: Container(\n                         height: 50,\n                         decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(16)),\n                         child: Row(\n                           mainAxisAlignment: MainAxisAlignment.center,\n                           children: [\n                              const Text('Apply Filter'",
    content
)

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'w', 'utf-8') as f:
    f.write(content)

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Update _showFilterModal
new_modal = r"""void _showFilterModal(BuildContext context) async {
    final result = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
    if (result != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: 'Filtered', filter: result)));
    }
  }"""
content = re.sub(r"void _showFilterModal\(BuildContext context\) \{[\s\S]*?\}\n\n", new_modal + "\n\n", content)

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
