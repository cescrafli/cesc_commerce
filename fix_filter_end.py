import codecs

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'r', 'utf-8') as f:
    lines = f.readlines()

new_lines = []
for i in range(len(lines)):
    if 'Row(' in lines[i] and i > 105:
        # We found the outer Row
        new_lines.extend(lines[:i])
        new_lines.append("""Row(
      children: [
        Text('Reset', style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(width: 15),
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.pop(context, {'price': _priceRange, 'categories': selectedCategories}),
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: const Color(0xFF0F8A9E), borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Apply Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(10)), child: const Text('24', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)))
                ]
              )
            ),
          )
        )
      ]
    )
  ]
)
);
}

Widget _buildSectionTitle(String title, Widget? rightWidget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      if (rightWidget != null) rightWidget,
    ]
  );
}
}
""")
        break

with codecs.open('lib/widgets/filter_bottom_sheet.dart', 'w', 'utf-8') as f:
    f.write(''.join(new_lines))
print("Done")
