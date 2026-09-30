import 'package:flutter/material.dart';

import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class TrackingScreen extends StatelessWidget { const TrackingScreen({super.key}); @override Widget build(BuildContext context) { return Scaffold(appBar: AppBar(title: const Text('Track Order', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)), body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.local_shipping, size: 100, color: Theme.of(context).primaryColor), const SizedBox(height: 30), const Text('Your order is on the way!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(height: 20), ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor), child: const Text('Done', style: TextStyle(color: Colors.white)))]))); } }
