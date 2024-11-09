import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const Center(
        child: Text(
          '¡Bienvenido a TragoVoltaje!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
