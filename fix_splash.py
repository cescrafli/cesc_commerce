with open('lib/screens/misc/splash_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_auth = "import 'package:cesc_commerce/core/services/auth_service.dart';\n"
if 'auth_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_auth)

old_init = '''void initState() {

    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    

    // Navigate after 3 seconds

    Future.delayed(const Duration(seconds: 3), () {

      if (mounted) {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));

      }

    });

  }'''

new_init = '''void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.8, end: 1.1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    // Navigate after 3 seconds and check auth
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final user = AuthService().currentUser;
        if (user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainNavigationScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
        }
      }
    });
  }'''

content = content.replace(old_init, new_init)

with open('lib/screens/misc/splash_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed splash screen')
