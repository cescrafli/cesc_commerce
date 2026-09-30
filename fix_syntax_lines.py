import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

for i in range(len(lines)):
    if "const SizedBox(height: 100)," in lines[i]:
        # Check next few lines for dangling parenthesis
        for j in range(1, 3):
            if i + j < len(lines) and lines[i+j].strip() == ")":
                lines[i+j] = "" # Remove it!

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(lines)

print("Syntax fixed by lines!")
