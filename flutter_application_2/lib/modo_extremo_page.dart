import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart'; // Importa flutter_animate para animaciones
import 'ruleta_juego_page.dart'; // Importar la nueva página

class ModoExtremoPage extends StatefulWidget {
  const ModoExtremoPage({super.key});

  @override
  _ModoExtremoPageState createState() => _ModoExtremoPageState();
}

class _ModoExtremoPageState extends State<ModoExtremoPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _nombres = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Bienvenido al Modo Extremo'),
      ),
      body: Stack(
        children: [
          // Fondo GIF animado
          Image.asset(
            "assets/images/fuego.gif", // Ruta del GIF en assets
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ).animate(onPlay: (controller) => controller.repeat()),
          
          // Contenido principal de la página
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Agrega nombres a la ruleta:',
                  style: TextStyle(fontSize: 24, color: Colors.lightBlue),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre',
                    hintText: 'Ingresa un nombre',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String name = _controller.text;
                    if (name.isNotEmpty) {
                      setState(() {
                        _nombres.add(name); // Agregar el nombre a la lista
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('$name agregado a la ruleta')),
                      );
                      _controller.clear(); // Limpiar el campo de texto
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('Agregar Nombre'),
                ),
                SizedBox(height: 20),
                // Ruleta con imagen central
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      child: CustomPaint(
                        painter: RuletaPainter(nombres: _nombres),
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/rayo.png', // Ruta de la imagen
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Para empujar el botón hacia abajo
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la nueva página de la ruleta
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RuletaJuegoPage(nombres: _nombres),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('Jugar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RuletaPainter extends CustomPainter {
  final List<String> nombres;

  RuletaPainter({required this.nombres});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double radius = size.width / 2;
    final double anglePerSegment = 2 * pi / nombres.length;

    // Definir una lista de colores
    List<Color> colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.blueGrey,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.grey,
      Colors.black,
    ];

    for (int i = 0; i < nombres.length; i++) {
      paint.color = colors[i % colors.length];
      double startAngle = i * anglePerSegment;
      double sweepAngle = anglePerSegment;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      double textAngle = startAngle + sweepAngle / 2;
      double textX = radius + (radius / 2) * cos(textAngle);
      double textY = radius + (radius / 2) * sin(textAngle);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: nombres[i],
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(textX - textPainter.width / 2, textY - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Redibujar siempre cuando hay cambios
  }
}
