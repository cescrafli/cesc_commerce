import re

with open('lib/screens/product/write_review_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_svc = "import 'package:cesc_commerce/core/services/product_service.dart';\n"
if 'product_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_svc)

old_press = '''onPressed: () => Navigator.pop(context),'''
new_press = '''onPressed: () async {
                            await ProductService().submitReview('prod_id', 5.0, 'Good!');
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Review Submitted! 50 Points Earned!')));
                              Navigator.pop(context);
                            }
                          },'''

content = content.replace(old_press, new_press, 1)

with open('lib/screens/product/write_review_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed review')
