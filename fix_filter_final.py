import codecs

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    content = f.read()

# Let's find the Row containing "Reset" and "Apply Filter"
start_str = "Row(\n\nchildren: [\n\nText('Reset'"
end_str = "]\n\n)\n\n)\n\n)"
if start_str in content:
    start_idx = content.find(start_str)
    # the end of the file is near... let's just find "    return Container("
    # Actually, I'll just rewrite the whole file from start_str to the end of the method
    # It's at the end of build method!
