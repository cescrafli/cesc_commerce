import codecs, re

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    content = f.read()

content = content.replace("{'price': _currentRangeValues, 'categories': _selectedCategories, 'brands': _selectedBrands, 'colors': _selectedColors}",
                          "{'price': _priceRange, 'categories': selectedCategories}")

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Filter variables fixed!")
