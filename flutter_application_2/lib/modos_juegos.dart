import 'package:flutter/material.dart';
import 'modo_basico_page.dart'; // Importar la nueva página
import 'modo_aventura_page.dart'; // Importar la nueva página
import 'modo_confesiones_page.dart'; // Importar la nueva página
import 'modo_desafio_page.dart'; // Importar la nueva página
import 'modo_extremo_page.dart'; // Importar la nueva página

class ModosJuego extends StatelessWidget {
  const ModosJuego({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'EMPIEZA A JUGAR',
              style: TextStyle(
                fontSize: 32,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.blueAccent,
                    offset: Offset(0.0, 0.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona modo de juego:',
              style: TextStyle(fontSize: 18, color: Colors.lightBlue),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  GameModeCard(text: 'Modo básico', image: 'assets/images/green.jpg'),
                  GameModeCard(text: 'Modo aventura', image: 'assets/images/azul.jpeg'),
                  GameModeCard(text: 'Modo desafío', image: 'assets/images/anaranjado.jpg'),
                  GameModeCard(text: 'Modo confesiones', image: 'assets/images/rojo.jpg'),
                  GameModeCard(text: 'Modo Extremo', image: 'assets/images/negro.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameModeCard extends StatelessWidget {
  final String text;
  final String image;

  GameModeCard({required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // Navegar a la nueva página de Ruleta
          if (text == 'Modo básico') {  
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoBasicoPage()));  
          } else if (text == 'Modo aventura') {  
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoAventuraPage()));  
          } else if (text == 'Modo desafío') {  
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoDesafioPage()));  
          } else if (text == 'Modo confesiones') {  
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoConfesionesPage()));  
          } else if (text == 'Modo Extremo') {  
            Navigator.push(context, MaterialPageRoute(builder: (context) => ModoExtremoPage()));  
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}