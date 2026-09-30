import codecs, re

with codecs.open('lib/screens/misc/onboarding_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("double total = 0.0;", "")
content = content.replace("double shipping = 0.0;", "")

with codecs.open('lib/screens/misc/onboarding_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
