import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cesc_commerce/core/localization.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/widgets.dart';
import 'package:cesc_commerce/core/services/product_service.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  Future<List<Map<String, dynamic>>>? _searchFuture;
  List<String> recentSearches = ['T-Shirt Mens', 'Sneakers White', 'Jacket Denim'];
  String _query = '';

  void _onSearchChanged(String value) {
    setState(() {
      _query = value.toLowerCase();
      _searchFuture = null;
    });
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _searchFuture = ProductService().searchProducts(_query);
      });
    });
  }

  void _triggerSearch(String tag) {
    _searchController.text = tag;
    setState(() {
      _query = tag.toLowerCase();
      _searchFuture = ProductService().searchProducts(_query);
    });
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: globalLanguage,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: tr('search'),
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey, size: 18),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : const Icon(Icons.search, color: Colors.grey, size: 18),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor.withValues(alpha: 0.5)),
                ),
              ),
            ),
          ),
          body: _query.isEmpty
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (recentSearches.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tr('recent_search'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              TextButton(
                                onPressed: () => setState(() => recentSearches.clear()),
                                child: Text(tr('clear_all'), style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ),
                            ],
                          ),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: recentSearches.map((term) => GestureDetector(
                              onTap: () => _triggerSearch(term),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Text(term, style: const TextStyle(fontSize: 13, color: Colors.black87)),
                              ),
                            )).toList(),
                          ),
                          const SizedBox(height: 30),
                        ],
                        Text(tr('trending_now'), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: ['Smart Watches', 'Summer Collection', 'Running Shoes', 'Wireless Earbuds'].map((trend) =>
                            GestureDetector(
                              onTap: () => _triggerSearch(trend),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.3)),
                                ),
                                child: Text(trend, style: TextStyle(fontSize: 13, color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ).toList(),
                        ),
                      ],
                    ),
                  ),
                )
              : _searchFuture == null
                  ? const Center(child: CircularProgressIndicator())
                  : FutureBuilder<List<Map<String, dynamic>>>(
                  future: _searchFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text('No results found for "${_query}"'),
                      );
                    }
                    
                    final results = snapshot.data!;
                    return GridView.builder(
                      padding: const EdgeInsets.all(20),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          product: results[index],
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
