import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

bad_logic = """onPressed: () {
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

content = content.replace(bad_logic, "onPressed: () => Navigator.pop(context),")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Restored all the popped navigators!")
