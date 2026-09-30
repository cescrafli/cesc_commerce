import re

# ORDER TRACKING
with open('lib/screens/profile/order_tracking_screen.dart', 'r', encoding='utf-8') as f:
    trk = f.read()

# Fix total price logic (15 -> 30 for 2 items)
trk = trk.replace("const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))", "const Text('\.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))")

# Fix Copy button
old_copy = '''                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                                        child: Row(
                                          children: [
                                            Icon(Icons.copy, color: Colors.grey.shade600, size: 14),
                                            const SizedBox(width: 4),
                                            Text('Copy', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                                          ]
                                        ),
                                      ),'''
new_copy = '''                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(const ClipboardData(text: 'FDX-8829194'));
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tracking number copied!')));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                                          child: Row(
                                            children: [
                                              Icon(Icons.copy, color: Colors.grey.shade600, size: 14),
                                              const SizedBox(width: 4),
                                              Text('Copy', style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                                            ]
                                          ),
                                        ),
                                      ),'''
trk = trk.replace(old_copy, new_copy)

if 'package:flutter/services.dart' not in trk:
    trk = trk.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:flutter/services.dart';")

with open('lib/screens/profile/order_tracking_screen.dart', 'w', encoding='utf-8') as f:
    f.write(trk)

# PROFILE SCREEN
with open('lib/screens/profile/profile_screen.dart', 'r', encoding='utf-8') as f:
    prof = f.read()

old_more = '''              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                child: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
              )'''
new_more = '''              GestureDetector(
                onTap: () => showModalBottomSheet(context: context, builder: (_) => Container(height: 100, child: Center(child: Text('More options coming soon')))),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.more_horiz, color: Colors.white, size: 20),
                ),
              )'''
prof = prof.replace(old_more, new_more)

with open('lib/screens/profile/profile_screen.dart', 'w', encoding='utf-8') as f:
    f.write(prof)

print('Fixed batch4.2')
