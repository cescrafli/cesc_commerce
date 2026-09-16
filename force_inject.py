import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

new_state = '''class _CategoryListScreenState extends State<CategoryListScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedChipIndex = 0;
  String _searchQuery = '';

  final allCategories = ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Shoes', 'Hats', 'Socks', 'Watches', 'Bags']; 
  final allItemsCount = [148, 92, 85, 64, 110, 42, 38, 57, 73];
  final allIcons = [
    'assets/images/categories/tshirt.png',
    'assets/images/categories/shirt.png',
    'assets/images/categories/pants.png',
    'assets/images/categories/jacket.png',
    'assets/images/categories/shoe.png',
    'assets/images/categories/hat.png',
    'assets/images/categories/socks.png',
    'assets/images/categories/watch.png',
    'assets/images/categories/bag.png',
  ]; 

  final chips = ['All (9)', 'Apparel', 'Footwear', 'Accessories'];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    List<int> filteredIndices = [];
    for (int i = 0; i < allCategories.length; i++) {
      bool matchesSearch = allCategories[i].toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesChip = false;
      if (_selectedChipIndex == 0) matchesChip = true;
      else if (_selectedChipIndex == 1 && ['T-Shirts', 'Shirts', 'Pants', 'Jackets', 'Socks'].contains(allCategories[i])) matchesChip = true;
      else if (_selectedChipIndex == 2 && ['Shoes'].contains(allCategories[i])) matchesChip = true;
      else if (_selectedChipIndex == 3 && ['Hats', 'Watches', 'Bags'].contains(allCategories[i])) matchesChip = true;
      
      if (matchesSearch && matchesChip) filteredIndices.add(i);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                    ),
                    Column(
                      children: [
                        const Text('Choose a Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Explore 9 vibrant styles', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                      ],
                    ),
                    ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: globalNotifications,
                      builder: (context, notifs, _) {
                        final hasUnread = notifs.any((n) => n['isRead'] == false);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()));
                          },
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                child: const Icon(Icons.notifications_none, size: 20),
                              ),
                              if (hasUnread) Positioned(top: 8, right: 8, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),

              // 2. Search & Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 55, padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey.shade400), 
                            const SizedBox(width: 10), 
                            Expanded(
                              child: TextField(
                                onChanged: (val) => setState(() => _searchQuery = val),
                                decoration: InputDecoration(
                                  hintText: 'Search categories...',
                                  hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () {
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Advanced filters coming soon!')));
                      },
                      child: Container(
                        height: 55, width: 55,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))]),
                        child: const Icon(Icons.tune, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),

              // 3. Chips
              const SizedBox(height: 10),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chips.length,
                  itemBuilder: (context, index) {
                    bool isSelected = _selectedChipIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedChipIndex = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300),
                        ),
                        child: Text(chips[index], style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 12)),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),

              // 4. Main Collections Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('MAIN COLLECTIONS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select Multi coming soon!')));
                      },
                      child: Text('Select Multi', style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              // 5. Grid of Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: filteredIndices.isEmpty 
                  ? const Padding(padding: EdgeInsets.only(top: 50), child: Center(child: Text('No categories found', style: TextStyle(color: Colors.grey))))
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, crossAxisSpacing: 15, mainAxisSpacing: 25, childAspectRatio: 0.72
                      ),
                      itemCount: filteredIndices.length,
                      itemBuilder: (context, idx) {
                        int index = filteredIndices[idx];
                        bool isSelected = _selectedCategoryIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedCategoryIndex = index);
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: allCategories[index])));
                          },
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.cyan.shade50 : Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.white, width: isSelected ? 1.5 : 0),
                                  boxShadow: [if (!isSelected) BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Spacer(flex: 2),
                                    Container(
                                      width: 45, height: 45,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade100)),
                                      child: Image.asset(allIcons[index]),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(allCategories[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text(' items', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                              if (isSelected) Positioned(
                                top: -10, left: 0, right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
                                    child: const Text('POPULAR', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
              ),
              const SizedBox(height: 30),
            ]
          )
        )
      )
    );
  }
}
'''

new_lines = lines[:5803] + [new_state + "\n"] + lines[5995:]

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(new_lines)

print("Injected CategoryListScreenState perfectly!")
