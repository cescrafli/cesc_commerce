import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/address_service.dart';


class EditAddressScreen extends StatefulWidget {
  final int addressIndex;
  final Map<String, dynamic> addressData;

  const EditAddressScreen({super.key, required this.addressIndex, required this.addressData});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController streetCtrl;
  late TextEditingController cityCtrl;
  late TextEditingController zipCtrl;
  late TextEditingController aptCtrl;
  late TextEditingController stateCtrl;
  late TextEditingController instructionCtrl;

  int selectedLabel = 0; // 0: Home, 1: Office, 2: Parents
  bool isDefault = true;
  bool isEco = true;
  final _labelOptions = const ['Home', 'Office', 'Parents'];

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.addressData['name'] ?? '');
    phoneCtrl = TextEditingController(text: widget.addressData['phone'] ?? '');
    
    String? street = widget.addressData['street'];
    String? city = widget.addressData['city'];
    String? zip = widget.addressData['zip'];
    
    if (street == null && widget.addressData['address'] != null) {
      final parts = widget.addressData['address'].split(', ');
      if (parts.length >= 3) {
        street = parts[0];
        city = parts[1];
        zip = parts[2];
      }
    }
    
    streetCtrl = TextEditingController(text: street ?? '');
    cityCtrl = TextEditingController(text: city ?? '');
    zipCtrl = TextEditingController(text: zip ?? '');
    aptCtrl = TextEditingController(text: widget.addressData['apt'] ?? '');
    stateCtrl = TextEditingController(text: widget.addressData['state'] ?? '');
    instructionCtrl = TextEditingController(text: widget.addressData['instructions'] ?? '');
    
    isDefault = widget.addressData['isDefault'] ?? false;
    final labelIndex = _labelOptions.indexOf(widget.addressData['title'] ?? 'Home');
    selectedLabel = labelIndex >= 0 ? labelIndex : 0;
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    streetCtrl.dispose();
    cityCtrl.dispose();
    zipCtrl.dispose();
    aptCtrl.dispose();
    stateCtrl.dispose();
    instructionCtrl.dispose();
    super.dispose();
  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF7F8FA),

      body: SafeArea(

        child: Column(

          children: [

            // Header

            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              child: Row(

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context),

                    child: Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                      child: const Icon(Icons.arrow_back_ios_new, size: 18),

                    ),

                  ),

                  Expanded(

                    child: Column(

                      children: [

                        const Text('Edit Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                        const SizedBox(height: 2),

                        Text('UPDATE SHIPPING & BILLING DETAILS', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                      ],

                    ),

                  ),

                  GestureDetector(
                    onTap: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Address'),
                          content: const Text('Are you sure you want to delete this address?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await AddressService().deleteAddress(widget.addressIndex);
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle),
                      child: Icon(Icons.delete_outline, color: Colors.red.shade400, size: 22),
                    ),
                  ), 

                ],

              ),

            ),

            

            Expanded(

              child: SingleChildScrollView(

                padding: const EdgeInsets.all(20),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // Map Area

                    Container(

                      height: 220,

                      decoration: BoxDecoration(

                        color: Colors.blue.shade50,

                        borderRadius: BorderRadius.circular(20),

                        border: Border.all(color: Colors.grey.shade200),

                        image: const DecorationImage(

                          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'), 

                          repeat: ImageRepeat.repeat,

                          opacity: 0.1,

                        )

                      ),

                      child: Stack(

                        children: [

                          Center(

                            child: Column(

                              mainAxisSize: MainAxisSize.min,

                              children: [

                                Container(

                                  padding: const EdgeInsets.all(8),

                                  decoration: const BoxDecoration(color: Color(0xFF00BCD4), shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))]),

                                  child: const Icon(Icons.location_on, color: Colors.white, size: 24),

                                ),

                                Container(width: 8, height: 8, margin: const EdgeInsets.only(top: 4), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle)),

                              ],

                            ),

                          ),

                          Positioned(

                            bottom: 15, left: 15,

                            child: Container(

                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)]),

                              child: Row(

                                children: [

                                  Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),

                                  const SizedBox(width: 6),

                                  const Text('Precise Pin Enabled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),

                                ],

                              ),

                            ),

                          ),

                          Positioned(

                            bottom: 15, right: 15,

                            child: Container(

                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),

                              decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(12)),

                              child: const Row(

                                children: [

                                  Icon(Icons.pinch, color: Colors.white, size: 14),

                                  SizedBox(width: 6),

                                  Text('Adjust Pin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),

                                ],

                              ),

                            ),

                          )

                        ],

                      ),

                    ),

                    const SizedBox(height: 15),



                    // Current GPS

                    Container(

                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),

                      child: Row(

                        children: [

                          Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFF00BCD4), borderRadius: BorderRadius.all(Radius.circular(10))), child: const Icon(Icons.my_location, color: Colors.white, size: 20)),

                          const SizedBox(width: 15),

                          Expanded(

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                const Text('Use Current GPS Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                                const SizedBox(height: 2),

                                Text('Downtown, San Diego, CA', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),

                              ],

                            ),

                          ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                        ],

                      ),

                    ),

                    const SizedBox(height: 25),



                    // Contact Person Section

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Text('CONTACT PERSON', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                        Row(

                          children: [

                            Icon(Icons.sync, color: const Color(0xFF0F8A9E), size: 14),

                            const SizedBox(width: 4),

                            const Text('Sync with profile', style: TextStyle(color: Color(0xFF0F8A9E), fontWeight: FontWeight.bold, fontSize: 11)),

                          ],

                        )

                      ],

                    ),

                    const SizedBox(height: 15),

                    const Text('Full Name *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 8),

                    Container(

                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                      child: TextField(
                        controller: nameCtrl,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', suffixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                        style: const TextStyle(fontSize: 14),
                      ),

                    ),

                    const SizedBox(height: 15),

                    const Text('Mobile Phone Number *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 8),

                    Row(

                      children: [

                        Container(

                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),

                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                          child: const Row(children: [Text(' +1', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)), SizedBox(width: 8), Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18)]),

                        ),

                        const SizedBox(width: 10),

                        Expanded(

                          child: Container(

                            padding: const EdgeInsets.symmetric(horizontal: 15),

                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),

                            child: TextField(
                              controller: phoneCtrl,
                              decoration: const InputDecoration(border: InputBorder.none, hintText: '(858) 555-0192', suffixIcon: Icon(Icons.check, color: Colors.green, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),
                              style: const TextStyle(fontSize: 14),
                            ),

                          ),

                        )

                      ],

                    ),

                    const SizedBox(height: 6),

                    Text('Couriers will call or SMS for access updates.', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                    const SizedBox(height: 25),



                    // Address Details Section

                    Text('ADDRESS DETAILS', style: TextStyle(color: Colors.blueGrey.shade400, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                    const SizedBox(height: 15),

                    const Text('Street Address *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 8),

                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: TextField(controller: streetCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: '123 Main Street'), style: const TextStyle(fontSize: 14))),

                    

                    const SizedBox(height: 15),

                    const Text('Apartment, Suite, Unit, Building (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 8),

                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: TextField(controller: aptCtrl, decoration: const InputDecoration(border: InputBorder.none, hintText: 'Apt 4B'), style: const TextStyle(fontSize: 14))),

                    

                    const SizedBox(height: 15),

                    Row(

                      children: [

                        Expanded(

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const Text('City *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                              const SizedBox(height: 8),

                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: TextField(controller: cityCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: 'San Diego'), style: const TextStyle(fontSize: 14))),

                            ],

                          ),

                        ),

                        const SizedBox(width: 15),

                        Expanded(

                          child: Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              const Text('ZIP / Postal Code *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                              const SizedBox(height: 8),

                              Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: TextField(controller: zipCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: '92101'), style: const TextStyle(fontSize: 14))),

                            ],

                          ),

                        )

                      ],

                    ),



                    const SizedBox(height: 15),

                    const Text('State / Region *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 8),

                    Container(padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: TextField(controller: stateCtrl, decoration: const InputDecoration(border: InputBorder.none, hintText: 'California (CA)', suffixIcon: Icon(Icons.keyboard_arrow_down, color: Colors.grey), suffixIconConstraints: BoxConstraints(minWidth: 20)), style: const TextStyle(fontSize: 14))),

                    

                    const SizedBox(height: 25),

                    const Text('Address Label Tag', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                    const SizedBox(height: 12),

                    SingleChildScrollView(

                      scrollDirection: Axis.horizontal,

                      child: Row(

                        children: [

                          _buildLabelPill(0, 'Home', Icons.home_outlined),

                          const SizedBox(width: 10),

                          _buildLabelPill(1, 'Office', Icons.business_center_outlined),

                          const SizedBox(width: 10),

                          _buildLabelPill(2, 'Parents', Icons.apartment_outlined),

                        ],

                      ),

                    ),



                    const SizedBox(height: 25),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        const Text('Delivery Instructions / Courier Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),

                        Text('Optional', style: TextStyle(color: Colors.blueGrey.shade300, fontSize: 11)),

                      ],

                    ),

                    const SizedBox(height: 8),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
                      child: TextField(controller: instructionCtrl, maxLines: 3, decoration: const InputDecoration(border: InputBorder.none, hintText: 'Ring doorbell twice upon arrival'), style: const TextStyle(fontSize: 14)),
                    ),



                    const SizedBox(height: 25),



                    // Settings Card

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.verified_user_outlined, color: Color(0xFF0F8A9E), size: 20),

                              SizedBox(width: 8),

                              Text('DELIVERY & ADDRESS SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5)),

                            ],

                          ),

                          const SizedBox(height: 20),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Row(

                                      children: [

                                        const Text('Set as Default Address', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),

                                        const SizedBox(width: 8),

                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(4)), child: const Text('DEFAULT', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),

                                      ],

                                    ),

                                    const SizedBox(height: 4),

                                    Text('Use as primary destination for fast 1-click checkout', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                                  ],

                                ),

                              ),

                              Switch(value: isDefault, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => isDefault = val)),

                            ],

                          ),

                          const SizedBox(height: 15),

                          Divider(height: 1, color: Colors.grey.shade100),

                          const SizedBox(height: 15),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Expanded(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [

                                    Row(

                                      children: [

                                        const Text('Eco-friendly minimal packaging', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),

                                        const SizedBox(width: 6),

                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.eco, color: Colors.green, size: 10), SizedBox(width: 2), Text('Eco', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))])),

                                      ],

                                    ),

                                    const SizedBox(height: 4),

                                    Text('100% biodegradable corrugated box & paper tape', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                                  ],

                                ),

                              ),

                              Switch(value: isEco, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => isEco = val)),

                            ],

                          ),

                        ],

                      ),

                    ),

                    const SizedBox(height: 20),

                  ],

                ),

              ),

            ),

            

            // Bottom Action Bar

            Container(

              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),

              decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))]),

              child: Column(

                children: [

                  SizedBox(

                    width: double.infinity, height: 55,

                    child: ElevatedButton(

                      onPressed: () async {
                        if (nameCtrl.text.isEmpty || phoneCtrl.text.isEmpty || streetCtrl.text.isEmpty || cityCtrl.text.isEmpty || zipCtrl.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill out all required fields'))
                          );
                          return;
                        }
                        final updatedAddress = {
                          ...widget.addressData,
                          'name': nameCtrl.text,
                          'phone': phoneCtrl.text,
                          'street': streetCtrl.text,
                          'city': cityCtrl.text,
                          'zip': zipCtrl.text,
                          'address': '${streetCtrl.text}, ${cityCtrl.text}, ${zipCtrl.text}',
                          'isDefault': isDefault,
                          'title': _labelOptions[selectedLabel],
                          'apt': aptCtrl.text,
                          'state': stateCtrl.text,
                          'instructions': instructionCtrl.text,
                        };
                        await AddressService().updateAddress(widget.addressIndex, updatedAddress);
                        if (isDefault) {
                          await AddressService().setDefaultAddress(widget.addressIndex);
                        }
                        if (context.mounted) Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.check_circle_outline, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),

                            ],

                          ),

                          Row(

                            children: [

                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('UPDATE', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),

                              const SizedBox(width: 6),

                              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),

                            ],

                          )

                        ],

                      ),

                    ),

                  ),

                  const SizedBox(height: 12),

                  Row(

                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [

                      const Icon(Icons.verified_user, color: Colors.greenAccent, size: 14),

                      const SizedBox(width: 6),

                      Text('100% Guaranteed On-Time Safe Delivery & Encrypted', style: TextStyle(color: Colors.grey.shade400, fontSize: 10)),

                    ],

                  )

                ],

              ),

            )

          ],

        ),

      ),

    );

  }



  Widget _buildLabelPill(int index, String title, IconData icon) {

    bool isSel = selectedLabel == index;

    return GestureDetector(

      onTap: () => setState(() => selectedLabel = index),

      child: Container(

        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

        decoration: BoxDecoration(

          color: isSel ? const Color(0xFF00BCD4) : Colors.white,

          border: Border.all(color: isSel ? const Color(0xFF00BCD4) : Colors.grey.shade200),

          borderRadius: BorderRadius.circular(12),

        ),

        child: Row(

          children: [

            Icon(icon, color: isSel ? Colors.white : Colors.grey.shade600, size: 16),

            const SizedBox(width: 6),

            Text(title, style: TextStyle(color: isSel ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),

          ],

        ),

      ),

    );

  }

}
