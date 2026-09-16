with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("'\.00'", "'\.00'") # in case it was already escaped but I want to ensure
content = content.replace("'.00'", r"'\.00'")
content = content.replace("'\.00'", r"'\.00'") # catch any remaining \.00

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
