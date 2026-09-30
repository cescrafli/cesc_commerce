import re

with open('lib/screens/profile/order_tracking_screen.dart', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# Fix 1: Fix total price bug
# The total shows .00 for 2 items. Find the total price display and fix it.
# Look for 15.00 near 'Total Paid' or similar
# Let's find the pattern
print('Looking for total price...')
lines = content.split('\n')
for i, line in enumerate(lines):
    if '15' in line and ('Total' in line or 'total' in line or 'paid' in line.lower()):
        print(f'Line {i+1}: {line[:120]}')
    if 'Clipboard' in line:
        print(f'Clipboard line {i+1}: {line[:120]}')
