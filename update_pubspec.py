import re

with open('pubspec.yaml', 'r') as f:
    content = f.read()

# First, remove existing flutter_launcher_icons section
content = re.sub(r'^flutter_launcher_icons:.*?(?=^[a-zA-Z_]+:|\Z)', '', content, flags=re.MULTILINE | re.DOTALL)

# Now append the new one
new_config = '''
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/logo_icon_padded.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/images/logo_icon_padded.png"
'''
content += new_config

with open('pubspec.yaml', 'w') as f:
    f.write(content)

print('Updated pubspec.yaml successfully.')
