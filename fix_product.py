import re

with open('lib/screens/product/product_detail_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Fix Color label
content = content.replace("Text('COLOR: Moss Green', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))", "Text('COLOR: \', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))")
content = content.replace("final List<String> _colors = ['Moss Green', 'Navy Blue', 'Classic Black', 'Oatmeal'];", "final List<String> _colors = ['Moss Green', 'Navy Blue', 'Classic Black', 'Oatmeal'];")

# 2. Make Size Guide tappable
old_size_guide = "Row(children: [Icon(Icons.straighten, size: 16, color: Colors.grey), SizedBox(width: 5), Text('Size Guide', style: TextStyle(color: Colors.grey, fontSize: 13, decoration: TextDecoration.underline))])"
new_size_guide = '''GestureDetector(
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Size Guide'),
                              content: const Text('S: 36" Chest\\nM: 38" Chest\\nL: 40" Chest\\nXL: 42" Chest'),
                              actions: [TextButton(onTap: () => Navigator.pop(context), child: const Text('OK'))]
                            )
                          ),
                          child: const Row(children: [Icon(Icons.straighten, size: 16, color: Colors.grey), SizedBox(width: 5), Text('Size Guide', style: TextStyle(color: Colors.grey, fontSize: 13, decoration: TextDecoration.underline))]),
                        )'''
content = content.replace(old_size_guide, new_size_guide)

# 3. Fix Share button
old_share = '''                              IconButton(
                                icon: const Icon(Icons.share_outlined, color: Colors.black87),
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied to clipboard!')));
                                },
                              ),'''
new_share = '''                              IconButton(
                                icon: const Icon(Icons.share_outlined, color: Colors.black87),
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: 'Check out this product: \'));
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link copied to clipboard!')));
                                },
                              ),'''
content = content.replace(old_share, new_share)

# 4. Make chat bubble tappable
old_chat = '''                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                            child: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
                          ),'''
new_chat = '''                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSupportChatScreen())),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.chat_bubble_outline, color: Colors.black87),
                            ),
                          ),'''
content = content.replace(old_chat, new_chat)

# Add import for clipboard if needed
if 'package:flutter/services.dart' not in content:
    content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter/services.dart';")

with open('lib/screens/product/product_detail_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed product_detail_screen.dart')
