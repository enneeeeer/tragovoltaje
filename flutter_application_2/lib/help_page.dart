import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title:
            Text('Ayuda', style: TextStyle(fontFamily: 'Roboto', fontSize: 22)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              border: Border.all(color: Colors.deepPurple.shade200, width: 2),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 5),
                ),
              ],
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Preguntas Frecuentes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.deepPurple.shade800,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                _buildExpansionTile(
                  title: '¿Qué es tragovoltaje?',
                  content:
                      'Tragovoltaje es la marca que le dimos a la creación de nuestra pulsera que utiliza descargas eléctricas para hacer retos en juegos sociales de forma divertida y segura a través de esta app.',
                  icon: Icons.info_outline,
                ),
                _buildExpansionTile(
                  title: '¿Cómo emparejar la pulsera a la app?',
                  content:
                      'Para emparejar la pulsera, enciéndela y abre la app. En la página principal, selecciona se conectará automáticamente después que hayas encendido tu bluetooth y tu ubicación.',
                  icon: Icons.bluetooth,
                ),
                _buildExpansionTile(
                  title: '¿Cómo funciona el sistema de descargas? ¿Es seguro?',
                  content:
                      'El sistema de descargas está diseñado para ser seguro y controlado. La intensidad es regulada para ser inofensiva y divertida. Sin embargo, no es recomendable el uso para personas que tengan problemas mayores de salud (enfermedades cardíacas, epilepsia, trastornos convulsivos, embarazo, hipertensión, asma, etc.)',
                  icon: Icons.security,
                ),
                _buildExpansionTile(
                  title: '¿Qué modos de juegos están disponibles?',
                  content:
                      'La app ofrece varios modos de juego, como el modo básico, aventura, confesiones, desafío y extremo.',
                  icon: Icons.games,
                ),
                _buildExpansionTile(
                  title:
                      '¿Qué hacer si la pulsera se desconecta mediante el juego?',
                  content:
                      'Si la pulsera se desconecta, intenta reconectarla desde la configuración de la app o reinicia el dispositivo si el problema persiste.',
                  icon: Icons.link_off,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ExpansionTile _buildExpansionTile(
      {required String title,
      required String content,
      required IconData icon}) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.deepPurple.shade700),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.deepPurple.shade900),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 2, 2, 2)),
          ),
        ),
      ],
    );
  }
}
