// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final bool enable;

  const CustomTextInput({super.key, required this.controller, this.enable = true});

  @override
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      enabled: widget.enable,
      onChanged: (text) {
        setState(() {
          _isTyping = text.isNotEmpty;
        });
      },
      decoration: InputDecoration(
        hintText: 'İleti',
        prefixIcon: Icon(Icons.mic, color: _isTyping ? Colors.transparent : Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          
        ),
        filled: true,
        fillColor: Colors.grey.shade800,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      ),
    );
  }
}
