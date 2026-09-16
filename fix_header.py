import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

def replace_back_button(screen_name):
    global content
    pattern = r"(GestureDetector\(\s*onTap: \(\) \{ if \(Navigator\.canPop\(context\)\) Navigator\.pop\(context\); \},\s*child: Container\(\s*padding: const EdgeInsets\.all\(10\),\s*decoration: BoxDecoration\(color: Colors\.white, shape: BoxShape\.circle, border: Border\.all\(color: Colors\.grey\.shade200\)\),\s*child: const Icon\(Icons\.arrow_back_ios_new, size: 18\),\s*\),\s*\),)"
    
    # We want to wrap it in a Visibility widget: 
    # if (Navigator.canPop(context)) ... else const SizedBox(width: 40)
    # Actually, we can just replace the specific screens' back buttons.
    pass

# We will just write a regex for the exact back button pattern and replace it with:
# Navigator.canPop(context) ? [The GestureDetector] : const SizedBox(width: 40),

pattern = r"GestureDetector\(\s*onTap: \(\) \{ if \(Navigator\.canPop\(context\)\) Navigator\.pop\(context\); \},\s*child: Container\(\s*padding: const EdgeInsets\.all\(10\),\s*decoration: BoxDecoration\(color: Colors\.white, shape: BoxShape\.circle, border: Border\.all\(color: Colors\.grey\.shade200\)\),\s*child: const Icon\(Icons\.arrow_back_ios_new, size: 18\),\s*\),\s*\),"

replacement = '''Navigator.canPop(context) 
                    ? GestureDetector(
                        onTap: () { if (Navigator.canPop(context)) Navigator.pop(context); },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                          child: const Icon(Icons.arrow_back_ios_new, size: 18),
                        ),
                      )
                    : const SizedBox(width: 40),'''

content = re.sub(pattern, replacement, content)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Applied smart back buttons")
