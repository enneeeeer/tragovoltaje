import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ayuda'),
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
              Text.rich(
                TextSpan(
                  text: 'Preguntas Frecuentes',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text('¿Qué es tragovoltaje?'),
              SizedBox(height: 20),
              Text('¿Cómo emparejar la pulsera a la app?'),
              SizedBox(height: 20),
              Text('¿Cómo funciona el sistema de descargas? ¿Es seguro?'),
              SizedBox(height: 20),
              Text('¿Cómo cambiar la intensidad de las descargas?'),
              SizedBox(height: 20),
              Text('¿Qué modos de juegos estan disponibles?'),
              SizedBox(height: 20),
              Text('¿Qué modos de juegos estan disponibles en el plan Premium?'),
              SizedBox(height: 20),
              Text('¿Qué hacer si la pulsera se desconecta mediante el juego?'),
              SizedBox(height: 20),
              Text('¿Cómo configuro mis propios desafios y preguntas?'),
              SizedBox(height: 20),
              Text('¿Cómo conectar mas jugadores a la app?'),
            ],
          ),
        ),
      ),
    );
  }
}
