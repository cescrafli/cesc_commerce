import re

with open('lib/screens/cart/payment_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Make Use Selected Method return data
content = content.replace("Navigator.pop(context)", "Navigator.pop(context, selectedMethod)")

# Fix Add button
content = content.replace('''              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              )''', '''              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add Payment Method coming soon'))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                ),
              )''')

with open('lib/screens/cart/payment_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed payment_screen.dart')
