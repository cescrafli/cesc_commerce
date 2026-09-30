import codecs, re

with codecs.open('lib/screens/home/home_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("'Search clothes, collections...'", "tr('search_hint')")
# Wait, did I miss "New Arrivals" because there was no text for it?
# Let's add a Text widget for New Arrivals above the grid!
# It should be around:
#           // 6. Product Grid
#           Padding(
#             padding: const EdgeInsets.symmetric(horizontal: 20),

new_arrivals_header = """
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(tr('new_arrivals'), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              // 6. Product Grid
"""

if "Text(tr('new_arrivals')" not in content:
    content = content.replace("              // 6. Product Grid", new_arrivals_header)

with codecs.open('lib/screens/home/home_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Home fixed")
