import re
with open('lib/widgets/cesc_commerce_app.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("fontFamily: 'Roboto',", "")
with open('lib/widgets/cesc_commerce_app.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed font')
