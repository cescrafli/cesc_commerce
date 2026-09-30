import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  try {

    await Firebase.initializeApp(options: const FirebaseOptions(apiKey: 'AIzaSyBIutP51v_UR1K6moaoiz17Vr3tk74Zn6c', appId: '1:663051170103:android:9ca4a1f3af04465b5aaab2', messagingSenderId: '663051170103', projectId: 'cesc-commerce', storageBucket: 'cesc-commerce.firebasestorage.app'));

  } catch(e) { print('Firebase Error: $e'); }

  runApp(const ProviderScope(child: CescCommerceApp()));

}


