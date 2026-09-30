# coding=utf-8
import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

for i in range(len(lines)):
    if "Confirm Security Code" in lines[i]:
        # We wrap the text in Expanded to avoid overflow!
        lines[i] = "                      Expanded(child: Text('Confirm Security Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87), overflow: TextOverflow.ellipsis)),\n"
    if "Container(padding: const EdgeInsets.symmetric" in lines[i] and "border: Border.all" in lines[i] and "Text('" in lines[i]:
        # Replace the broken Container line
        lines[i] = "                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),\n"

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(lines)

print("Line replaced!")
