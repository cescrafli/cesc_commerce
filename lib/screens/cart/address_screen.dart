import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class AddressScreen extends StatefulWidget {

  const AddressScreen({super.key});



  @override

  State<AddressScreen> createState() => _AddressScreenState();

}

class _AddressScreenState extends State<AddressScreen> {

  int selectedAddress = 0;
  String _searchQuery = "";
  late TextEditingController _searchCtrl;

  bool prefLeaveAtDoor = true;
  bool prefEco = true;

  @override
  void initState() {
    super.initState();
    selectedAddress = (globalSelectedAddressIndex.value < globalAddresses.value.length) ? globalSelectedAddressIndex.value : 0;
    _searchCtrl = TextEditingController();
    _searchCtrl.addListener(() {
      setState(() {
        _searchQuery = _searchCtrl.text;
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
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

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  GestureDetector(

                    onTap: () => Navigator.pop(context, selectedAddress),

                    child: Container(

                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),

                      child: const Icon(Icons.arrow_back_ios_new, size: 18),

                    ),

                  ),

                  Column(

                    children: [

                      const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                      const SizedBox(height: 2),

                      Text('SELECT SHIPPING LOCATION', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),

                    ],

                  ),

                  GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewAddressScreen()));
                      if (mounted) setState(() { selectedAddress = globalSelectedAddressIndex.value; });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade200)),
                      child: const Icon(Icons.add, color: Color(0xFF00BCD4), size: 20),
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

                    // Search Bar

                    Container(

                      height: 50,

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),

