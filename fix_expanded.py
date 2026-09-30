import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

bad_code = '''                  const Row(
                    children: [
                      Icon(Icons.lock_outline, color: Color(0xFF0F8A9E), size: 16),
                      SizedBox(width: 8),
                      Expanded(child: Text('Confirm Security Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), overflow: TextOverflow.ellipsis)),
                    ],
                  ),'''

good_code = '''                  Expanded(
                    child: Row(
                      children: [
                        const Icon(Icons.lock_outline, color: Color(0xFF0F8A9E), size: 16),
                        const SizedBox(width: 8),
                        const Expanded(child: Text('Confirm Security Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                  ),'''

content = content.replace(bad_code, good_code)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed Expanded!")
