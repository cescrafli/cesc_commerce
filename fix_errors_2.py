import codecs, re

# 1. Onboarding Screen
with codecs.open('lib/screens/misc/onboarding_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total", "child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total")
content = content.replace("children: const [Text('\\$${total", "children: [Text('\\$${total")
with codecs.open('lib/screens/misc/onboarding_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 2. Checkout Screen
with codecs.open('lib/screens/cart/checkout_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total", "child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total")
content = content.replace("children: const [Text('\\$${total", "children: [Text('\\$${total")
with codecs.open('lib/screens/cart/checkout_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 3. Payment Screen
with codecs.open('lib/screens/cart/payment_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total", "child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total")
content = content.replace("children: const [Text('\\$${total", "children: [Text('\\$${total")
with codecs.open('lib/screens/cart/payment_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 4. Add New Card Screen
with codecs.open('lib/screens/cart/add_new_card_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
content = content.replace("child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total", "child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('\\$${total")
content = content.replace("children: const [Text('\\$${total", "children: [Text('\\$${total")
with codecs.open('lib/screens/cart/add_new_card_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

# 5. Edit Address Screen
with codecs.open('lib/screens/cart/edit_address_screen.dart', 'r', 'utf-8') as f:
    content = f.read()
# Inject controllers
controllers = """  final TextEditingController streetCtrl = TextEditingController(text: '123 Main Street');
  final TextEditingController cityCtrl = TextEditingController(text: 'San Diego');
  final TextEditingController zipCtrl = TextEditingController(text: '92101');
"""
content = content.replace("class _EditAddressScreenState extends State<EditAddressScreen> {\n", "class _EditAddressScreenState extends State<EditAddressScreen> {\n" + controllers)
with codecs.open('lib/screens/cart/edit_address_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed!")
