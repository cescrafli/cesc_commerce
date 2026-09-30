import re

with open('lib/screens/profile/settings_screen.dart', 'r', encoding='utf-8', errors='replace') as f:
    content = f.read()

# 1. Use static fields for toggles
content = content.replace('''  bool pushNotif = true;
  bool trackingAlerts = true;
  bool promoDeals = false;
  bool darkMode = false;''', '''  static bool pushNotif = true;
  static bool trackingAlerts = true;
  static bool promoDeals = false;''')

# 2. Fix Dark Mode toggle
old_darkmode_tile = '''_buildSwitchTile('Dark Mode', 'Experience a darker theme', darkMode, (val) {
                    setState(() => darkMode = val);
                  }),'''
new_darkmode_tile = '''ValueListenableBuilder<ThemeMode>(
                    valueListenable: globalThemeMode,
                    builder: (context, theme, _) {
                      return _buildSwitchTile('Dark Mode', 'Experience a darker theme', theme == ThemeMode.dark, (val) {
                        globalThemeMode.value = val ? ThemeMode.dark : ThemeMode.light;
                      });
                    }
                  ),'''
content = content.replace(old_darkmode_tile, new_darkmode_tile)

# 3. Fix Language tile
old_lang_tile = '''_buildSettingsTile(Icons.language, 'Language', 'English\\n(US)', const Icon(Icons.chevron_right, color: Colors.grey)),'''
new_lang_tile = '''GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        builder: (_) => const LanguageSelector(),
                      );
                    },
                    child: _buildSettingsTile(Icons.language, 'Language', _getLangLabel(lang), const Icon(Icons.chevron_right, color: Colors.grey)),
                  ),'''
content = content.replace(old_lang_tile, new_lang_tile)

if '_getLangLabel' not in content:
    get_lang = '''
  String _getLangLabel(String code) {
    if (code == 'id') return 'Indonesia\\n(ID)';
    if (code == 'es') return 'Español\\n(ES)';
    if (code == 'zh') return '??\\n(ZH)';
    return 'English\\n(US)';
  }
  
  @override'''
    content = content.replace('@override', get_lang, 1)

# 4. Fix Currency tile
if 'static String _currency =' not in content:
    content = content.replace('static bool promoDeals = false;', 'static bool promoDeals = false;\n  static String _currency = \'USD (\u0024)\';')

old_curr_tile = '''_buildSettingsTile(Icons.payments_outlined, 'Currency', 'USD (\u0024)', const Icon(Icons.chevron_right, color: Colors.grey)),'''
new_curr_tile = '''GestureDetector(
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
                  ),'''
content = content.replace(old_curr_tile, new_curr_tile)

# Fix toggles to use static
content = content.replace('pushNotif, (val)', 'pushNotif, (val)')
content = content.replace('setState(() => pushNotif = val);', 'setState(() => pushNotif = val);')
content = content.replace('trackingAlerts, (val)', 'trackingAlerts, (val)')
content = content.replace('setState(() => trackingAlerts = val);', 'setState(() => trackingAlerts = val);')
content = content.replace('promoDeals, (val)', 'promoDeals, (val)')
content = content.replace('setState(() => promoDeals = val);', 'setState(() => promoDeals = val);')

with open('lib/screens/profile/settings_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed settings_screen.dart')
