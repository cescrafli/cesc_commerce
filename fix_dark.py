with open('lib/screens/profile/settings_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "_buildSettingsTile(Icons.dark_mode_outlined, 'Dark Mode', 'Adjust application theme', _buildToggle(darkMode, (v) => setState(() => darkMode = v)), showChevron: false),",
    '''ValueListenableBuilder<ThemeMode>(
                    valueListenable: globalThemeMode,
                    builder: (context, theme, _) {
                      return _buildSettingsTile(Icons.dark_mode_outlined, 'Dark Mode', 'Adjust application theme', _buildToggle(theme == ThemeMode.dark, (v) {
                        globalThemeMode.value = v ? ThemeMode.dark : ThemeMode.light;
                      }), showChevron: false);
                    }
                  ),'''
)

with open('lib/screens/profile/settings_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed dark mode')
