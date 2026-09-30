import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace for SignUpScreen: 
# const SizedBox(height: 20),
#               ],
#             ),
#           ),
#         ),
content = re.sub(
    r"const SizedBox\(height: 20\);\s*],\s*\),\s*\),\s*\),\s*\),\s*\);\s*}\s*}",
    "const SizedBox(height: 80),\n              ],\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}",
    content
)

# Replace for LoginScreen:
# 256-bit Secure Encryption ...
#               ],
#             ),
content = re.sub(
    r"Text\('256-bit Secure Encryption [^;]+;\s*],\s*\)\s*],\s*\),\s*\),\s*\),\s*\),\s*\);\s*}\s*}",
    "Text('256-bit Secure Encryption — Protected by Cescrafli', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),\n                  ],\n                ),\n                const SizedBox(height: 80),\n              ],\n            ),\n          ),\n        ),\n      ),\n    );\n  }\n}",
    content
)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Regex replaced!")
