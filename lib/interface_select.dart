import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class InterfaceSelectScreen extends StatelessWidget {
  const InterfaceSelectScreen({Key? key}) : super(key: key);

  Future<void> _saveSelection(BuildContext context, String interface) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('interface', interface);

    // Show confirmation message before closing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        content: const Text(
          'Interface saved.\nPlease restart the app.',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );

    // Wait a bit so the user can read the message
    await Future.delayed(const Duration(seconds: 2));

    // Close the dialog if it's still open
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    // Exit the app
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Interface',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _saveSelection(context, 'samsung'),
              child: const Text('Samsung Interface'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveSelection(context, 'xiaomi'),
              child: const Text('Xiaomi Interface'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveSelection(context, 'iphone'),
              child: const Text('iPhone Interface'),
            ),
          ],
        ),
      ),
    );
  }
}
