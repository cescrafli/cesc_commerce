import codecs
with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    c = f.read()

c = c.replace(r"\${total", r"\$${total")
c = c.replace(r"\${subtotal", r"\$${subtotal")
c = c.replace(r"\${shipping", r"\$${shipping")
c = c.replace(r"\${discount", r"\$${discount")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(c)

print("Fixed dollars again!")
