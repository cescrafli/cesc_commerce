import re

with open('lib/screens/cart/address_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Update Deliver to this Address button to pop with data
content = content.replace("Navigator.pop(context)", "Navigator.pop(context, selectedAddress)")

# 2. Add search query state
content = content.replace('int selectedAddress = 0;', 'int selectedAddress = 0;\n  String _searchQuery = "";')

# 3. Add onChange for search
content = content.replace('''              TextField(
                decoration: InputDecoration(
                  hintText: tr('search'),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),''', '''              TextField(
                onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
                decoration: InputDecoration(
                  hintText: tr('search'),
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),''')

# 4. Filter addresses
content = content.replace('''                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final addr = addresses[index];
                    bool isSelected = selectedAddress == index;''', '''                final filteredAddresses = addresses.where((a) {
                  final title = (a['title'] ?? '').toLowerCase();
                  final name = (a['name'] ?? '').toLowerCase();
                  final street = (a['street'] ?? '').toLowerCase();
                  return title.contains(_searchQuery) || name.contains(_searchQuery) || street.contains(_searchQuery);
                }).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredAddresses.length,
                  itemBuilder: (context, index) {
                    final addr = filteredAddresses[index];
                    final realIndex = addresses.indexOf(addr);
                    bool isSelected = selectedAddress == realIndex;''')

content = content.replace("setState(() => selectedAddress = index)", "setState(() => selectedAddress = realIndex)")

# 5. Fix header + icon
content = content.replace('''              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              )''', '''              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewAddressScreen())),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              )''')

with open('lib/screens/cart/address_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed address_screen.dart')
