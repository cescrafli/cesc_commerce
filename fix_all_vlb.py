import codecs, re

files = [
    'lib/screens/home/search_screen.dart',
    'lib/screens/product/category_list_screen.dart',
    'lib/screens/product/product_detail_screen.dart',
    'lib/screens/profile/help_support_screen.dart',
    'lib/screens/profile/notification_screen.dart',
    'lib/screens/profile/notifications_screen.dart',
    'lib/screens/profile/settings_screen.dart',
]

for path in files:
    with open(path, 'rb') as f:
        raw = f.read()
    
    # Convert to string keeping original bytes for pattern matching
    content = raw.decode('utf-8')
    
    # Fix opening: change arrow to block
    old_open = '      builder: (context, _, __) {\n        return Scaffold(\n'
    
    if old_open not in content:
        # Still needs fixing
        for variant in [
            '      builder: (context, _, __) => Scaffold(\r\n',
            '      builder: (context, _, __) => Scaffold(\n',
        ]:
            if variant in content:
                content = content.replace(variant, '      builder: (context, _, __) {\n        return Scaffold(\n', 1)
                break
    
    # Fix closing: find `      );\r\n    );\r\n` or similar and replace with `        );\n      }\n    );\n`
    # Use bytes-level search for the CRLF mixed endings
    close_patterns = [
        ('      );\r\n    );\r\n', '        );\n      }\n    );\n'),
        ('      );\n    );\n',     '        );\n      }\n    );\n'),
        ('    );\r\n    );\r\n',   '        );\n      }\n    );\n'),
    ]
    
    fixed_close = False
    for old_close, new_close in close_patterns:
        if old_close in content:
            # Replace LAST occurrence
            idx = content.rfind(old_close)
            content = content[:idx] + new_close + content[idx + len(old_close):]
            fixed_close = True
            print(f"FIXED close: {path}")
            break
    
    if not fixed_close:
        print(f"CLOSE NOT FOUND: {path}")
        # Print last 200 chars to debug
        print(repr(content[-200:]))
    
    with open(path, 'w', encoding='utf-8', newline='') as f:
        f.write(content)

print("Done")
