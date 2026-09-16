import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Wrap the Column in PromoCarousel with SingleChildScrollView
pattern = r"(child: Column\(\s*crossAxisAlignment: CrossAxisAlignment\.start,\s*mainAxisAlignment: MainAxisAlignment\.center,\s*children: \[)"
replacement = r"child: SingleChildScrollView(\n                    physics: const NeverScrollableScrollPhysics(),\n                    \1"

content = re.sub(pattern, replacement, content)

# we need to close the SingleChildScrollView properly
# The column ends before the closing brackets of the Container:
#                         ],
#                       ),
#                     )
#                   ],
#                 ),
#               ),
#             );
# Wait, let's just use string replacement on the exact Column block end.

pattern2 = r"(Icon\(Icons\.arrow_forward_ios, color: Colors\.white, size: 12\),\s*\]\s*\)\s*\]\s*\)\s*\]\s*\),\s*\),\s*\)\s*\]\s*\),\s*\),\s*\]\s*\),\s*\),\s*);\s*\}\s*\),\s*\),\s*\);)"

# Actually, a simpler way is to just add SingleChildScrollView and rely on the fact that I can match the end of the Column easily, or I just use python to find the matching bracket.
