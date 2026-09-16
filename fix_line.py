import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

# The error is at line 6056 (1-indexed), which is index 6055.
if lines[6055].strip() == '}':
    lines.pop(6055)
    print("Deleted the extra '}' at line 6056.")
elif lines[6054].strip() == '}':
    lines.pop(6054)
    print("Deleted the extra '}' at line 6055.")
elif lines[6056].strip() == '}':
    lines.pop(6056)
    print("Deleted the extra '}' at line 6057.")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(lines)
