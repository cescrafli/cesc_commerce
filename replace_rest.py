import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# OnboardingScreen
pattern = r'''Container\(\s*decoration: BoxDecoration\(color: Colors\.white\.withOpacity\(0\.9\), borderRadius: BorderRadius\.circular\(20\), border: Border\.all\(color: Colors\.grey\.shade200\)\),\s*child: const Row\(\s*children: \[\s*Icon\(Icons\.circle, color: Color\(0xFF00BCD4\), size: 8\),\s*SizedBox\(width: 6\),\s*Text\('EN \(US\)', style: TextStyle\(color: Colors\.black54, fontWeight: FontWeight\.bold, fontSize: 11\)\),\s*\],\s*\),\s*\)'''
content = re.sub(pattern, 'const LanguageSelector(bgColor: Colors.white70, textColor: Colors.black54)', content)

# ForgotPasswordScreen
pattern2 = r'''Container\(\s*padding: const EdgeInsets\.symmetric\(horizontal: 16, vertical: 8\),\s*decoration: BoxDecoration\(color: Colors\.white, borderRadius: BorderRadius\.circular\(20\)\),\s*child: const Row\(\s*children: \[\s*Icon\(Icons\.circle, color: Color\(0xFF00BCD4\), size: 8\),\s*SizedBox\(width: 6\),\s*Text\('EN \(US\)', style: TextStyle\(fontWeight: FontWeight\.bold, fontSize: 12\)\),\s*\],\s*\),\s*\)'''
content = re.sub(pattern2, 'const LanguageSelector(bgColor: Colors.white, textColor: Colors.black)', content)

with open('lib/main.dart', 'w', encoding='utf-8') as f:
    f.write(content)
