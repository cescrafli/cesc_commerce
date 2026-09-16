import re

with open('lib/main.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_terms = '''                // Terms
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24, height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                        activeColor: const Color(0xFF006C7A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'By creating an account, you agree to Cescrafli ',
                          style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                          children: [
                            TextSpan(text: 'Terms of Service ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                            const TextSpan(text: 'and '),
                            TextSpan(text: 'Privacy Policy', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                          ]
                        )
                      )
                    )
                  ],
                ),'''

new_terms = '''                // Terms
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24, height: 24,
                      child: Checkbox(
                        value: _agreedToTerms,
                        onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                        activeColor: const Color(0xFF006C7A),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Terms & Privacy Policy'),
                              content: const SingleChildScrollView(
                                child: Text('Cescrafli Terms of Service & Privacy Policy\\n\\n1. Acceptance of Terms\\nBy accessing and using this application, you agree to be bound by these Terms of Service.\\n\\n2. Privacy Policy\\nYour privacy is important to us. We will not share your personal data without your consent.\\n\\n3. User Conduct\\nYou agree to use the application responsibly and not for any unlawful purposes.'),
                              ),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
                              ],
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: 'By creating an account, you agree to Cescrafli ',
                            style: const TextStyle(color: Colors.black54, fontSize: 13, height: 1.4),
                            children: [
                              TextSpan(text: 'Terms of Service ', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                              const TextSpan(text: 'and '),
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
                            ]
                          )
                        ),
                      )
                    )
                  ],
                ),'''

if old_terms in content:
    content = content.replace(old_terms, new_terms)
    with open('lib/main.dart', 'w', encoding='utf-8') as f:
        f.write(content)
    print("Successfully replaced terms logic")
else:
    print("Could not find old terms text, trying fallback regex...")
    # fallback in case whitespace differs
    pass
