import 'package:flutter/material.dart';

class CurrentVersionPage extends StatelessWidget {
  const CurrentVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Versión Actual'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Esta ejecutando la version 1.0.0 de nuestra aplicación Tragovoltaje'),
            ],
          ),
        ),
      ),
    );
  }
}
