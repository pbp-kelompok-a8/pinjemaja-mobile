import 'package:flutter/material.dart';
import 'package:pinjem_aja_mobile/main.dart';

class ChatScreen extends StatelessWidget {
  final IconData icon;
  final String title;
  const ChatScreen({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(icon, size: 72, color: AppColors.secondary),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Modul belum diisi',
              style: TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}