import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';

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
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {
          _angle = _animation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _mostrarNombreSeleccionado();
        }
      });
  }

  void _girarRuleta() {
    double randomAngle = (2 * pi * _random.nextDouble()) + (2 * pi * 5);
    _controller.reset();
    _animation = Tween<double>(begin: _angle, end: _angle + randomAngle).animate(_controller);
    _controller.forward();
  }

  void _mostrarNombreSeleccionado() {
    double angleFinal = _angle % (2 * pi);
    double anglePerSegment = 2 * pi / widget.nombres.length;
    int selectedIndex = ((2 * pi - angleFinal) / anglePerSegment).floor() % widget.nombres.length;

    String nombreSeleccionado = widget.nombres[selectedIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¡A jugar!'),
          content: Text('Es turno de $nombreSeleccionado'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Shot'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Shock'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Continuar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo GIF animado usando flutter_animate
          Image.asset(
            "assets/images/rayo.gif", // Ruta del GIF en assets
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ).animate(onPlay: (controller) => controller.repeat()),
          Center(
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
                Positioned(
                  right: -20,
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/rayo.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 500,),
                Positioned(
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: _girarRuleta,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      'Girar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
    return true;
  }
}
