import re

with open('lib/screens/auth/personal_info_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# Make it StatefulWidget
content = content.replace('class PersonalInfoScreen extends StatelessWidget {', '''import 'package:cesc_commerce/core/services/user_service.dart';

class PersonalInfoScreen extends StatefulWidget {''')

content = content.replace('const PersonalInfoScreen({super.key});', '''const PersonalInfoScreen({super.key});
  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  bool _isLoading = true;
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _genderCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
  
  Future<void> _loadProfile() async {
    final profile = await UserService().getProfile();
    setState(() {
      _nameCtrl.text = profile['name'] ?? '';
      _emailCtrl.text = profile['email'] ?? '';
      _phoneCtrl.text = profile['phone'] ?? '';
      _dobCtrl.text = profile['dob'] ?? '';
      _genderCtrl.text = profile['gender'] ?? '';
      _isLoading = false;
    });
  }

  Future<void> _saveChanges() async {
    setState(() => _isLoading = true);
    await UserService().updateProfile({
      'name': _nameCtrl.text,
      'email': _emailCtrl.text,
      'phone': _phoneCtrl.text,
      'dob': _dobCtrl.text,
      'gender': _genderCtrl.text
    });
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved!')));
      Navigator.pop(context);
    }
  }''')

content = content.replace('''@override

  Widget build(BuildContext context) {''', '''@override

  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));''')

# Now fix the build method to use TextFields.
# This might be tricky via regex, so let's rewrite the _buildInfoField function.
old_build_field = '''Widget _buildInfoField(String label, String value, {bool isVerified = false}) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 20),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.bold)),

          const SizedBox(height: 8),

          Container(

            width: double.infinity,

            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius: BorderRadius.circular(12),

              border: Border.all(color: Colors.grey.shade200)

            ),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),

                if (isVerified) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('Verified', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)))

              ]

            )

          )

        ]

      )

    );

  }'''

new_build_field = '''Widget _buildInfoField(String label, TextEditingController ctrl, {bool isVerified = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: ctrl,
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                if (isVerified) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)), child: const Text('Verified', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)))
              ]
            )
          )
        ]
      )
    );
  }'''

content = content.replace(old_build_field, new_build_field)

# Now replace the calls to _buildInfoField
content = content.replace("_buildInfoField('Full Name', 'Cesc Fabregas')", "_buildInfoField('Full Name', _nameCtrl)")
content = content.replace("_buildInfoField('Email Address', 'cesc.fabregas@clubmail.com', isVerified: true)", "_buildInfoField('Email Address', _emailCtrl, isVerified: true)")
content = content.replace("_buildInfoField('Phone Number', '(555) 382-9014', isVerified: true)", "_buildInfoField('Phone Number', _phoneCtrl, isVerified: true)")
content = content.replace("_buildInfoField('Date of Birth', 'May 4, 1987')", "_buildInfoField('Date of Birth', _dobCtrl)")
content = content.replace("_buildInfoField('Gender', 'Male')", "_buildInfoField('Gender', _genderCtrl)")

# Fix Save Changes button
old_save = '''GestureDetector(

                  onTap: () => Navigator.pop(context),'''
new_save = '''GestureDetector(
                  onTap: _saveChanges,'''

content = content.replace(old_save, new_save)

with open('lib/screens/auth/personal_info_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed personal info')
