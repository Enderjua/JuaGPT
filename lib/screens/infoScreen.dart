// ignore_for_file: file_names

import 'package:JuaGPT/screens/temporayScreen.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  void _navigateBackToTemporaryChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TemporaryChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Geçici sohbet',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.history, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sohbet Geçmişi Tutulmuyor',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Geçici sohbetler aracılığıyla kurduğunuz diyaloglar saklanmayacak. Ne sunucularımızda ne de lokal cihazınızda veriler depolanmayacaktır.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(Icons.description, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Sansür uygulanır',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Geçici sohbet kullansanız dâhi model, Gemini sansürlerine maruz kalmaya devam eder.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 30),
            const Row(
              children: [
                Icon(Icons.model_training, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Model eğitimi yok',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Geçici sohbetler Schweis INC kapsamındaki herhangi bir uygulama eğitimi için kullanılmaz. Fakat Google Gemini eğitimi için kullanılabilir.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () => _navigateBackToTemporaryChat(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50), // Butonun tam genişlikte olmasını sağlar
                ),
                child: const Text(
                  'Devam et',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
