import 'package:flutter/material.dart';

class ModosJuego extends StatelessWidget {
  const ModosJuego({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text('Modos de Juego'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              onPressed: () {
                // Acción para empezar a jugar
              },
              child: Text(
                'EMPIEZA A JUGAR',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona modo de juego:',
              style: TextStyle(fontSize: 18, color: Colors.amber),
            ),
            SizedBox(height: 20),
            GameModeButton(text: 'Modo básico', color: Colors.teal),
            GameModeButton(text: 'Modo aventura', color: Colors.teal),
            GameModeButton(text: 'Modo desafío', color: Colors.teal),
            GameModeButton(text: 'Modo confesiones', color: Colors.teal),
          ],
        ),
      ),
    );
  }
}

class GameModeButton extends StatelessWidget {
  final String text;
  final Color color;

  GameModeButton({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        ),
        onPressed: () {
          // Acción para cada modo de juego
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}