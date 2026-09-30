import codecs, re

# MAIN NAV
with codecs.open('lib/screens/home/main_navigation_screen.dart', 'r', 'utf-8') as f:
    nav_lines = f.readlines()

nav_content = "".join(nav_lines)

# First, undo the bad closing at the end of nav
if ");\n      }\n    );\n  }\n}" in nav_content:
    nav_content = nav_content.replace(");\n      }\n    );\n  }\n}", ");\n  }\n}")
elif "      }\n    );\n  }\n}" in nav_content:
    # Some variant
    nav_content = re.sub(r"      \}\n    \);\n  \}\n\}", "  }\n}", nav_content)

# Now inject the closing for ValueListenableBuilder BEFORE _buildNavItem
if "    );\n      }\n    );\n  }\n\n\n\n  Widget _buildNavItem" not in nav_content:
    nav_content = re.sub(
        r"    \);\n\n  \}\n+  Widget _buildNavItem",
        "    );\n      }\n    );\n  }\n\n  Widget _buildNavItem",
        nav_content
    )

with codecs.open('lib/screens/home/main_navigation_screen.dart', 'w', 'utf-8') as f:
    f.write(nav_content)

# HOME
with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    home_lines = f.readlines()
home_content = "".join(home_lines)

# Undo bad closing at end of home
home_content = re.sub(r"    \);\n      \}\n    \);\n  \}\n\}", "    );\n  }\n}", home_content)

# Remove `const` before `Text(tr(...))`
home_content = home_content.replace("const Text(tr('categories')", "Text(tr('categories')")
home_content = home_content.replace("const Text(tr('popular_deals')", "Text(tr('popular_deals')")
home_content = home_content.replace("const Text(tr('new_arrivals')", "Text(tr('new_arrivals')")

# Add the correct closing for ValueListenableBuilder in HomeScreen
# Scaffold closes around line 311. 
if "    );\n      }\n    );\n  }\n\n}" not in home_content:
    home_content = re.sub(
        r"    \);\n\n  \}\n\n\}",
        "    );\n      }\n    );\n  }\n}",
        home_content
    )

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(home_content)

print("Fixed")
