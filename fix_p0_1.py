import re

# 1. Update product_card.dart
with open('lib/widgets/product_card.dart', 'r', encoding='utf-8') as f:
    pc_content = f.read()

# Replace toggleWishlist
pc_content = pc_content.replace(
    '''onTap: () { toggleWishlist(product['title'], product['subtitle'], '\{product['price'].toStringAsFixed(2)}', product['image'], context); },''',
    '''onTap: () { toggleWishlistObj(product, context); },'''
)

# Replace addToCart
pc_content = pc_content.replace(
    '''onTap: () { addToCart(product['title'], product['subtitle'], '\{product['price'].toStringAsFixed(2)}', product['image'], context); },''',
    '''onTap: () { addToCartObj(product, 1, 'M', 'Default', context); },'''
)

with open('lib/widgets/product_card.dart', 'w', encoding='utf-8') as f:
    f.write(pc_content)

# 2. Remove legacy functions from globals.dart
with open('lib/core/globals.dart', 'r', encoding='utf-8') as f:
    gb_content = f.read()

def remove_function(content, func_name):
    start = content.find(func_name)
    if start != -1:
        # Find the matching closing brace
        brace_count = 0
        in_string = False
        escape = False
        end = -1
        for i in range(start, len(content)):
            char = content[i]
            if escape:
                escape = False
                continue
            if char == '\\\\':
                escape = True
                continue
            if char in [\"'\", '\"']:
                if not in_string:
                    in_string = char
                elif in_string == char:
                    in_string = False
                continue
            if not in_string:
                if char == '{':
                    brace_count += 1
                elif char == '}':
                    brace_count -= 1
                    if brace_count == 0:
                        end = i + 1
                        break
        if end != -1:
            return content[:start] + content[end:]
    return content

gb_content = remove_function(gb_content, 'void addToCart(')
gb_content = remove_function(gb_content, 'void toggleWishlist(')

with open('lib/core/globals.dart', 'w', encoding='utf-8') as f:
    f.write(gb_content)

print('P0-1 fixed')
