import codecs, re

with codecs.open('lib/screens/auth/sign_up_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Wrap return Scaffold with ValueListenableBuilder
content = content.replace(
    'Widget build(BuildContext context) {\r\n\r\n\r\n\r\n    return Scaffold(',
    'Widget build(BuildContext context) {\n    return ValueListenableBuilder<String>(\n      valueListenable: globalLanguage,\n      builder: (context, _, __) => Scaffold('
)

# Find the last ); in the build method and add closing paren
# The file ends with    );\n  }\n}\n  - we want    );\n    );\n  }\n}
# Find "); \n  }\n}" pattern - last closing
content = content.rstrip()
# It likely ends with:  ); \n\n  }\n\n}\n  - close the Scaffold, add )
if content.endswith('\n}'):
    # Find "  }\n\n}" and replace last occurrence
    last_close = content.rfind('\n}')
    second_last = content.rfind('\n}', 0, last_close)
    # Insert ");  " before the last "}"
    content = content[:last_close] + '\n    );\n' + content[last_close:]

content += '\n'

with codecs.open('lib/screens/auth/sign_up_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Done")
