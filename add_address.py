import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# Add controllers
state_start = r"class _AddNewAddressScreenState extends State<AddNewAddressScreen> \{"
state_new = r"""class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final TextEditingController nameCtrl = TextEditingController(text: 'Cesc Fabregas');
  final TextEditingController phoneCtrl = TextEditingController(text: '(858) 555-0192');
  final TextEditingController streetCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  final TextEditingController zipCtrl = TextEditingController();
"""

content = re.sub(state_start, state_new, content)

# Link controllers to TextFields
content = content.replace("TextField(\n                        decoration: InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', suffixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),\n                        style: TextStyle(fontSize: 14),\n                      )", "TextField(controller: nameCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: 'Cesc Fabregas', suffixIcon: Icon(Icons.person_outline, color: Colors.grey, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)), style: const TextStyle(fontSize: 14))")
content = content.replace("TextField(\n                              decoration: InputDecoration(border: InputBorder.none, hintText: '(858) 555-0192', suffixIcon: Icon(Icons.check, color: Colors.green, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)),\n                              style: TextStyle(fontSize: 14),\n                            )", "TextField(controller: phoneCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: '(858) 555-0192', suffixIcon: Icon(Icons.check, color: Colors.green, size: 20), suffixIconConstraints: BoxConstraints(minWidth: 20)), style: const TextStyle(fontSize: 14))")
content = content.replace("TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '123 Main Street'), style: TextStyle(fontSize: 14))", "TextField(controller: streetCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: '123 Main Street'), style: const TextStyle(fontSize: 14))")
content = content.replace("TextField(decoration: InputDecoration(border: InputBorder.none, hintText: 'San Diego'), style: TextStyle(fontSize: 14))", "TextField(controller: cityCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: 'San Diego'), style: const TextStyle(fontSize: 14))")
content = content.replace("TextField(decoration: InputDecoration(border: InputBorder.none, hintText: '92101'), style: TextStyle(fontSize: 14))", "TextField(controller: zipCtrl, decoration: InputDecoration(border: InputBorder.none, hintText: '92101'), style: const TextStyle(fontSize: 14))")

# Add save logic
save_logic = """onPressed: () {
                        final current = List<Map<String, dynamic>>.from(globalAddresses.value);
                        current.add({
                          'title': selectedLabel == 0 ? 'Home' : selectedLabel == 1 ? 'Office' : 'Parents',
                          'isPrimary': isDefault,
                          'name': nameCtrl.text.isEmpty ? 'Cesc' : nameCtrl.text,
                          'phone': phoneCtrl.text.isEmpty ? 'Phone' : phoneCtrl.text,
                          'detail': '${streetCtrl.text}, ${cityCtrl.text}, CA ${zipCtrl.text}'
                        });
                        if (isDefault) {
                          for(var a in current) a['isPrimary'] = false;
                          current.last['isPrimary'] = true;
                        }
                        globalAddresses.value = current;
                        Navigator.pop(context);
                      },"""
content = content.replace("onPressed: () => Navigator.pop(context),", save_logic)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Added AddNewAddress functionality!")
