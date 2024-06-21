// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

List<Widget> _extractCodeBlocks(String text) {
    final codeBlockRegExp = RegExp(r'```(\w+)\n([\s\S]*?)```', multiLine: true);
    final matches = codeBlockRegExp.allMatches(text);
    List<Widget> codeBlocks = [];

    String cleanedText = text;

    for (final match in matches) {
      final language = match.group(1);
      final code = match.group(2);

      if (language != null && code != null) {
        // print('Dil: $language');
        // print('Kod: $code');
        cleanedText = cleanedText.replaceFirst(match.group(0)!, '');
        

        final syntax = _getSyntax(language);
        codeBlocks.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: SyntaxView(
            code: code,
            syntax: syntax,
            syntaxTheme: SyntaxTheme.vscodeDark(),
            fontSize: 12.0,
            withZoom: true,
            withLinesCount: true,
            expanded: false,
            selectable: true,
          ),
        ));
      }
    }

    // Add the remaining text without code blocks
    if (cleanedText.trim().isNotEmpty) {
      codeBlocks.insert(0, Text(
        cleanedText,
        style: const TextStyle(
          color: Colors.black,
        ),
      ));
    }

    return codeBlocks;
  }

  Syntax _getSyntax(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Syntax.DART;
      case 'python':
        return Syntax.JAVA;
      case 'javascript':
        return Syntax.JAVASCRIPT;
      // Add more cases for other languages as needed
      default:
        return Syntax.DART; // Default to Dart if language is not recognized
    }
}