import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class NewsDetailScreen extends StatelessWidget {
  final Map<String, dynamic> news;
  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(news['image'], width: double.infinity, height: 250, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(news['title'], style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Text(news['body'], style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87)),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Go Back', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
