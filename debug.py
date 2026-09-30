with open('lib/screens/auth/login_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace("Widget build(BuildContext context) {", "Widget build(BuildContext context) {\n    print('DEBUG LOGIN EMAIL: ' + tr('email'));")
with open('lib/screens/auth/login_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print("Done")
