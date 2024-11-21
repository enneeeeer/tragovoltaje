import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Términos de servicio'),
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Términos y Condiciones',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 212, 78, 224)),
                ),
                Text(
                  'Última actualización',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Bienvenido/a a Tragovoltaje. Te agradecemos por descargar nuestra aplicación y confiar en nosotros para ser parte de tus reuniones sociales. Antes de comenzar, es importante que leas cuidadosamente estos términos y condiciones. Al descargar, instalar o utilizar nuestra aplicación, aceptas estar de acuerdo con ellos en su totalidad. Si no estás de acuerdo con algún punto, te pedimos que no utilices la aplicación ni sus servicios. “Tragovoltaje” se refiere a la aplicación móvil y al dispositivo asociado (pulsera) diseñado para entretenimiento en reuniones sociales. “Usuario” es la persona que utiliza la aplicación. “Nosotros” o “la empresa” se refiere a "Tragovoltaje".',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '1.Uso de la aplicación',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Tragovoltaje está destinada exclusivamente a fines recreativos y sociales. Su uso debe realizarse de manera responsable y conforme a lo previsto en estos términos. Al utilizar la aplicación, aceptas lo siguiente: Ser mayor de 18 años. En caso contrario, se requiere supervisión directa de un adulto. Abstenerte de usar la aplicación para actividades ilegales, peligrosas o no previstas, como usos indebidos en contextos médicos. Utilizar tanto la aplicación como la pulsera dentro de los límites especificados en este documento.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '2.Advertencias de Seguridad',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'La pulsera Tragovoltaje emite ligeras descargas eléctricas como parte de su funcionalidad. Es fundamental: Leer las instrucciones detalladas disponibles en la aplicación y el manual del producto. Ajustar la intensidad de las descargas a niveles cómodos, especialmente si se utiliza por primera vez. No usar la pulsera en personas con condiciones de salud delicadas, como problemas cardíacos, marcapasos, epilepsia o sensibilidad eléctrica. Evitar su uso en menores de edad, salvo que estén bajo supervisión directa de un adulto. ',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '3. Requisitos de Uso',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Para garantizar el correcto funcionamiento de Tragovoltaje, asegúrate de cumplir con los siguientes requisitos: Tener un dispositivo compatible con Bluetooth y con la aplicación instalada desde una fuente oficial, como App Store o Google Play. Permitir los permisos necesarios en tu dispositivo, como acceso a Bluetooth, almacenamiento y notificaciones. Contar con una conexión a internet para acceder a actualizaciones, modos premium y funciones adicionales.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '4. Modos de Juego y compras Premium',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Tragovoltaje ofrece diversos modos de juego gratuitos, así como opciones premium para una experiencia más completa: Incluyen mas modos y el nivel personalizado.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '5. Limitación de Responsabilidad',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'No nos hacemos responsables por daños, lesiones o problemas de salud que resulten del uso indebido de la pulsera o la aplicación. ampoco asumimos responsabilidad por interrupciones en el servicio, problemas técnicos derivados de dispositivos incompatibles, ni por pérdidas de datos. Es responsabilidad del usuario asegurarse de utilizar la aplicación de manera segura y de acuerdo con las instrucciones.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '6. Privacidad y Datos Personales',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Para mejorar tu experiencia, Tragovoltaje recopila ciertos datos, como estadísticas de uso, preferencias y configuración. Estos datos se manejan de manera segura y en conformidad con nuestra Política de Privacidad: No compartimos datos personales con terceros sin tu consentimiento, salvo cuando sea requerido por la ley. Puedes revisar, actualizar o eliminar tus datos en cualquier momento desde la configuración de la aplicación o contactándonos directamente.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  '7. Modificaciones en los Términos',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Nos reservamos el derecho de modificar estos términos en cualquier momento para mejorar nuestros servicios o cumplir con nuevas regulaciones. Notificaremos cualquier cambio a través de la aplicación, y el uso continuo de la misma implicará tu aceptación de los nuevos términos.',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
                Text(
                  'Aceptación de los Términos',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 46, 40, 40)),
                ),
                Text(
                  'Al utilizar Tragovoltaje, confirmas haber leído, entendido y aceptado estos términos y condiciones. ¡Gracias por elegirnos para llevar más diversión y emoción a tus reuniones sociales!',
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 58, 56, 56)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
