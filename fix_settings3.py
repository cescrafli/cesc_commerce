with open('lib/screens/profile/settings_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("static String _currency = 'USD ($)';", "static String _currency = 'USD (\\$)';")
content = content.replace("'USD ($)', 'IDR", "'USD (\\$)', 'IDR")
content = content.replace("child: _buildSettingsTile(Icons.language, 'Language', _getLangLabel(globalLanguage.value), const Icon(Icons.chevron_right, color: Colors.grey)),", "child: _buildSettingsTile(Icons.language, 'Language', _getLangLabel(globalLanguage.value), const Icon(Icons.chevron_right, color: Colors.grey)),")

with open('lib/screens/profile/settings_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed settings dart errors')
