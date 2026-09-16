import codecs

with codecs.open('lib/main.dart', 'r', 'utf-8') as f:
    content = f.read()

bad_end = '''              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
class ProfileScreen'''

good_end = '''              const SizedBox(height: 80),
            ],
          ),
        );
          }
        ),
      ),
    );
  }
}
class ProfileScreen'''

content = content.replace(bad_end, good_end)

with codecs.open('lib/main.dart', 'w', 'utf-8') as f:
    f.write(content)
