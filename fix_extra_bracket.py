import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

bad_string = '''  }
}

}
class CategoryProductsScreen extends StatelessWidget {'''

fixed_string = '''  }
}

class CategoryProductsScreen extends StatelessWidget {'''

if bad_string in content:
    content = content.replace(bad_string, fixed_string)
    print("Fixed extra bracket!")

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
