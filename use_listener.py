import codecs, re

# For these complex StatefulWidget screens, instead of wrapping Scaffold in VLB,
# we use addListener/removeListener in initState/dispose to call setState.
# This is simpler, cleaner, and doesn't break bracket structure.

complex_screens = [
    'lib/screens/product/product_detail_screen.dart',
    'lib/screens/profile/help_support_screen.dart',
    'lib/screens/profile/notifications_screen.dart',
    'lib/screens/profile/settings_screen.dart',
]

simple_screens = [
    'lib/screens/home/search_screen.dart',
    'lib/screens/product/category_list_screen.dart',
    'lib/screens/profile/my_orders_screen.dart',
    'lib/screens/profile/notification_screen.dart',
]

def add_listener_approach(path):
    """Undo the VLB wrapper and instead add setState listener in initState."""
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    
    if 'ValueListenableBuilder<String>' not in content:
        print(f"NO VLB to undo: {path}")
        return
    
    # Step 1: Undo the return VLB wrapper - change back to return Scaffold
    content = content.replace(
        '    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) {\n        return Scaffold(\n',
        '    return Scaffold(\n'
    )
    
    # Step 2: Remove the extra `      }\n    );\n` that closes the VLB block
    # Find and remove: ^\s*}\n\s*\);\n before the end of build method
    # We look for the VLB close right before `  }` (end of build)
    content = re.sub(r'\n      \}\n    \);\n(\n  \})', r'\n\1', content)
    content = re.sub(r'\n        \}\n    \);\n(\n  \})', r'\n\1', content)
    
    # Step 3: Add listener in initState / add initState if missing
    # Find the State class
    state_class_match = re.search(r'class _\w+State extends (State|ConsumerState)<\w+> \{', content)
    if not state_class_match:
        print(f"NO STATE CLASS: {path}")
        return
    
    # Check if initState already exists
    if 'void initState()' in content:
        # Add listener inside existing initState after super.initState()
        content = content.replace(
            'super.initState();',
            'super.initState();\n    globalLanguage.addListener(_onLangChange);'
        )
    else:
        # Add initState after the state class opening
        insert_after = state_class_match.group(0)
        init_code = '\n\n  @override\n  void initState() {\n    super.initState();\n    globalLanguage.addListener(_onLangChange);\n  }'
        content = content.replace(insert_after, insert_after + init_code, 1)
    
    # Add dispose if not exists
    if 'void dispose()' not in content:
        # Insert before last `}` (class close)
        dispose_code = '\n\n  @override\n  void dispose() {\n    globalLanguage.removeListener(_onLangChange);\n    super.dispose();\n  }\n\n  void _onLangChange() => setState(() {});\n'
        # Find the last class close
        last_close = content.rfind('\n}')
        if last_close != -1:
            content = content[:last_close] + dispose_code + content[last_close:]
    else:
        # Add removeListener in existing dispose and add the listener method
        content = content.replace(
            'super.dispose();',
            'globalLanguage.removeListener(_onLangChange);\n    super.dispose();'
        )
        if '_onLangChange' not in content:
            last_close = content.rfind('\n}')
            content = content[:last_close] + '\n\n  void _onLangChange() => setState(() {});\n' + content[last_close:]
    
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)
    print(f"LISTENER ADDED: {path}")

for path in complex_screens:
    add_listener_approach(path)

print("Done complex screens")
