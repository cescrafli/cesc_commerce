import codecs, re

with codecs.open('lib/screens/product/favorite_screen.dart', 'r', 'utf-8') as f:
    content = f.read()

# Fix const Text(tr('...'))
content = content.replace("const Text(tr('wishlist')", "Text(tr('wishlist')")
content = content.replace("const Text(tr('empty_wishlist')", "Text(tr('empty_wishlist')")
content = content.replace("const Text(tr('add_all_to_cart')", "Text(tr('add_all_to_cart')")

# The original end was:
#           ),
#         );
#       },
#     );
#   }
# }
# Wait, let's see how many `return` and `{` we have.
# build method:
# return ValueListenableBuilder<String>(
#   builder: (context, lang, _) {
#     return Scaffold(
#       body: SafeArea(
#         child: ValueListenableBuilder<List<Map<String, dynamic>>>(
#           builder: (context, wishlist, _) {
#             return Column( ... );
#           }
#         ),
#       ),
#     );
#   }
# );
#
# So the end SHOULD be:
#           }
#         ),
#       ),
#     );
#       }
#     );
#   }
# }

new_end = """
            ],
          ),
        );
          }
        ),
      ),
    );
      }
    );
  }
}
"""

content = re.sub(r"            \],\s*\),\s*\);\s*\}\s*\),\s*\),\s*\);\s*\}\s*\),\s*\}\s*\}", new_end, content)
content = re.sub(r"            \],\s*\),\s*\);\s*\}\s*\),\s*\),\s*\);\s*\}\s*\}", new_end, content)

with codecs.open('lib/screens/product/favorite_screen.dart', 'w', 'utf-8') as f:
    f.write(content)
print("Fav AST fixed")
