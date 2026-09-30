import re

with open('lib/screens/misc/payment_methods_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace _buildMethodTile signature
old_sig = 'Widget _buildMethodTile(Widget iconWidget, String title, Widget? titleBadge, String subtitle, Widget trailingWidget) {'
new_sig = 'Widget _buildMethodTile(Widget iconWidget, String title, Widget? titleBadge, String subtitle, Widget trailingWidget, {String methodId = ""}) {'
content = content.replace(old_sig, new_sig)

# Make it tappable
old_body = '''    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row('''
new_body = '''    bool isSelected = _selectedMethod == methodId && methodId.isNotEmpty;
    return GestureDetector(
      onTap: () { if (methodId.isNotEmpty) setState(() => _selectedMethod = methodId); },
      child: Container(
        color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.05) : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row('''
content = content.replace(old_body, new_body)

# Add closing bracket for GestureDetector
content = content.replace('''           trailingWidget,
        ]
      )
    );
  }''', '''           trailingWidget,
        ]
      )
      )
    );
  }''')

# Update calls to include methodId
content = content.replace("_buildMethodTile(\n                Container(padding", "_buildMethodTile(\n                Container(padding") # just a marker

# It's easier to just match by title text and add methodId parameter to the call.
# Call 1: Mastercard
content = content.replace("style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis)),", "style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis)),")

with open('lib/screens/misc/payment_methods_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed payment_methods_screen.dart 3')
