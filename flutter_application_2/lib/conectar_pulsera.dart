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
            color: Colors.amber[700], 
            child: Text(
              'CONECTA TU PULSERA',
              style: TextStyle(
                color: Colors.black, 
                fontSize: 24, 
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 25), 
          Image.asset(
            'assets/blutu.png', // Ruta 
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
