import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("child: const Center(", "child: Center(")

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Const fixed 2")
