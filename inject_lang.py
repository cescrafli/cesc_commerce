# -*- coding: utf-8 -*-
import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

language_widget = '''
class LanguageSelector extends StatefulWidget {
  final Color bgColor;
  final Color textColor;
  final bool showLanguageIcon;

  const LanguageSelector({
    super.key,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
    this.showLanguageIcon = false,
  });

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'EN (US)';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          setState(() {
            _selectedLanguage = value;
          });
        },
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(value: 'EN (US)', child: Text('EN (US) - English')),
          const PopupMenuItem<String>(value: 'ID (ID)', child: Text('ID (ID) - Indonesia')),
          const PopupMenuItem<String>(value: 'ES (ES)', child: Text('ES (ES) - Espanol')),
          const PopupMenuItem<String>(value: 'ZH (CN)', child: Text('ZH (CN) - Chinese')),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.showLanguageIcon)
                const Icon(Icons.language, color: Color(0xFF006C7A), size: 14)
              else
                const Icon(Icons.circle, color: Color(0xFF00BCD4), size: 8),
              const SizedBox(width: 6),
              Text(_selectedLanguage, style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 12)),
              const SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, color: widget.textColor, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
'''

if "class LanguageSelector" not in content:
    content = content.replace('class OnboardingScreen extends StatefulWidget {', language_widget + '\nclass OnboardingScreen extends StatefulWidget {')


# 1. OnboardingScreen
pattern_onboarding = r'''Container\(\s*decoration: BoxDecoration\(color: Colors\.white\.withOpacity\(0\.9\), borderRadius: BorderRadius\.circular\(20\), border: Border\.all\(color: Colors\.grey\.shade200\)\),\s*child: const Row\(\s*children: \[\s*Icon\(Icons\.circle, color: Color\(0xFF00BCD4\), size: 8\),\s*SizedBox\(width: 6\),\s*Text\('EN \(US\)', style: TextStyle\(color: Colors\.black54, fontWeight: FontWeight\.bold, fontSize: 11\)\),\s*\],\s*\),\s*\)'''
content = re.sub(pattern_onboarding, 'const LanguageSelector(bgColor: Colors.white70, textColor: Colors.black54)', content)

# 2. LoginScreen & ForgotPasswordScreen
pattern_login = r'''Container\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 12, vertical: 6\),\s*decoration: BoxDecoration\(color: Colors\.white, borderRadius: BorderRadius\.circular\(20\)\),\s*child: const Row\(\s*children: \[\s*Icon\(Icons\.circle, color: Color\(0xFF00BCD4\), size: 8\),\s*SizedBox\(width: 6\),\s*Text\('EN \(US\)', style: TextStyle\(fontWeight: FontWeight\.bold, fontSize: 12\)\),\s*\],\s*\),\s*\)'''
content = re.sub(pattern_login, 'const LanguageSelector(bgColor: Colors.white, textColor: Colors.black)', content)

# 3. SignUpScreen
pattern_signup = r'''Container\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 12, vertical: 6\),\s*decoration: BoxDecoration\(color: const Color\(0xFFE8EAF6\), borderRadius: BorderRadius\.circular\(20\)\),\s*child: const Row\(\s*children: \[\s*Icon\(Icons\.language, color: Color\(0xFF006C7A\), size: 14\),\s*SizedBox\(width: 6\),\s*Text\('EN \(US\)', style: TextStyle\(fontWeight: FontWeight\.bold, fontSize: 12\)\),\s*Icon\(Icons\.arrow_drop_down, size: 16\),\s*\],\s*\),\s*\)'''
content = re.sub(pattern_signup, 'const LanguageSelector(bgColor: Color(0xFFE8EAF6), textColor: Colors.black, showLanguageIcon: true)', content)


with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("LanguageSelector injected and replaced successfully.")
