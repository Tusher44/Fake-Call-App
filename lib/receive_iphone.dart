import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class IphoneInterfaceScreen extends StatefulWidget {
  const IphoneInterfaceScreen({Key? key}) : super(key: key);

  @override
  _IphoneInterfaceScreenState createState() => _IphoneInterfaceScreenState();
}

class _IphoneInterfaceScreenState extends State<IphoneInterfaceScreen> {
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Column(
                children: [
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
                      color: Color.fromARGB(255, 5, 5, 5),
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    formattedTime,
                    style: const TextStyle(
                      color: Color.fromARGB(137, 0, 0, 0),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'iPhone Call',
                    style: TextStyle(
                      color: Color.fromARGB(96, 0, 0, 0),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Controls - iPhone style
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _IphoneButton(icon: Icons.mic_off, label: 'Mute'),
                  _IphoneButton(icon: Icons.volume_up, label: 'Speaker'),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.call_end),
                    onPressed: () => exit(0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IphoneButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IphoneButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey.shade800,
          child: Icon(icon, color: Colors.white, size: 28),
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
