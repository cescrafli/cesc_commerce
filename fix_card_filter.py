import codecs, re

# Fix ProductCard
with codecs.open('lib/widgets/product_card.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("final Map<String, dynamic> product;\n\n  const ProductCard({super.key, required this.product});",
                          "final Map<String, dynamic> product;\n  final String tag1;\n  final String tag2;\n  final String oldPrice;\n\n  const ProductCard({super.key, required this.product, this.tag1 = '', this.tag2 = '', this.oldPrice = ''});")

with codecs.open('lib/widgets/product_card.dart', 'w', 'utf-8') as f:
    f.write(content)

# Fix FilterBottomSheet
with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    fcontent = f.read()

# Replace _currentRangeValues with whatever variable holds the range values in FilterBottomSheet
# Let's find the correct variables:
# fcontent.find('RangeValues') -> what is the variable name?
