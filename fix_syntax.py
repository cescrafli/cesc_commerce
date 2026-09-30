import re

for file in ['lib/screens/home/home_screen.dart', 'lib/screens/profile/notifications_screen.dart', 'lib/screens/profile/help_support_screen.dart']:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace('\\\\n  const', '\n  const')
    with open(file, 'w', encoding='utf-8') as f:
        f.write(content)

with open('lib/screens/cart/address_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("setState(() => selectedAddress = realIndex)", "setState(() => selectedAddress = addresses.indexOf(addr))")
with open('lib/screens/cart/address_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/screens/home/home_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("itemCount: displayProducts.length,", "itemCount: categoryProducts.isNotEmpty ? categoryProducts.length : (products.length > 4 ? 4 : products.length),")
content = content.replace("product: displayProducts[index]", "product: categoryProducts.isNotEmpty ? categoryProducts[index] : products[index]")
content = content.replace("if (hour < 12) return _getGreeting();", "if (hour < 12) return 'Good Morning,';")
with open('lib/screens/home/home_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed syntax')
