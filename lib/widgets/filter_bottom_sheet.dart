import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final RangeValues _priceRange = const RangeValues(15, 85);
  final List<String> selectedCategories = ['T-Shirts', 'Pants'];
  final List<String> selectedEco = ['Eco-Friendly', 'Organic Cotton'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: 40, height: 5,
              decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Filter', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Price Range', null),
                  RangeSlider(
                    values: _priceRange, min: 0, max: 200, activeColor: const Color(0xFF0F8A9E), inactiveColor: Colors.grey.shade200,
                    onChanged: (val) {},
                  ),
                  _buildSectionTitle('Categories', null),
                  Wrap(
                    spacing: 10,
                    children: ['T-Shirts', 'Pants', 'Outerwear', 'Shoes', 'Accessories'].map((c) {
                      bool isSel = selectedCategories.contains(c);
                      return ChoiceChip(
                        label: Text(c), selected: isSel, onSelected: (v) {},
                        selectedColor: const Color(0xFF0F8A9E), labelStyle: TextStyle(color: isSel ? Colors.white : Colors.black),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Reset'),
                  )
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, {'price': _priceRange, 'categories': selectedCategories}),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F8A9E)),
                    child: const Text('Apply Filter', style: TextStyle(color: Colors.white)),
                  )
                )
              ]
            )
          )
        ]
      )
    );
  }

  Widget _buildSectionTitle(String title, Widget? rightWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          if (rightWidget != null) rightWidget,
        ]
      )
    );
  }
}
