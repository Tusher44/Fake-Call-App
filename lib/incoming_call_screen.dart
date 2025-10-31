import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'receive_samsung.dart';
import 'receive_xiaomi.dart';
import 'receive_iphone.dart';

class IncomingCallScreen extends StatefulWidget {
  final String interface;
  const IncomingCallScreen({Key? key, required this.interface})
    : super(key: key);

  @override
  _IncomingCallScreenState createState() => _IncomingCallScreenState();
}

class _IncomingCallScreenState extends State<IncomingCallScreen> {
  late AudioPlayer _player;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _playRingtone();
  }

  Future<void> _playRingtone() async {
    String audioFile = '';
    switch (widget.interface) {
      case 'samsung':
        audioFile = 'audio/samsung_glaxy.mp3';
        break;
      case 'xiaomi':
        audioFile = 'audio/mi_remix.mp3';
        break;
      case 'iphone':
        audioFile = 'audio/iphone.mp3';
        break;
    }
    await _player.play(AssetSource(audioFile));
  }

  Future<void> _stopRingtone() async {
    await _player.stop();
  }

  Future<void> _onAccept() async {
    await _stopRingtone();

    Widget nextScreen;
    switch (widget.interface) {
      case 'samsung':
        nextScreen = const SamsungInterfaceScreen();
        break;
      case 'xiaomi':
        nextScreen = const XiaomiInterfaceScreen();
        break;
      case 'iphone':
        nextScreen = const IphoneInterfaceScreen();
        break;
      default:
        nextScreen = const SamsungInterfaceScreen();
    }

    // Fade transition for realism
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => nextScreen,
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 700),
      ),
    );
  }

  Future<void> _onDecline() async {
    await _stopRingtone();

    // Short vibration feedback (optional)
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 100);
    }

    // Show "Call Ended" dialog briefly, then close app automatically
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.black,
        content: const Text(
          'Call Ended',
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );

    // Wait 1 second, then close the app
    await Future.delayed(const Duration(seconds: 1));

    // Close the dialog if still open
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }

    // Exit the app completely
    exit(0);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2), // Push top section down a bit
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/pictures/images.png'),
            ),
            const SizedBox(height: 30),
            const Text(
              'Incoming Call',
              style: TextStyle(color: Colors.black54, fontSize: 20),
            ),
            const SizedBox(height: 8),
            const Text(
              'Private Number',
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const Spacer(flex: 3), // Pushes buttons lower dynamically
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end, size: 32),
                  onPressed: _onDecline,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.call, size: 32),
                  onPressed: _onAccept,
                ),
              ],
            ),
            const SizedBox(height: 50), // adds fixed gap from bottom
          ],
        ),
      ),
    );
  }
}
