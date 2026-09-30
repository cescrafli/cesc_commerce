import re

with open('lib/screens/cart/address_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
# Revert the wrong replace
content = content.replace("globalAddresses.value.indexOf(addr)", "index")
with open('lib/screens/cart/address_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)

with open('lib/screens/profile/profile_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("const PaymentMethodsScreen()", "PaymentMethodsScreen()")
with open('lib/screens/profile/profile_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
