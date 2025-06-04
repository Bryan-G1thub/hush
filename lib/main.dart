import 'package:flutter/material.dart';

void main() {
  runApp(const HushApp());
}

class HushApp extends StatelessWidget {
  const HushApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hush',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Hush')),
      body: const Center(
        child: Text(
          'Let’s build something great.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
