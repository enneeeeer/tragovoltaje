import 'package:flutter/material.dart';
import 'dart:math';
import 'ruleta_juego_page.dart'; // Importar la nueva página

class RuletaPage extends StatefulWidget {
  final String mode;

  RuletaPage({required this.mode});

  @override
  _RuletaPageState createState() => _RuletaPageState();
}

class _RuletaPageState extends State<RuletaPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _nombres = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Bienvenido al ${widget.mode}'),
      ),
      body: Padding(
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
              child: Text('Agregar Nombre'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
            ),
            SizedBox(height: 20),
            // Aquí se muestra la ruleta
            Container(
              height: 200,
              width: 200,
              child: CustomPaint(
                painter: RuletaPainter(nombres: _nombres),
              ),
            ),
            SizedBox(height: 20,),// Para empujar el botón hacia abajo
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
              child: Text('Jugar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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