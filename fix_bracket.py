import codecs

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

# Line 137 is index 136 (if 0-based), let's check it
if ')' in lines[137]:
    lines[137] = ''

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'w', 'utf-8') as f:
    f.writelines(lines)
print("Bracket fixed!")
