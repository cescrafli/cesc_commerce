import codecs, re

files = [
    'lib/screens/misc/onboarding_screen.dart',
    'lib/screens/cart/checkout_screen.dart',
    'lib/screens/cart/payment_screen.dart',
    'lib/screens/cart/add_new_card_screen.dart'
]
for file in files:
    with codecs.open(file, 'r', 'utf-8') as f:
        content = f.read()
    content = re.sub(r'child:\s*const\s*Row\(\s*mainAxisAlignment:\s*MainAxisAlignment\.spaceBetween,', 'child: Row(\n                        mainAxisAlignment: MainAxisAlignment.spaceBetween,', content)
    with codecs.open(file, 'w', 'utf-8') as f:
        f.write(content)
print("Done")
