import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"const SizedBox\(height: 80\),\s*\]\,\s*\),\s*\),\s*\),\s*\);\s*\}\s*\}\s*class ProfileScreen"
replacement = '''const SizedBox(height: 80),
            ],
          ),
        );
          }
        ),
      ),
    );
  }
}
class ProfileScreen'''

if re.search(pattern, content):
    content = re.sub(pattern, replacement, content)
    with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
        f.write(content)
    print("Fixed brackets!")
else:
    print("Pattern not found!")
