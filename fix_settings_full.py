import re

with open('lib/screens/profile/settings_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Re-add variables
content = content.replace('globalLanguage.addListener(_onLangChange);', '''globalLanguage.addListener(_onLangChange);
  }
  
  static bool pushNotif = true;
  static bool trackingAlerts = true;
  static bool promoDeals = false;
  static String _currency = 'USD (\$)';
''')

content = content.replace('''_buildSwitchTile('Dark Mode', 'Experience a darker theme', darkMode, (val) {

                    setState(() => darkMode = val);

                  }),''', '''ValueListenableBuilder<ThemeMode>(
                    valueListenable: globalThemeMode,
                    builder: (context, theme, _) {
                      return _buildSwitchTile('Dark Mode', 'Experience a darker theme', theme == ThemeMode.dark, (val) {
                        globalThemeMode.value = val ? ThemeMode.dark : ThemeMode.light;
                      });
                    }
                  ),''')

content = content.replace('''                  _buildSettingsTile(Icons.language, 'Language', 'English\\n(US)', const Icon(Icons.chevron_right, color: Colors.grey)),''', '''                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        builder: (_) => const LanguageSelector(),
                      );
                    },
                    child: _buildSettingsTile(Icons.language, 'Language', _getLangLabel(globalLanguage.value), const Icon(Icons.chevron_right, color: Colors.grey)),
                  ),''')

content = content.replace('''                  _buildSettingsTile(Icons.payments_outlined, 'Currency', 'USD (\$)', const Icon(Icons.chevron_right, color: Colors.grey)),''', '''                  GestureDetector(
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
                    child: _buildSettingsTile(Icons.payments_outlined, 'Currency', _currency, const Icon(Icons.chevron_right, color: Colors.grey)),
                  ),''')

content = content.replace('Widget _buildSettingsTile', '''String _getLangLabel(String code) {
    if (code == 'id' || code == 'ID') return 'Indonesia\\n(ID)';
    if (code == 'es' || code == 'ES') return 'Espanol\\n(ES)';
    if (code == 'zh' || code == 'ZH') return '??\\n(ZH)';
    return 'English\\n(US)';
  }

  Widget _buildSettingsTile''')

with open('lib/screens/profile/settings_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed settings_screen.dart')
