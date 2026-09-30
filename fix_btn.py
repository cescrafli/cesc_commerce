import codecs
import re

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

# We need to find the specific one inside AddNewAddressScreen.
# The button has text 'Save & Use This Address'

old_btn = r"""onPressed: () => Navigator.pop(context),

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.location_on_outlined, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Save & Use This Address',"""

new_btn = r"""onPressed: () {
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
                      },

                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00BCD4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          const Row(

                            children: [

                              Icon(Icons.location_on_outlined, color: Colors.white, size: 18),

                              SizedBox(width: 8),

                              Text('Save & Use This Address',"""

# Need to handle newlines which might have \r\n
old_btn = old_btn.replace('\n', '\r?\n')

content = re.sub(old_btn, new_btn, content)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Injected into Save & Use This Address correctly!")
