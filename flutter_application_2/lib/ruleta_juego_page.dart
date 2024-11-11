import 'package:flutter/material.dart';
import 'dart:math';

class RuletaJuegoPage extends StatefulWidget {
  final List<String> nombres;

  RuletaJuegoPage({required this.nombres});

  @override
  _RuletaJuegoPageState createState() => _RuletaJuegoPageState();
}

class _RuletaJuegoPageState extends State<RuletaJuegoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Duración de la animación
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          _angle = _animation.value;
        });
      });
  }

  void _girarRuleta() {
    // Generar un ángulo aleatorio para girar la ruleta
    double randomAngle = (2 * pi * _random.nextDouble()) + (2 * pi * 5); // Girar varias veces
    _controller.reset();
    _animation = Tween<double>(begin: _angle, end: _angle + randomAngle).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: _angle,
              child: Container(
                height: 300,
                width: 300,
                child: CustomPaint(
                  painter: RuletaPainter(nombres: widget.nombres),
                ),
              ),
            ),
            SizedBox(height: 500,),
            Positioned(
              bottom: 50,
              child: ElevatedButton(
                onPressed: _girarRuleta,
                child: Text('Girar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
              ),
            ),
          ],
        ),
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
      Colors.white,
    ];

    for (int i = 0; i < nombres.length; i++) {
      // Asignar un color específico para cada segmento
      paint.color = colors[i % colors.length];

      // Calcular el ángulo de inicio y el ángulo final
      double startAngle = i * anglePerSegment;
      double sweepAngle = anglePerSegment;

      // Dibujar el segmento
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Calcular la posición del texto
      double textAngle = startAngle + sweepAngle / 2;
      double textX = radius + (radius / 2) * cos(textAngle);
      double textY = radius + (radius / 2) * sin(textAngle);

      // Dibujar el texto
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