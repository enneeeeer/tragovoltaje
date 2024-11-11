import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos de servicio'),
      ),
      body: Center(
        child: Text('Estos son nuestros términos de servicio.'),
      ),
    );
  }
}