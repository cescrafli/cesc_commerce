import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

old_part_pattern = r"Row\(\s*mainAxisAlignment: MainAxisAlignment\.spaceBetween,\s*children: \[\s*const Text\('SAVED ADDRESSES \(3\)', style: TextStyle\(fontWeight: FontWeight\.bold, fontSize: 13, letterSpacing: 0\.5\)\).*?// Add New Address Button"

new_part = r'''ValueListenableBuilder<List<Map<String, dynamic>>>(
                      valueListenable: globalAddresses,
                      builder: (context, addresses, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('SAVED ADDRESSES (${addresses.length})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.5)),
                                Text('Tap to select', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ...List.generate(addresses.length, (index) {
                              final addr = addresses[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: _buildAddressCard(
                                  index: index,
                                  icon: addr['isPrimary'] == true ? Icons.home_outlined : Icons.business_center_outlined,
                                  title: addr['title'] ?? 'Address',
                                  pillText: addr['isPrimary'] == true ? 'DEFAULT' : 'SAVED',
                                  isGreyPill: !(addr['isPrimary'] == true),
                                  subtitle1: addr['isPrimary'] == true ? 'Primary residence' : 'Secondary address',
                                  nameAndPhone: '${addr['name']}  |  ${addr['phone']}',
                                  addressText: addr['detail'] ?? '',
                                ),
                              );
                            }),
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 10),
                    // Add New Address Button'''

content = re.sub(old_part_pattern, new_part, content, flags=re.DOTALL)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print('Done address list!')
