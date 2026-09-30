import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class CescCommerceApp extends StatelessWidget {

  const CescCommerceApp({super.key});



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Cescrafli',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        // WARNA UTAMA DIUBAH KE CYAN SESUAI LOGO BARU

        primaryColor: const Color(0xFF18C5DF),

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF18C5DF)),

        useMaterial3: true,

        scaffoldBackgroundColor: const Color(0xFFF9F9F9),

        

      ),

      home: const SplashScreen(), 

    );

  }

}
