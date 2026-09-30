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

    # The current broken pattern:
    # return ValueListenableBuilder<String>(
    #   valueListenable: globalLanguage,
    #   builder: (context, _, __) => Scaffold(
    #   backgroundColor: ...   <-- WRONG: same indent as builder props
    #   ...
    #   );    <-- closes Scaffold?
    # );      <-- closes VLB

    # Fix: change to `builder: (context, _, __) { return Scaffold(` 
    # and find the Scaffold close ); and change to `); }` and then `)` for VLB
    
    # Step 1: fix the opening
    old_open = '      builder: (context, _, __) => Scaffold(\r\n'
    new_open = '      builder: (context, _, __) {\n        return Scaffold(\n'
    
    if old_open not in content:
        old_open = '      builder: (context, _, __) => Scaffold(\n'
        new_open = '      builder: (context, _, __) {\n        return Scaffold(\n'
    
    if old_open not in content:
        print(f"OPEN NOT FOUND: {path}")
        continue
    
    content = content.replace(old_open, new_open, 1)
    
    # Step 2: Find the Scaffold closing `      );` or `    );` followed by `    );` (VLB close)
    # and change `      );\n    );` to `        );\n      }\n    );`
    
    # Pattern: the Scaffold closes, then VLB closes
    # We need to find: `\n      );\n    );\n` and replace with `\n        );\n      }\n    );\n`
    for close_pat, new_close in [
        ('\n      );\n    );\n', '\n        );\n      }\n    );\n'),
        ('\n    );\n    );\n', '\n        );\n      }\n    );\n'),
    ]:
        if close_pat in content:
            # Replace only the LAST occurrence (which is the build method close)
            idx = content.rfind(close_pat)
            content = content[:idx] + new_close + content[idx + len(close_pat):]
            print(f"FIXED: {path}")
            break
    else:
        print(f"CLOSE NOT FOUND: {path}")
        continue
    
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)

print("All done")
