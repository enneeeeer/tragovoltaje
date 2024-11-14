import 'package:flutter/material.dart';

class ConectarPulsera extends StatelessWidget {
  const ConectarPulsera({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text('CONECTA TU PULSERA',
                style: TextStyle(
                  fontSize: 32,
                  color: const Color.fromARGB(255, 244, 83, 3),
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: const Color.fromARGB(255, 255, 162, 68),
                      offset: Offset(0.0, 0.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 25),
          Image.asset(
            'assets/images/blutu.png', // Ruta
            width: 150, //  ancho
            height: 150, // altura
          ),
          SizedBox(height: 25),
          Text(
            'Activa tu Bluetooth',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              backgroundColor: Colors.amber[700],
            ),
            onPressed: () {
              // Boton sin funcionamiento por ahora
            },
            child: Text(
              'CONECTAR',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
