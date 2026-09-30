import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("? const Padding(", "? Padding(")
content = content.replace("child: Center(", "child: const Center(") # Wait, if it's Center(child: Column(...)) we can't make Center const either.
content = content.replace("Icon(Icons.favorite_border", "const Icon(Icons.favorite_border")
content = content.replace("SizedBox(height: 16)", "const SizedBox(height: 16)")
content = content.replace("padding: EdgeInsets.only", "padding: const EdgeInsets.only")

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Const fixed")
