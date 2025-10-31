import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class XiaomiInterfaceScreen extends StatefulWidget {
  const XiaomiInterfaceScreen({Key? key}) : super(key: key);

  @override
  _XiaomiInterfaceScreenState createState() => _XiaomiInterfaceScreenState();
}

class _XiaomiInterfaceScreenState extends State<XiaomiInterfaceScreen> {
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Caller info section
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  const Text(
                    'Call in progress',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
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
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Mobile Call',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Middle Control Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  _XiaomiButton(icon: Icons.mic_off, label: 'Mute'),
                  _XiaomiButton(icon: Icons.dialpad, label: 'Keypad'),
                  _XiaomiButton(icon: Icons.volume_up, label: 'Speaker'),
                ],
              ),
            ),

            // Bottom Red End Button
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: GestureDetector(
                onTap: () => exit(0),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35,
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

class _XiaomiButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _XiaomiButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.black87, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ],
    );
  }
}
