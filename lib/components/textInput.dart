// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.width,
    required this.height,
    required this.hinText,
    required this.icon,
    required TextEditingController controller,
    required this.obscureText,
  }) : _controller = controller;

  final double width;
  final double height;
  final String hinText;
  final IconData icon;
  final TextEditingController _controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Color(0xFF272728), // Arka plan rengi
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)), // Yuvarlatılmış köşeler
          boxShadow: [
            const BoxShadow(
              // Gölgeler
              color: Color(0xFF4A4A4A), // Gölge rengi
              offset: Offset(-4.0, -4.0), // Gölgenin konumu (x, y)
              blurRadius: 0.01, // Gölgenin bulanıklığı
              spreadRadius: 0.00001, // Gölgenin yayılma yarıçapı
            ),
          ],
        ),
        child: TextField(
      decoration: InputDecoration(
        hintText: hinText,
        icon: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: FaIcon(icon, color: const Color(0xFF747475),),
        ),
        // contentPadding: EdgeInsets.only(right: 4.0),
        hintStyle: const TextStyle(
          color: Color(0xFF747475),
          fontSize: 18.0
        ),
        border: InputBorder.none,
        
    
      ),
      controller: _controller,
      obscureText: obscureText,
        ),
      ),
    );
  }
}