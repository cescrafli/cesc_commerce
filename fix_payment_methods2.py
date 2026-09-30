import re

with open('lib/screens/misc/payment_methods_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_tile = '''    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200, width: 1.5)),
      child: Row('''
new_tile = '''    bool isSelected = _selectedMethod == methodId && methodId.isNotEmpty;
    return GestureDetector(
      onTap: () { if (methodId.isNotEmpty) setState(() => _selectedMethod = methodId); },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade200, width: isSelected ? 2 : 1.5)),
        child: Row('''
content = content.replace(old_tile, new_tile)

# Add closing bracket for GestureDetector
content = content.replace('''        ]
      )
    );
  }''', '''        ]
      )
      )
    );
  }''')

with open('lib/screens/misc/payment_methods_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed payment_methods_screen.dart 2')
