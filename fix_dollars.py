import codecs
with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    c = f.read()

c = c.replace("{total", "${total")
c = c.replace("{subtotal", "${subtotal")
c = c.replace("{shipping", "${shipping")
c = c.replace("{discount", "${discount")
c = c.replace(r"\\$", r"\$")
c = c.replace(r"\\\$", r"\$")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(c)

print("Fixed dollars!")
