import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# We look for the exact line: child: Column(
# inside _PromoCarouselState
# We can replace it with child: SingleChildScrollView(child: Column(
# But we need to add the closing bracket.
# Let's just find the entire file, and replace:
#                   child: Column(
#                     crossAxisAlignment: CrossAxisAlignment.start,
#                     mainAxisAlignment: MainAxisAlignment.center,
#                     children: [
# with:
#                   child: SingleChildScrollView(
#                     physics: const NeverScrollableScrollPhysics(),
#                     child: Column(
#                       crossAxisAlignment: CrossAxisAlignment.start,
#                       mainAxisAlignment: MainAxisAlignment.center,
#                       children: [
pattern1 = '''                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['''
replacement1 = '''                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: ['''

# We need to add the closing bracket for SingleChildScrollView.
# The end of the Column looks like:
#                           ),
#                         ],
#                       )
#                     ],
#                   ),
#                 ),
pattern2 = '''                          ),
                        ],
                      )
                    ],
                  ),'''
replacement2 = '''                          ),
                        ],
                      )
                    ],
                  ),
                ),'''

if pattern1 in content and pattern2 in content:
    content = content.replace(pattern1, replacement1, 1)
    content = content.replace(pattern2, replacement2, 1)
    print("Replaced column with SingleChildScrollView!")
else:
    print("Could not find patterns.")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
