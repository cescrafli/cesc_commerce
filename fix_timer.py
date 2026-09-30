import codecs
with codecs.open('lib/widgets/promo_carousel.dart', 'r', 'utf-8') as f:
    content = f.read()

content = "import 'dart:async';\n" + content
with codecs.open('lib/widgets/promo_carousel.dart', 'w', 'utf-8') as f:
    f.write(content)
