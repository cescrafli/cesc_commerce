import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

state_start = r"""class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameCtrl = TextEditingController(text: 'Cesc Fabregas');"""
  
state_new = r"""class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  int selectedLabel = 0; // 0: Home, 1: Office, 2: Parents
  bool isDefault = true;
  bool isEco = true;
  final TextEditingController nameCtrl = TextEditingController(text: 'Cesc Fabregas');"""

content = content.replace(state_start, state_new)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Restored original variables!")
