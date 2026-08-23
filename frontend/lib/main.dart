import 'package:flutter/material.dart';

void main() {
  runApp(const AutiSenseApp());
}

class AutiSenseApp extends StatelessWidget {
  const AutiSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutiSense',
      home: Scaffold(
        body: Center(
          child: Text(
            'Welcome to AutiSense',
            style: TextStyle(fontSize: 28),
          ),
        ),
      ),
    );
  }
}