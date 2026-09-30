import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

old_main = '''void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {'''
  
new_main = '''import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Disable edge-to-edge and restore solid navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    )
  );
  
  try {'''

content = content.replace(old_main, new_main)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("SystemChrome fixed!")
