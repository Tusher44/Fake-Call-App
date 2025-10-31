import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'interface_select.dart';
import 'incoming_call_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? selectedInterface = prefs.getString('interface');

  runApp(FakeCallApp(selectedInterface: selectedInterface));
}

class FakeCallApp extends StatelessWidget {
  final String? selectedInterface;

  const FakeCallApp({Key? key, this.selectedInterface}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fake Call',
      home: selectedInterface == null
          ? const InterfaceSelectScreen()
          : IncomingCallScreen(interface: selectedInterface!),
    );
  }
}
