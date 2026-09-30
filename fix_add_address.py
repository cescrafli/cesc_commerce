import re

with open('lib/screens/cart/add_new_address_screen.dart', 'r', encoding='utf-8') as f:
    content = f.read()

import_auth = "import 'package:cesc_commerce/core/services/address_service.dart';\n"
if 'address_service.dart' not in content:
    content = content.replace("import 'package:cesc_commerce/widgets.dart';", "import 'package:cesc_commerce/widgets.dart';\n" + import_auth)

old_build_field = '''Widget _buildTextField(String label, {String? hint, IconData? icon}) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 20),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),

          const SizedBox(height: 8),

          Container(

            decoration: BoxDecoration(

              color: Colors.grey.shade50,

              borderRadius: BorderRadius.circular(12),

              border: Border.all(color: Colors.grey.shade200)

            ),

            child: TextField(

              decoration: InputDecoration(

                hintText: hint,

                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),

                border: InputBorder.none,

                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

                suffixIcon: icon != null ? Icon(icon, color: Colors.grey.shade400, size: 20) : null

              ),

            )

          )

        ]

      )

    );

  }'''

new_build_field = '''Widget _buildTextField(String label, TextEditingController ctrl, {String? hint, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200)
            ),
            child: TextField(
              controller: ctrl,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                suffixIcon: icon != null ? Icon(icon, color: Colors.grey.shade400, size: 20) : null
              ),
            )
          )
        ]
      )
    );
  }'''

content = content.replace(old_build_field, new_build_field)

# Replace usage
content = content.replace("_buildTextField('Full Name', hint: 'e.g. Cesc Fabregas')", "_buildTextField('Full Name', nameCtrl, hint: 'e.g. Cesc Fabregas')")
content = content.replace("_buildTextField('Mobile Phone Number', hint: 'e.g. +1 (555) 000-0000')", "_buildTextField('Mobile Phone Number', phoneCtrl, hint: 'e.g. +1 (555) 000-0000')")
content = content.replace("_buildTextField('Street Address', hint: '123 Main Street')", "_buildTextField('Street Address', streetCtrl, hint: '123 Main Street')")
content = content.replace("_buildTextField('Apartment, Suite, etc. (Optional)')", "_buildTextField('Apartment, Suite, etc. (Optional)', TextEditingController())")
content = content.replace("_buildTextField('City', hint: 'San Diego')", "_buildTextField('City', cityCtrl, hint: 'San Diego')")
content = content.replace("_buildTextField('State / Region')", "_buildTextField('State / Region', TextEditingController())")
content = content.replace("_buildTextField('ZIP / Postal Code', hint: '92101')", "_buildTextField('ZIP / Postal Code', zipCtrl, hint: '92101')")
content = content.replace("_buildTextField('Delivery Instructions (Optional)', hint: 'e.g. Leave at front door')", "_buildTextField('Delivery Instructions (Optional)', TextEditingController(), hint: 'e.g. Leave at front door')")

# Fix Save button
old_save = '''GestureDetector(

                  onTap: () {

                    final addr = {

                      'title': '\, \, CA \',

                      'name': nameCtrl.text.isEmpty ? 'Cesc' : nameCtrl.text,

                      'phone': phoneCtrl.text.isEmpty ? 'Phone' : phoneCtrl.text,

                      'isPrimary': false

                    };

                    

                    final current = List<Map<String, dynamic>>.from(globalAddresses.value);

                    current.add(addr);

                    globalAddresses.value = current;

                    

                    Navigator.pop(context);

                  },'''

new_save = '''GestureDetector(
                  onTap: () async {
                    final addr = {
                      'title': '\, \, CA \',
                      'name': nameCtrl.text.isEmpty ? 'Cesc' : nameCtrl.text,
                      'phone': phoneCtrl.text.isEmpty ? 'Phone' : phoneCtrl.text,
                      'isPrimary': false
                    };
                    await AddressService().addAddress(addr);
                    if (context.mounted) Navigator.pop(context);
                  },'''

content = content.replace(old_save, new_save)

with open('lib/screens/cart/add_new_address_screen.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed add address')
