import re

with open('lib/screens/misc/payment_methods_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# For Mastercard
content = content.replace("'''8831", "'''8831") # this isn't in payment_methods_screen either?
# Let's just find the calls
content = re.sub(r"(_buildMethodTile\([\s\S]*?'Mastercard'[\s\S]*?)(,\n              \))", r"\1,\n                methodId: 'Mastercard'\2", content)
content = re.sub(r"(_buildMethodTile\([\s\S]*?'Visa'[\s\S]*?)(,\n              \))", r"\1,\n                methodId: 'Visa'\2", content)
content = re.sub(r"(_buildMethodTile\([\s\S]*?'Apple Pay'[\s\S]*?)(,\n              \))", r"\1,\n                methodId: 'ApplePay'\2", content)
content = re.sub(r"(_buildMethodTile\([\s\S]*?'PayPal'[\s\S]*?)(,\n              \))", r"\1,\n                methodId: 'PayPal'\2", content)

with open('lib/screens/misc/payment_methods_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Added methodIds')
