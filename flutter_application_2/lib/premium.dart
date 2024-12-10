import 'package:flutter/material.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CONOCE LA VERSION PREMIUM',
          style: TextStyle(
            fontSize: 24,
            color: Color.fromARGB(255, 123, 221, 93),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(255, 85, 185, 108),
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double
                    .infinity,
                child: Container(
                  padding:
                      const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 0, 0, 0),
                    borderRadius:
                        BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.greenAccent,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '• Ten la aplicación sin anuncios.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height: 9),
                      Text(
                        '• Desbloquea el modo extremo:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height: 8),
                      Text(
                        '  Más preguntas potentes...',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al presionar el botón "Plan Mensual"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 47, 100, 36),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15),
                  ),
                  child: const Text(
                    'ADQUIRIR PLAN MENSUAL',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al presionar el botón "Plan Anual"
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 47, 100, 36),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), 
                  ),
                  child: const Text(
                    'ADQUIRIR PLAN ANUAL', 
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ), 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}