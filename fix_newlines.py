import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace the literal newlines back to \n
broken_string1 = "'Summer Collection\nDiscount'"
fixed_string1 = "'Summer Collection Discount'"

broken_string2 = "'Urban Fashion\nArrivals'"
fixed_string2 = "'Urban Fashion Arrivals'"

broken_string3 = "'Premium Winter\nCoats'"
fixed_string3 = "'Premium Winter Coats'"

content = content.replace(broken_string1, fixed_string1)
content = content.replace(broken_string2, fixed_string2)
content = content.replace(broken_string3, fixed_string3)

# And fix the replaceAll string too
broken_replace = "replaceAll('\n', ' ')"
fixed_replace = "replaceAll(' ', ' ')"
content = content.replace(broken_replace, fixed_replace)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
