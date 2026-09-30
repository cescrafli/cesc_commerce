import re

files = ['lib/screens/home/home_screen.dart', 'lib/screens/product/category_list_screen.dart']
for file in files:
    with open(file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    content = content.replace("NotificationScreen()", "NotificationsScreen()")
    
    with open(file, 'w', encoding='utf-8') as f:
        f.write(content)
print('Fixed navigation to NotificationsScreen')
