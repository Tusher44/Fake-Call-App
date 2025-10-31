import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class SamsungInterfaceScreen extends StatefulWidget {
  const SamsungInterfaceScreen({Key? key}) : super(key: key);

  @override
  _SamsungInterfaceScreenState createState() => _SamsungInterfaceScreenState();
}

class _SamsungInterfaceScreenState extends State<SamsungInterfaceScreen> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get formattedTime {
    final minutes = (_seconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 254, 254),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Caller Info Section
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
                  const Text(
                    'Call in progress',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage(
                      'assets/pictures/images.png',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Private Number',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Mobile call',
                    style: TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Call control buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _SamsungButton(icon: Icons.mic_off, label: 'Mute'),
                  _SamsungButton(icon: Icons.dialpad, label: 'Keypad'),
                  _SamsungButton(icon: Icons.volume_up, label: 'Speaker'),
                ],
              ),
            ),

            // Bottom Call End Button (Samsung-style oval)
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: GestureDetector(
                onTap: () => exit(0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade700,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SamsungButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SamsungButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade900,
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
