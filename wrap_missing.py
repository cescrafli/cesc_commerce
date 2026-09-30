import codecs, re, os

# Screens that have tr() but are missing ValueListenableBuilder
missing = [
    'lib/screens/home/search_screen.dart',
    'lib/screens/product/category_list_screen.dart',
    'lib/screens/product/product_detail_screen.dart',
    'lib/screens/profile/help_support_screen.dart',
    'lib/screens/profile/my_orders_screen.dart',
    'lib/screens/profile/notification_screen.dart',
    'lib/screens/profile/notifications_screen.dart',
    'lib/screens/profile/settings_screen.dart',
]

def wrap_scaffold(content):
    """
    Finds the first `return Scaffold(` or `return SafeArea(` in the build method
    and wraps it with ValueListenableBuilder<String>.
    Also ensures the file has globalLanguage accessible.
    """
    # Pattern: return Scaffold( 
    # Replace with: return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) => Scaffold(
    
    # Try `return Scaffold(` first
    for return_stmt in ['    return Scaffold(', '    return SafeArea(']:
        if return_stmt in content:
            content = content.replace(
                return_stmt,
                '    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) => ' + return_stmt.strip() + '\n      (',
                1  # only first occurrence
            )
            # That created a duplicate ( - undo last part
            content = content.replace(
                'valueListenableBuilder,\n      builder: (context, _, __) => Scaffold(\n      (',
                'valueListenableBuilder,\n      builder: (context, _, __) => Scaffold('
            )
            break
    return content

for path in missing:
    if not os.path.exists(path):
        print(f"MISSING FILE: {path}")
        continue
    
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    
    if 'ValueListenableBuilder<String>' in content:
        print(f"SKIP (already has): {path}")
        continue
    
    # Simple replacement: find return Scaffold( and wrap it
    # Find the line that says `return Scaffold(` in the build method
    # We use a careful replacement looking at indentation
    patterns = [
        ('    return Scaffold(\r\n', '    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) => Scaffold(\r\n'),
        ('    return Scaffold(\n', '    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) => Scaffold(\n'),
    ]
    
    wrapped = False
    for old, new in patterns:
        if old in content:
            content = content.replace(old, new, 1)
            wrapped = True
            break
    
    if not wrapped:
        print(f"NO MATCH: {path}")
        continue
    
    # Now find the closing of the build method and add the extra )
    # The build method typically ends with:
    # "    );\n  }\n"  (or similar with \r\n)
    # We need to close the ValueListenableBuilder: one extra ); before the last );
    # Find last occurrence of `    );\n  }\n` or `    );\r\n  }\r\n`
    
    # Find the last build method close pattern
    # We look for "    );" followed by optional whitespace/newlines and "  }" and "}"
    # Strategy: find the LAST "    );" in the build area
    
    # Simple approach: find the pattern "    );\n\n  }\n\n}" or similar
    # Replace last `    );` before `  }` with `      );\n    );`
    
    # Use regex to find last build close
    # The build ends with something like:
    #   );   <-- closes Scaffold
    #   }    <-- closes build method
    # }      <-- closes class
    
    for close_pattern in [
        ('    );\r\n\r\n  }\r\n\r\n}', '      );\r\n    );\r\n\r\n  }\r\n\r\n}'),
        ('    );\n\n  }\n\n}', '      );\n    );\n\n  }\n\n}'),
        ('    );\r\n  }\r\n}', '      );\r\n    );\r\n  }\r\n}'),
        ('    );\n  }\n}', '      );\n    );\n  }\n}'),
    ]:
        old_close, new_close = close_pattern
        if old_close in content:
            # Replace the LAST occurrence
            last_idx = content.rfind(old_close)
            content = content[:last_idx] + new_close + content[last_idx + len(old_close):]
            print(f"WRAPPED: {path}")
            break
    else:
        print(f"WRAP OK but no close found: {path}")
    
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)

print("Done")
