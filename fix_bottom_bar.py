import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

old_bottom_bar = '''        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0,
          color: Colors.white,
          child: SizedBox(
            height: 60,
            child: Row('''

new_bottom_bar = '''        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10.0,
          color: Colors.white,
          child: Container(
            height: 60 + MediaQuery.of(context).padding.bottom,
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Row('''

content = content.replace(old_bottom_bar, new_bottom_bar)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)

print("Fixed BottomAppBar!")
