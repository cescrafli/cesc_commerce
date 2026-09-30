import 'package:flutter/material.dart';
import '../core/localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cesc_commerce/core/globals.dart';
import 'package:cesc_commerce/screens.dart';
import 'package:cesc_commerce/widgets.dart';

class LanguageSelector extends StatefulWidget {

  final Color bgColor;

  final Color textColor;

  final bool showLanguageIcon;



  const LanguageSelector({

    super.key,

    this.bgColor = Colors.white,

    this.textColor = Colors.black,

    this.showLanguageIcon = false,

  });



  @override

  State<LanguageSelector> createState() => _LanguageSelectorState();

}

class _LanguageSelectorState extends State<LanguageSelector> {

  



  @override

  Widget build(BuildContext context) {

    return Container(

      decoration: BoxDecoration(color: widget.bgColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade200)),

      child: PopupMenuButton<String>(

        onSelected: (String value) {

          setState(() {

            globalLanguage.value = value;

          });

        },

        offset: const Offset(0, 40),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[

          const PopupMenuItem<String>(value: 'EN (US)', child: Text('EN (US) - English')),

          const PopupMenuItem<String>(value: 'ID (ID)', child: Text('ID (ID) - Indonesia')),

          const PopupMenuItem<String>(value: 'ES (ES)', child: Text('ES (ES) - Espanol')),

          const PopupMenuItem<String>(value: 'ZH (CN)', child: Text('ZH (CN) - Chinese')),

        ],

        child: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

          child: Row(

            mainAxisSize: MainAxisSize.min,

            children: [

              if (widget.showLanguageIcon)

                const Icon(Icons.language, color: Color(0xFF006C7A), size: 14)

              else

                const Icon(Icons.circle, color: Color(0xFF00BCD4), size: 8),

              const SizedBox(width: 6),

              Text(globalLanguage.value, style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold, fontSize: 12)),

              const SizedBox(width: 4),

              Icon(Icons.arrow_drop_down, color: widget.textColor, size: 16),

            ],

          ),

        ),

      ),

    );

  }

}
