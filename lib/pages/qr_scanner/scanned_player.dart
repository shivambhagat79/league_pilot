import 'package:flutter/material.dart';

class ScannedPlayerPage extends StatefulWidget {
  final String scannedString;
  const ScannedPlayerPage({super.key, required this.scannedString});

  @override
  State<ScannedPlayerPage> createState() => _ScannedPlayerPageState();
}

class _ScannedPlayerPageState extends State<ScannedPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          widget.scannedString,
        ),
      ),
    );
  }
}
