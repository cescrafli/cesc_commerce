import codecs, re, os

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

def find_build_scaffold_close(content):
    """
    After wrapping `return Scaffold(` in the build method with ValueListenableBuilder,
    we need to find where the Scaffold closes within the build method.
    Strategy: find the `  Widget build(BuildContext context) {` block,
    then count brackets from `return ValueListenableBuilder` to find matching close.
    """
    # Find the build method
    build_start = content.find('  Widget build(BuildContext context)')
    if build_start == -1:
        build_start = content.find('@override\n\n  Widget build(BuildContext context)')
    if build_start == -1:
        return None
    
    # Find the VLB open inside build
    vlb_start = content.find('return ValueListenableBuilder<String>(', build_start)
    if vlb_start == -1:
        return None
    
    # Find what comes right after the builder arrow: `=> Scaffold(`
    scaffold_open = content.find('=> Scaffold(\n', vlb_start)
    if scaffold_open == -1:
        scaffold_open = content.find('=> Scaffold(\r\n', vlb_start)
    if scaffold_open == -1:
        return None
    
    # Count braces/parens from scaffold_open to find matching close
    pos = scaffold_open + len('=> Scaffold(\n')
    depth = 1
    while pos < len(content) and depth > 0:
        ch = content[pos]
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        pos += 1
    
    if depth == 0:
        return pos - 1  # position of the closing ) of Scaffold
    return None

for path in missing:
    if not os.path.exists(path):
        continue
    
    with codecs.open(path, 'r', 'utf-8') as f:
        content = f.read()
    
    if 'ValueListenableBuilder<String>' not in content:
        print(f"NO VLB: {path}")
        continue
    
    # Find where Scaffold closes and insert ); after it
    close_pos = find_build_scaffold_close(content)
    if close_pos is None:
        print(f"CANT FIND CLOSE: {path}")
        continue
    
    # Check what's already there at close_pos
    context_around = content[close_pos-2:close_pos+10]
    
    # We need to insert ";\n    )" after the Scaffold's closing `)`
    # The existing close looks like ");  \n  }\n"
    # After the scaffold close ), there should already be a ;
    # We need one more ); for the ValueListenableBuilder
    
    # Find the ); after close_pos
    semi_pos = content.find(';', close_pos)
    if semi_pos == -1 or semi_pos > close_pos + 5:
        print(f"NO SEMI: {path} at {close_pos}")
        continue
    
    # Insert "\n    )" before the ";" if not already there
    # Check if it already says );\n    ); 
    after_close = content[close_pos:close_pos+20]
    if ');\n    );' in after_close or ');\r\n      );' in after_close:
        print(f"ALREADY CLOSED: {path}")
        continue
    
    # Insert the VLB closing ) after the Scaffold );
    # Find the newline after the semi
    nl_pos = content.find('\n', semi_pos)
    if nl_pos == -1:
        nl_pos = semi_pos + 1
    
    # Insert "    );" on the next line
    content = content[:nl_pos + 1] + '    );\n' + content[nl_pos + 1:]
    
    with codecs.open(path, 'w', 'utf-8') as f:
        f.write(content)
    print(f"FIXED: {path}")

print("All done")
