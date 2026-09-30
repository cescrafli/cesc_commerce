import re

with open('lib/screens/profile/settings_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Fix Language
old_lang = "_buildSettingsTile(Icons.language, 'Language', 'Application display language', _buildCyanPill('English\\n(US)'), showChevron: true),"
new_lang = '''GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                          builder: (_) => const LanguageSelector(),
                        );
                      },
                      child: _buildSettingsTile(Icons.language, 'Language', 'Application display language', _buildCyanPill(_getLangLabel(globalLanguage.value)), showChevron: true),
                    ),'''
content = content.replace(old_lang, new_lang)

# Fix Currency
old_curr = "_buildSettingsTile(Icons.attach_money, 'Currency', 'Pricing and checkout', _buildCyanPill('USD (\$)'), showChevron: true),"
new_curr = '''GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Select Currency'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: ['USD (\$)', 'IDR (Rp)', 'EUR (€)'].map((c) => ListTile(
                                title: Text(c),
                                onTap: () {
                                  setState(() => _currency = c);
                                  Navigator.pop(context);
                                }
                              )).toList(),
                            )
                          )
                        );
                      },
                      child: _buildSettingsTile(Icons.attach_money, 'Currency', 'Pricing and checkout', _buildCyanPill(_currency), showChevron: true),
                    ),'''
content = content.replace(old_curr, new_curr)

with open('lib/screens/profile/settings_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed settings tiles')
