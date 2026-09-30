with open('lib/screens/auth/login_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

old_block = '''// Logo
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 70, height: 70,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFF00BCD4), Color(0xFF0097A7)]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 36),
                        ),
                        const SizedBox(height: 12),
                        const Text('CESCRAFLI', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 3, color: Color(0xFF0097A7))),
                      ],
                    ),
                  ),'''

new_block = '''// Logo
                  Center(
                    child: Column(
                      children: [
                        Image.asset('assets/images/logo_icon.png', width: 70, height: 70, fit: BoxFit.contain),
                        const SizedBox(height: 12),
                        Image.asset('assets/images/logo_text.png', height: 20, fit: BoxFit.contain),
                      ],
                    ),
                  ),'''

content = content.replace(old_block, new_block)

with open('lib/screens/auth/login_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Replaced logo in login_screen.dart')
