# coding=utf-8
import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

for i in range(len(lines)):
    if "Already have an account?" in lines[i]:
        # We are at the row in SignUpScreen
        # Search forward for the const SizedBox(height: 20),
        for j in range(i, i+15):
            if "const SizedBox(height: 20)," in lines[j]:
                lines[j] = "                const SizedBox(height: 100),\n"
                break
    
    if "256-bit Secure Encryption" in lines[i]:
        # We are at the row in LoginScreen
        # Search forward for the end of the children array
        for j in range(i, i+10):
            if "]," in lines[j]:
                lines[j] = "                  ],\n                ),\n                const SizedBox(height: 100),\n"
                break

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.writelines(lines)

print("Done!")
