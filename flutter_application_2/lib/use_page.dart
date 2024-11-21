import 'package:flutter/material.dart';

class UsageModePage extends StatelessWidget {
  const UsageModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modo de Uso'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pasos para usar Tragovoltaje',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 20),
                _buildStep(
                  icon: Icons.store,
                  stepText: 'Adquiere tu pulsera en las tiendas autorizadas.',
                ),
                _buildStep(
                  icon: Icons.bluetooth,
                  stepText: 'Conecta tu pulsera a través de la sección "Conecta tu pulsera".',
                ),
                _buildStep(
                  icon: Icons.gamepad,
                  stepText: 'Selecciona tu modo de juego según tu preferencia.',
                ),
                _buildStep(
                  icon: Icons.flash_on,
                  stepText: 'Si alguien no cumple un reto, ¡prepárate para tomar o recibir EL RAYO!',
                ),
                _buildStep(
                  icon: Icons.star,
                  stepText:
                      'Disfruta el máximo potencial del juego con nuestra versión premium.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep({required IconData icon, required String stepText}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.indigo,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              stepText,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
