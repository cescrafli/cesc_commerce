import codecs

with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    if 'addToCartObj(widget.product' in line and "}', widget.product['image']" in line:
        lines[i] = "                    for(int i=0; i<_qty; i++) { addToCartObj(widget.product, 1, _sizes[_selectedSizeIndex], _colors[_selectedColorIndex].toString(), context); }\n"

with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.writelines(lines)
print("ProductDetailScreen fixed")
