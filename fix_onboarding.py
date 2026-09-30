import codecs, re

with codecs.open('lib/screens/misc/onboarding_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Replace the incorrect $0.00 button logic with "Get Started"
incorrect_button = r"Text\('\\\$\$\{total\.toStringAsFixed\(2\)\}', style: const TextStyle\(color: Colors\.white, fontSize: 16, fontWeight: FontWeight\.bold\)\), const SizedBox\(width: 8\), const Icon\(Icons\.arrow_forward, color: Colors\.white, size: 18\)"
correct_button = "const Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.arrow_forward, color: Colors.white, size: 18)"

content = re.sub(incorrect_button, correct_button, content)

with codecs.open('lib/screens/misc/onboarding_screen.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Onboarding fixed!")