                      child: Row(

                        children: [

                          const SizedBox(width: 15),

                          Icon(Icons.search, color: Colors.grey.shade400, size: 20),

                          const SizedBox(width: 10),

                          Expanded(child: TextField(controller: _searchCtrl, decoration: InputDecoration(hintText: 'Search saved addresses, zip codes...', hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14), border: InputBorder.none))),

                          Icon(Icons.filter_alt_outlined, color: Colors.grey.shade400, size: 20),

                          const SizedBox(width: 15),

                        ],

                      ),

                    ),

                    const SizedBox(height: 15),



                    // Current GPS

                    Container(

                      padding: const EdgeInsets.all(15),

                      decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan.shade100)),

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

                                Text('Downtown, San Diego, CA', style: TextStyle(color: const Color(0xFF0F8A9E), fontSize: 12)),

                              ],

                            ),

                          ),

                      Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6), decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)), child: const Text('***', style: TextStyle(fontSize: 14, letterSpacing: 2, color: Colors.black))),
                        ],

                      ),

                    ),

                    const SizedBox(height: 25),



                    // Saved Addresses Title

                    ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: globalAddresses,
                      builder: (context, addresses, child) {
                        final filteredAddresses = _searchQuery.isEmpty ? addresses : addresses.where((addr) {
                          final query = _searchQuery.toLowerCase();
                          final addressText = (addr['address'] ?? '').toString().toLowerCase();
                          final name = (addr['name'] ?? '').toString().toLowerCase();
                          final title = (addr['title'] ?? '').toString().toLowerCase();
                          return addressText.contains(query) || name.contains(query) || title.contains(query);
                        }).toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('SAVED ADDRESSES (${filteredAddresses.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                                Text('Tap to select', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            if (filteredAddresses.isEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.shade200)),
                                child: Column(
                                  children: [
                                    Icon(Icons.location_off_outlined, color: Colors.grey.shade400, size: 40),
                                    const SizedBox(height: 10),
                                    Text('No addresses found.', style: TextStyle(color: Colors.grey.shade500, fontSize: 14)),
                                  ],
                                ),
                              ),
                            ...List.generate(filteredAddresses.length, (i) {
                              final addr = filteredAddresses[i];
                              final originalIndex = addresses.indexOf(addr);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: _buildAddressCard(
                                  index: originalIndex,
                                  icon: addr['isDefault'] == true ? Icons.home_outlined : Icons.business_center_outlined,
                                  title: addr['title'] ?? 'Address',
                                  pillText: addr['isDefault'] == true ? 'DEFAULT' : 'SAVED',
                                  isGreyPill: !(addr['isDefault'] == true),
                                  subtitle1: addr['isDefault'] == true ? 'Primary residence' : 'Secondary address',
                                  nameAndPhone: '${addr['name']}  |  ${addr['phone']}',
                                  addressText: addr['address'] ?? '',
                                  addr: addr,
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 10),
                    // Add New Address Button

                    GestureDetector(

                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddNewAddressScreen()));
                        if (mounted) setState(() { selectedAddress = globalSelectedAddressIndex.value; });
                      },

                      child: Container(

                        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 20),

                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF00BCD4).withOpacity(0.5), width: 2)), 

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [

                            Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: Colors.cyan.shade50, shape: BoxShape.circle), child: const Icon(Icons.add, color: Color(0xFF00BCD4), size: 16)),

                            const SizedBox(width: 10),

                            const Text('Add New Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                          ],

                        ),

                      ),

                    ),

                    const SizedBox(height: 25),



                    // Delivery Preferences

                    Container(

                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.gpp_good_outlined, color: Color(0xFF0F8A9E), size: 20),

                              SizedBox(width: 8),

                              Text('Delivery Preferences', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                            ],

                          ),

                          const SizedBox(height: 20),

                          Row(

                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [

                              Column(

                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [

                                  const Text('Leave at door if not home', style: TextStyle(fontSize: 13, color: Colors.black87)),

                                  const SizedBox(height: 4),

                                  Text('Driver will take photo proof of delivery', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                                ],

                              ),

                              Switch(value: prefLeaveAtDoor, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => prefLeaveAtDoor = val)),

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

                                        const Text('Eco-friendly minimal packaging', style: TextStyle(fontSize: 13, color: Colors.black87)),

                                        const SizedBox(width: 6),

                                        Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)), child: const Row(children: [Icon(Icons.eco, color: Colors.green, size: 10), SizedBox(width: 2), Text('Eco', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold))])),

                                      ],

                                    ),

                                    const SizedBox(height: 4),

                                    Text('100% biodegradable corrugated box', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

                                  ],

                                ),

                              ),

                              Switch(value: prefEco, activeColor: const Color(0xFF00BCD4), onChanged: (val) => setState(() => prefEco = val)),

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

                      onPressed: globalAddresses.value.isEmpty ? null : () => Navigator.pop(context, selectedAddress),

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.location_on_outlined, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Deliver to This Address', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),

                            ],

                          ),

                          Row(

                            children: [

                              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)), child: const Text('CONFIRM', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold))),

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

                      const Icon(Icons.verified_user, color: Color(0xFF0F8A9E), size: 14),

                      const SizedBox(width: 6),

                      Text('100% Guaranteed On-Time Safe Delivery', style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),

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



  Widget _buildAddressCard({

    required int index, required IconData icon, required String title, required String pillText, bool isGreyPill = false,

    required String subtitle1, required String nameAndPhone, required String addressText, Widget? extraWidget,

    required Map<String, dynamic> addr,

  }) {

    bool isSelected = selectedAddress == index;

    return GestureDetector(

      onTap: () {
        setState(() => selectedAddress = index);
        globalSelectedAddressIndex.value = index;
      },

      child: Container(

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade200, width: isSelected ? 2 : 1),

          boxShadow: isSelected ? [BoxShadow(color: const Color(0xFF00BCD4).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))] : [],

        ),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Row(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Container(

                  padding: const EdgeInsets.all(10),

                  decoration: BoxDecoration(color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),

                  child: Icon(icon, color: isSelected ? Colors.white : Colors.grey.shade600, size: 20),

                ),

                const SizedBox(width: 15),

                Expanded(

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Row(

                        children: [

                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),

                          const SizedBox(width: 8),

                          Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: isGreyPill ? Colors.grey.shade100 : const Color(0xFF00BCD4), borderRadius: BorderRadius.circular(6)), child: Text(pillText, style: TextStyle(color: isGreyPill ? Colors.grey.shade600 : Colors.white, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5))),

                        ],

                      ),

                      const SizedBox(height: 2),

                      Text(subtitle1, style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),

                    ],

                  ),

                ),

                Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFF00BCD4) : Colors.grey.shade300, size: 22),

              ],

            ),

            const SizedBox(height: 15),

            Text(nameAndPhone, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),

            const SizedBox(height: 6),

            Text(addressText, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.4)),

            if (extraWidget != null) extraWidget,

            const SizedBox(height: 15),

            Divider(height: 1, color: Colors.grey.shade100),

            const SizedBox(height: 15),

            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(isSelected ? 'Selected for this order' : 'Select this address', style: TextStyle(color: isSelected ? const Color(0xFF0F8A9E) : const Color(0xFF00BCD4), fontSize: 12, fontWeight: FontWeight.bold)),

                GestureDetector(

                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => EditAddressScreen(addressIndex: index, addressData: addr)));
                    if (mounted) setState(() { selectedAddress = globalSelectedAddressIndex.value; });
                  },

                  child: Row(

                    children: [

                      const Icon(Icons.edit, size: 14, color: Colors.black87),

                      const SizedBox(width: 4),

                      const Text('Edit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),

                    if (isSelected) ...[

                      const SizedBox(width: 10),

                      const Icon(Icons.more_vert, size: 16, color: Colors.grey),

                    ]

                  ],

                ),

               )

              ],

            )

          ],

        ),

      ),

    );

  }

}
