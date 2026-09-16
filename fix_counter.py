import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

bad_string = "ValueListenableBuilder<List<Map<String, dynamic>>>(\n                          valueListenable: globalWishlist,\n                          builder: (context, wl, _) => Text(' saved items' , style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),"

good_string = "ValueListenableBuilder<List<Map<String, dynamic>>>(\n                          valueListenable: globalWishlist,\n                          builder: (context, wl, _) => Text('${wl.length} saved items' , style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),\n                        )"

content = content.replace(bad_string, good_string)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
