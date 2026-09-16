import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

pattern = r"Stack\(\s*children: \[\s*Container\(padding: const EdgeInsets\.all\(10\), decoration: BoxDecoration\(color: Colors\.grey\.shade100, shape: BoxShape\.circle\), child: const Icon\(Icons\.notifications_none, size: 22, color: Colors\.black87\)\),\s*Positioned\(top: 10, right: 10, child: Container\(width: 8, height: 8, decoration: const BoxDecoration\(color: Colors\.red, shape: BoxShape\.circle\)\)\),\s*\]\,\s*\),"

replacement = '''GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You have no new notifications'), duration: Duration(seconds: 1)));
                          },
                          child: Stack(
                            children: [
                              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle), child: const Icon(Icons.notifications_none, size: 22, color: Colors.black87)),
                              Positioned(top: 10, right: 10, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
                            ],
                          ),
                        ),'''

if re.search(pattern, content):
    content = re.sub(pattern, replacement, content)
    with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
        f.write(content)
    print("Fixed notification bell")
else:
    print("Could not find notification bell pattern")
