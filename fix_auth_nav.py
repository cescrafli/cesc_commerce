import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix Login Screen pushReplacement
content = content.replace(
    "Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));",
    "Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()), (route) => false);"
)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
