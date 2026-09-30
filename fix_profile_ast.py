import codecs, re

with codecs.open('lib/screens/profile/profile_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# First, undo the bad closing at the very end
if "    );\n      }\n    );\n  }\n}" in content:
    content = content.replace("    );\n      }\n    );\n  }\n}", "  }\n}")

# Now properly close ValueListenableBuilder BEFORE _buildMenuTile
if "    );\n      }\n    );\n  }\n\n\n\n  Widget _buildMenuTile" not in content:
    content = re.sub(
        r"    \);\n\n  \}\n\n\n\n  Widget _buildMenuTile",
        "    );\n      }\n    );\n  }\n\n\n\n  Widget _buildMenuTile",
        content
    )

content = content.replace("'Log Out'", "tr('logout')")

with codecs.open('lib/screens/profile/profile_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Profile AST fixed")
