import 'package:flutter/material.dart';

class UsageModePage extends StatelessWidget {
  const UsageModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modo de uso'),
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
              Text('1. Adquiere tu pulsera en las tiendas autorizadas.'),
              SizedBox(height: 20),
              Text('2. Conecta tu pulsera a través de la sección "conecta tu pulsera"'),
              SizedBox(height: 20),
              Text('3. Selecciona tu modo de juego según tu preferencia'),
              SizedBox(height: 20),
              Text('4. En cuanto alguien no cumpla un reto, estará listo para tomar o recibir EL RAYO!'),
              SizedBox(height: 20),
              Text('*Puedes disfrutar el mayor modo de juego con nuestra parte premium.'),
            ],
          ),
        ),
      ),
    );
  }
}
