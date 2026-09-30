import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';

import 'package:cesc_commerce/core/services/user_service.dart';

class PersonalInfoScreen extends StatefulWidget {

  const PersonalInfoScreen({super.key});
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
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dobCtrl.dispose();
    _genderCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
  
  Future<void> _loadProfile() async {
    final profile = await UserService().getProfile();
    if (!mounted) return;
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
    globalUser.value = {...?globalUser.value, 'name': _nameCtrl.text, 'email': _emailCtrl.text, 'phone': _phoneCtrl.text};
    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved!')));
      Navigator.pop(context);
    }
  }



  @override

  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Column(

            children: [

              // 1. Header

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [

                    GestureDetector(

                      onTap: () => Navigator.pop(context),

                      child: Container(

                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                        child: const Icon(Icons.arrow_back_ios_new, size: 18),

                      ),

                    ),

                    const Text('Personal Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Photo coming soon'))),
                      child: Container(

                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                        child: const Icon(Icons.edit_outlined, size: 20, color: Colors.cyan),

                      ),
                    ),

                  ],

                ),

              ),



              // 2. Profile Avatar

              const SizedBox(height: 10),

              Stack(

                alignment: Alignment.center,

                children: [

                  Container(

                    width: 100, height: 100,

                    decoration: BoxDecoration(

                      shape: BoxShape.circle,

                      border: Border.all(color: Theme.of(context).primaryColor, width: 2),

                      color: Colors.white

                    ),

                    child: Padding(

                      padding: const EdgeInsets.all(4.0),

                      child: CircleAvatar(

                        backgroundColor: Colors.grey.shade200,

                        child: Icon(Icons.person, size: 50, color: Colors.grey.shade400),

                      ),

                    ),

                  ),

                  Positioned(

                    bottom: 0, right: 0,

                    child: GestureDetector(

                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Avatar edit coming soon!')));
                      },

                      child: Container(

                        padding: const EdgeInsets.all(6),

                        decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),

                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),

                      ),

                    )

                  )

                ],

              ),

              const SizedBox(height: 15),

              Row(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(_nameCtrl.text.isNotEmpty ? _nameCtrl.text : (UserService.mockProfile.value['name'] ?? 'User'), style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),

                  const SizedBox(width: 5),

                  const Icon(Icons.verified, color: Colors.orange, size: 20),

                ],

              ),

              const SizedBox(height: 8),

              Container(

                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.cyan.shade100)),

                child: Text('GOLD VIP MEMBER', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),

              ),

              const SizedBox(height: 30),



              // 3. Basic Information Card

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('BASIC INFORMATION', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),

                        Text('Auto-saved', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),

                      ],

                    ),

                    const SizedBox(height: 20),

                    _buildTextField('Full Name', _nameCtrl, Icons.person_outline),

                    const SizedBox(height: 20),

                    _buildTextField('Email Address', _emailCtrl, Icons.mail_outline, rightLabel: _buildVerifiedBadge()),

                    const SizedBox(height: 20),

                    _buildTextField('Phone Number', _phoneCtrl, Icons.phone_outlined, rightLabel: _buildVerifiedBadge(), prefix: Row(mainAxisSize: MainAxisSize.min, children: [Text(' +1', style: TextStyle(fontSize: 14, color: Colors.grey.shade700)), const SizedBox(width: 8), Container(height: 20, width: 1, color: Colors.grey.shade300)])),

                    const SizedBox(height: 20),

                    Row(

                      children: [

                        Expanded(child: _buildTextField('Date of Birth', _dobCtrl, Icons.calendar_today_outlined, readOnly: true, onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (date != null) {
                            _dobCtrl.text = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          }
                        })),

                        const SizedBox(width: 15),

                        Expanded(child: _buildTextField('Gender', _genderCtrl, Icons.keyboard_arrow_down, readOnly: true, onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return SafeArea(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: ['Male', 'Female', 'Other'].map((gender) => ListTile(
                                    title: Text(gender),
                                    onTap: () {
                                      _genderCtrl.text = gender;
                                      Navigator.pop(context);
                                    },
                                  )).toList(),
                                ),
                              );
                            },
                          );
                        })),

                      ],

                    )

                  ],

                ),

              ),

              const SizedBox(height: 15),



              // 4. Primary Delivery Address Card

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      children: [

                        Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: 20),

                        const SizedBox(width: 10),

                        const Expanded(child: Text('Primary Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),

                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(10)), child: Text('DEFAULT', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 10, fontWeight: FontWeight.bold)))

                      ],

                    ),

                    const SizedBox(height: 15),

                    ValueListenableBuilder<List<dynamic>>(
                      valueListenable: globalAddresses,
                      builder: (context, addresses, _) {
                        return ValueListenableBuilder<int>(
                          valueListenable: globalSelectedAddressIndex,
                          builder: (context, selectedIndex, _) {
                            final hasAddress = addresses.isNotEmpty && selectedIndex >= 0 && selectedIndex < addresses.length;
                            final activeAddress = hasAddress ? addresses[selectedIndex] : null;
                            final addressText = activeAddress != null ? '${activeAddress['street'] ?? activeAddress['address'] ?? ''}\n${activeAddress['city'] ?? ''}, ${activeAddress['state'] ?? ''} ${activeAddress['zip'] ?? ''}' : 'No address set';
                            
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(activeAddress != null ? (activeAddress['title'] ?? activeAddress['label'] ?? 'Home Residence') : 'No Address', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                        const SizedBox(height: 4),
                                        Text(addressText, style: TextStyle(color: Colors.grey.shade500, fontSize: 12, height: 1.4)),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddressScreen())), child: Text('Edit', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13, fontWeight: FontWeight.bold)))
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )

                  ],

                ),

              ),

              const SizedBox(height: 15),



              // 5. Account & Security Card

              Container(

                margin: const EdgeInsets.symmetric(horizontal: 20),

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text('ACCOUNT & SECURITY', style: TextStyle(color: Colors.grey.shade500, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5)),

                    const SizedBox(height: 20),

                    Row(

                      children: [

                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey.shade50, shape: BoxShape.circle), child: Icon(Icons.lock_outline, color: Colors.grey.shade600, size: 20)),

                        const SizedBox(width: 15),

                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text('****', style: TextStyle(color: Colors.grey.shade400, fontSize: 16))])),

                        GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())), child: Text('Change', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 13, fontWeight: FontWeight.bold)))

                      ],

                    ),

                    const SizedBox(height: 20),

                    Row(

                      children: [

                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle), child: const Icon(Icons.security, color: Colors.green, size: 20)),

                        const SizedBox(width: 15),

                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('2-Step Verification', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), const SizedBox(height: 2), Text('Enhanced protection', style: TextStyle(color: Colors.grey.shade400, fontSize: 12))])),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                      ],

                    )

                  ],

                ),

              ),

              const SizedBox(height: 30),



              // 6. Buttons

              Padding(

                padding: const EdgeInsets.symmetric(horizontal: 20),

                child: SizedBox(

                  width: double.infinity, height: 55,

                  child: ElevatedButton(

                    onPressed: _isLoading ? null : _saveChanges,

                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.check, color: Colors.white, size: 20)]),

                  ),

                ),

              ),

              const SizedBox(height: 15),

              Center(child: GestureDetector(onTap: () => Navigator.pop(context), child: Text('Discard Changes', style: TextStyle(color: Colors.grey.shade400, fontSize: 14, fontWeight: FontWeight.bold)))),

              const SizedBox(height: 40),

            ]

          )

        )

      )

    );

  }



  Widget _buildVerifiedBadge() {

    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(10)),

      child: Row(

        children: [

          Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

          const SizedBox(width: 4),

          const Text('Verified', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),

        ],

      ),

    );

  }



  Widget _buildTextField(String label, TextEditingController controller, IconData icon, {String? hint, Widget? rightLabel, Widget? prefix, bool readOnly = false, VoidCallback? onTap}) {

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [

            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),

            if (rightLabel != null) rightLabel

          ]

        ),

        const SizedBox(height: 8),

        Container(

          height: 50,

          padding: const EdgeInsets.symmetric(horizontal: 16),

          decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

          child: Row(

            children: [

              if (prefix != null) ...[prefix, const SizedBox(width: 10)],

              Expanded(child: TextFormField(
                controller: controller,
                readOnly: readOnly,
                onTap: onTap,
                decoration: InputDecoration(
                  hintText: hint,
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              )),

              Icon(icon, size: 18, color: Colors.grey.shade400)

            ]

          )

        )

      ]

    );

  }

}
