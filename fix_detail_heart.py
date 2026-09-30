import codecs, re
with codecs.open('lib/screens/product/product_detail_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace heart icon with dynamic builder
old_heart = r"CircleAvatar\(backgroundColor: Colors\.black45, child: IconButton\(icon: const Icon\(Icons\.favorite_border, color: Colors\.white, size: 20\), onPressed: \(\) \{ ScaffoldMessenger\.of\(context\)\.showSnackBar\(const SnackBar\(content: Text\('Added to Wishlist!'\)\)\); \}\)\),"
new_heart = r"""ValueListenableBuilder(
  valueListenable: globalWishlist,
  builder: (context, List<Map<String, dynamic>> wishlist, child) {
    bool isFav = wishlist.any((item) => item['id'] == widget.product['id']);
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: IconButton(
        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey, size: 20),
        onPressed: () { toggleWishlistObj(widget.product, context); },
      ),
    );
  },
),"""

content = re.sub(old_heart, new_heart, content)

with codecs.open('lib/screens/product/product_detail_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Done")
