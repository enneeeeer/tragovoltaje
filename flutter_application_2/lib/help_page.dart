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
            color: const Color.fromARGB(255, 241, 241, 241),
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Preguntas Frecuentes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text('¿Qué es tragovoltaje?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Tragovoltaje es la marca que le dimos a la creción de nuestra pulsera que utiliza descargas eléctricas para hacer retos en juegos sociales de forma divertida y segura a través de esta app.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('¿Cómo emparejar la pulsera a la app?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Para emparejar la pulsera, enciéndela y abre la app. En la página principal, selecciona se conectará automáticamente después que hayas encendido tu bluetooth',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title:
                    Text('¿Cómo funciona el sistema de descargas? ¿Es seguro?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'El sistema de descargas está diseñado para ser seguro y controlado. La intensidad es regulada para ser inofensiva y divertida.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('¿Cómo cambiar la intensidad de las descargas?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Está por verse.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('¿Qué modos de juegos están disponibles?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'La app ofrece varios modos de juego, como el modo básico, aventura, confesiones, desafío y extremo.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                    '¿Qué modos de juegos están disponibles en el plan Premium?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'El plan Premium incluye modos exclusivos, como el modo extremo y personalizado, aparte podrás librarte de los anuncios para jugar sin interrupciones.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                    '¿Qué hacer si la pulsera se desconecta mediante el juego?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Si la pulsera se desconecta, intenta reconectarla desde la configuración de la app o reinicia el dispositivo si el problema persiste.',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title:
                    Text('¿Cómo configuro mis propios desafíos y preguntas?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Puedes configurar tus propios desafíos y preguntas en el modo de personalización dentro de la app. (por verse)',
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text('¿Cómo conectar más jugadores a la app?'),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'por verse',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
