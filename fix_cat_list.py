import re

with open('lib/screens/product/category_list_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/product_service.dart';\n"
if 'product_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

old_state = '''class _CategoryListScreenState extends State<CategoryListScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedChipIndex = 0;
  String _searchQuery = '';

  final allCategories = ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hats', 'Socks', 'Watches', 'Bags']; 
  final allItemsCount = [148, 92, 85, 64, 110, 42, 38, 57, 73];'''

new_state = '''class _CategoryListScreenState extends State<CategoryListScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedChipIndex = 0;
  String _searchQuery = '';
  bool _isLoading = true;

  List<String> allCategories = []; 
  final allItemsCount = [148, 92, 85, 64, 110, 42, 38, 57, 73];
  
  @override
  void initState() {
    super.initState();
    _loadCategories();
  }
  
  Future<void> _loadCategories() async {
    final cats = await ProductService().getCategories();
    if (mounted) {
      setState(() {
        allCategories = cats.where((c) => c != 'All').toList();
        if (allCategories.isEmpty) {
          allCategories = ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hats', 'Socks', 'Watches', 'Bags'];
        }
        _isLoading = false;
      });
    }
  }'''

content = content.replace(old_state, new_state)

old_build = '''@override
  Widget build(BuildContext context) {'''
new_build = '''@override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));'''
content = content.replace(old_build, new_build)

with open('lib/screens/product/category_list_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed category list')
