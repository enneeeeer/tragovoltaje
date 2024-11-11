import 'package:flutter/material.dart';

class Premium extends StatelessWidget {
  const Premium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONOCE LA VERSION PREMIUM'),
        titleTextStyle:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 24),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contenedor con las opciones de Premium
              SizedBox(
                width: double
                    .infinity, // Asegura que el contenedor ocupe todo el ancho
                child: Container(
                  padding:
                      const EdgeInsets.all(15.0), // Espacio dentro de la caja
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        255, 121, 121, 139), // Color de fondo de la caja
                    borderRadius:
                        BorderRadius.circular(10), // Bordes redondeados
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '• Ten la aplicación sin anuncios.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height: 9), // Espacio entre los elementos de la lista
                      Text(
                        '• Desbloquea el modo extremo:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                          height: 8), // Espacio entre los elementos de la lista
                      Text(
                        '  Más preguntas potentes...',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Espacio entre la caja de texto y los botones
              const SizedBox(height: 100),

              // Botón "Plan Mensual"
              SizedBox(
                width: double.infinity, // Hace que el botón ocupe todo el ancho
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al presionar el botón "Plan Mensual"
                    // (Agregar lógica aquí si se requiere)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 15, 25, 72), // Color de fondo del botón
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Solo padding vertical
                  ),
                  child: const Text(
                    'ADQUIRIR PLAN MENSUAL', // Texto dentro del botón
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ), // Tamaño de la fuente del texto del botón
                  ),
                ),
              ),

              // Espacio entre los botones
              const SizedBox(height: 10),

              // Botón "Plan Anual"
              SizedBox(
                width: double.infinity, // Hace que el botón ocupe todo el ancho
                child: ElevatedButton(
                  onPressed: () {
                    // Acción a realizar al presionar el botón "Plan Anual"
                    // (Agregar lógica aquí si se requiere)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 15, 25, 72), // Color de fondo del botón
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Solo padding vertical
                  ),
                  child: const Text(
                    'ADQUIRIR PLAN ANUAL', // Texto dentro del botón
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ), // Tamaño de la fuente del texto del botón
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
