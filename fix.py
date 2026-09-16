with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

count = content.count("'$15.00'")
print(f"Found {count} occurrences of '$15.00'")

content = content.replace("'$15.00'", r"'\$15.00'")

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
