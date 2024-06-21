// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInput extends StatelessWidget {
  const CodeInput({
    super.key,
    required this.width,
    required this.height,
    required this.focusNode,
    required this.borderColor,
    required TextEditingController controller,
  }) : _controller = controller;

  final double width;
  final double height;
  final TextEditingController _controller;
  final Color borderColor;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 40.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF272728), // Arka plan rengi
          borderRadius: const BorderRadius.all(
              Radius.circular(10.0)), // Yuvarlatılmış köşeler
          border: Border.all(
            color: borderColor,
            width: 0.5, // İnce kenarlık
          ),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          keyboardType: TextInputType.number, // Sadece rakam girişine izin ver
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],

          decoration: const InputDecoration(
            // contentPadding: EdgeInsets.only(right: 4.0),
            hintStyle: TextStyle(color: Color(0xFF747475), fontSize: 18.0),
            border: InputBorder.none,
            counterText: '',
          ),
          controller: _controller,
          focusNode: focusNode,
        ),
      ),
    );
  }
}
