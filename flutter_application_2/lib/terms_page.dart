import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos de servicio'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Términos y Condiciones',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Última actualización: Noviembre 2024',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade600,
                  ),
                ),
                Divider(color: Colors.grey.shade300, thickness: 1),
                SizedBox(height: 10),
                _buildSection(
                  '1. Uso de la aplicación',
                  'Tragovoltaje está destinada exclusivamente a fines recreativos y sociales. Al utilizar la aplicación, aceptas lo siguiente:\n\n- Ser mayor de 18 años o tener supervisión de un adulto.\n- Abstenerte de usos indebidos, peligrosos o ilegales.\n- Utilizar dentro de los límites especificados.',
                ),
                _buildSection(
                  '2. Advertencias de Seguridad',
                  'La pulsera Tragovoltaje emite ligeras descargas eléctricas. Es fundamental:\n\n- Leer las instrucciones detalladas.\n- Ajustar la intensidad de manera responsable.\n- No usar en personas con problemas de salud delicados, como problemas cardíacos.',
                ),
                _buildSection(
                  '3. Requisitos de Uso',
                  'Para un correcto funcionamiento:\n\n- Tener un dispositivo compatible con Bluetooth.\n- Permitir permisos necesarios como Bluetooth y almacenamiento.\n- Mantener una conexión a internet activa.',
                ),
                _buildSection(
                  '4. Modos de Juego y Compras Premium',
                  'Tragovoltaje ofrece modos de juego gratuitos y premium, como niveles personalizados para una experiencia más completa.',
                ),
                _buildSection(
                  '5. Limitación de Responsabilidad',
                  'No somos responsables por daños o problemas derivados del uso indebido de la aplicación o la pulsera. Es tu responsabilidad garantizar el uso seguro.',
                ),
                _buildSection(
                  '6. Privacidad y Datos Personales',
                  'Recopilamos ciertos datos, como estadísticas de uso. Manejamos tus datos de manera segura, sin compartirlos con terceros sin tu consentimiento.',
                ),
                _buildSection(
                  '7. Modificaciones en los Términos',
                  'Nos reservamos el derecho de modificar estos términos. Notificaremos cambios a través de la aplicación.',
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'Gracias por elegir Tragovoltaje para tus reuniones sociales.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade700,
            ),
          ),
          SizedBox(height: 6),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
