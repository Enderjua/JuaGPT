// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyAIUqlPYIG4s_G2_QVJxJ4dGN6EwqLAaag';

Future<String?> textToText(String text) async {
  final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);

  final content = [Content.text(text)];
  final response = await model.generateContent(content);

  return response.text;
}

