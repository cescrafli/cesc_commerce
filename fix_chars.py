# coding=utf-8
import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8', errors='ignore') as f:
    content = f.read()

# Fix Expires 08/27 ... Debit Card
content = re.sub(
    r"Expires 08/27 [^D]+ Debit Card", 
    "Expires 08/27 \u2022 Debit Card", 
    content
)

# Fix Expires 11/26 ... Credit Card
content = re.sub(
    r"Expires 11/26 [^C]+ Credit Card", 
    "Expires 11/26 \u2022 Credit Card", 
    content
)

# Fix Security Code bullets
content = re.sub(
    r"Text\('[^']+', style: TextStyle\(fontSize: 14, letterSpacing: 2, color: Colors\.black\)\)", 
    "Text('\u2022\u2022\u2022', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))", 
    content
)

# Wait, the overflow was caused by the row not fitting in the screen.
# "A RenderFlex overflowed by 118 pixels on the right."
# In the code:
# Row(
#   mainAxisAlignment: MainAxisAlignment.spaceBetween,
#   children: [
#     const Row(... Confirm Security Code ...),
#     Row(... [Container(... bullets ...), SizedBox, Text('Verified')] ...)
#   ]
# )
# The word "Confirm Security Code" and the bullets might be too wide for smaller screens (like the emulator).
# We should wrap the inner Text with Expanded or just make the whole thing wrap.

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Characters fixed!")
