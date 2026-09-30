import codecs, re

files = [
    'lib/screens/home/search_screen.dart',
    'lib/screens/product/category_list_screen.dart',
    'lib/screens/product/product_detail_screen.dart',
    'lib/screens/profile/help_support_screen.dart',
    'lib/screens/profile/my_orders_screen.dart',
    'lib/screens/profile/notification_screen.dart',
    'lib/screens/profile/notifications_screen.dart',
    'lib/screens/profile/settings_screen.dart',
]

for path in files:
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    
    # The problem: we have triple closing: );\n    );\n    );\n  }\n
    # We need only: );\n    );\n  }\n
    # Pattern 1: CRLF files
    bad1 = '      );\r\n    );\n    );\r\n'
    good1 = '      );\r\n    );\r\n'
    
    # Pattern 2: the script added `    );\n` after `    );\r\n`
    # So we have:  `    );\r\n    );\n    );\r\n` -> remove the middle one
    # Or simpler: find 3 consecutive close lines and reduce to 2
    
    # Remove the extra `    );\n` that was added between two `    );\r\n` lines
    content = re.sub(r'(\s+\);\r?\n)\s+\);\n(\s+\);\r?\n)', r'\1\2', content)
    
    # Also handle: );\n    );\n    );\n pattern (all LF)
    content = re.sub(r'(\s+\);\n)\s+\);\n(\s+\);\n)', r'\1\2', content)
    
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)
    print(f"Fixed: {path}")

print("All done")
