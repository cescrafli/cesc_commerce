import re

with open('lib/screens/cart/address_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
# addresses is globalAddresses.value.
content = content.replace("addresses.indexOf(addr)", "globalAddresses.value.indexOf(addr)")
with open('lib/screens/cart/address_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/screens/home/home_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("categoryProducts.isNotEmpty", "categoryProducts != null && categoryProducts.isNotEmpty")
content = content.replace("categoryProducts.length", "categoryProducts.length")
content = content.replace("categoryProducts[index]", "categoryProducts[index]")
with open('lib/screens/home/home_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/screens/profile/profile_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("const NotificationsScreen()", "NotificationsScreen()")
content = content.replace("const HelpSupportScreen()", "HelpSupportScreen()")
with open('lib/screens/profile/profile_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
