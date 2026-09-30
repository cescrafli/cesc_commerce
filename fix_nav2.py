import codecs, re

with codecs.open('lib/screens/home/main_navigation_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Restore the end of the class
content = content.replace(");\n      }\n    );\n  }\n}", ");\n  }\n}")

# Fix the end of the build method
# We look for:
#     );\n\n  }\n\n\n\n  Widget _buildNavItem
content = re.sub(
    r"    \);\n\n  \}\n\n\n\n  Widget _buildNavItem",
    "    );\n      }\n    );\n  }\n\n\n\n  Widget _buildNavItem",
    content
)

with codecs.open('lib/screens/home/main_navigation_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Nav fixed")
