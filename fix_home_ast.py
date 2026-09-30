import codecs, re

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

content = "".join(lines)

# Fix missing closing bracket for ValueListenableBuilder inside HomeScreen
# We know HomeScreen class ends with `}`.
# And build method should end with:
#           ),
#         ),
#       ),
#     );
#   }
# }

# We replace the end of the file with the proper closings.
new_end = """
            ],
          ),
        ),
      ),
    );
      }
    );
  }
}
"""

content = re.sub(r"            \],\s*\),\s*\),\s*\),\s*\);\s*\}\s*\}", new_end, content)

# Check if `Text(tr` has `const`
content = content.replace("const Text(tr", "Text(tr")

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Home fixed")
