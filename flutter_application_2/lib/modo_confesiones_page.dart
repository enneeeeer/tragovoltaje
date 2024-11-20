import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart'; // Importa flutter_animate para animaciones
import 'ruleta_juego_page.dart'; // Importar la nueva página
import 'dart:async';

class ModoConfesionesPage extends StatefulWidget {
  const ModoConfesionesPage({super.key});

  @override
  _ModoConfesionesPageState createState() => _ModoConfesionesPageState();
}

class _ModoConfesionesPageState extends State<ModoConfesionesPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _nombres = [];
  bool _showTitle = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showTitle = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Center(
              child: Text('¡Bienvenido al Modo Confesiones!',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Roboto'
                  ))),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/rayo.gif",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ).animate(onPlay: (controller) => controller.repeat()),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Agrega nombres a la ruleta:',
                    style: TextStyle(fontSize: 24, color: Colors.lightBlue, fontFamily: 'Roboto'),
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
                      labelStyle: TextStyle(color: Colors.lightBlue),
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      String name = _controller.text;
                      if (name.isNotEmpty) {
                        setState(() {
                          _nombres.add(name);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$name agregado a la ruleta'), duration: Duration(milliseconds: 750)),
                        );
                        _controller.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('Agregar Nombre', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTapDown: (details) {
                          _handleTap(details.localPosition);
                        },
                        child: SizedBox(
                          height: 200,
                          width: 200,
                          child: CustomPaint(
                            painter: RuletaPainter(nombres: _nombres),
                          ),
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/rayo.png',
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RuletaJuegoPage(nombres: _nombres, modo: 'confesiones'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: Text('Jugar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(Offset position) {
    if (_nombres.isEmpty) return;
    // Determinar si se ha tocado un segmento de la ruleta
    double anglePerSegment = 2 * pi / _nombres.length;
    double centerX = 100; // Centro de la ruleta
    double centerY = 100; // Centro de la ruleta

    // Calcular el ángulo del toque
    double touchAngle = atan2(position.dy - centerY, position.dx - centerX);
    if (touchAngle < 0) {
      touchAngle += 2 * pi; // Asegurarse de que el ángulo esté en el rango [0, 2π]
    }

    // Determinar el índice del segmento tocado
    int touchedIndex = (touchAngle / anglePerSegment).floor() % _nombres.length;

    // Obtener el nombre que se va a eliminar
    String nombreEliminado = _nombres[touchedIndex];

    // Eliminar el nombre si se toca
    setState(() {
      _nombres.removeAt(touchedIndex);
    });

    // Mostrar el nombre eliminado en el SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$nombreEliminado eliminado de la ruleta'), duration: Duration(milliseconds: 750)),
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
