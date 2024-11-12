import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';

class RuletaJuegoPage extends StatefulWidget {
  final List<String> nombres;
  final String modo;

  RuletaJuegoPage({required this.nombres, required this.modo});

  @override
  _RuletaJuegoPageState createState() => _RuletaJuegoPageState();
}

class _RuletaJuegoPageState extends State<RuletaJuegoPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;
  final Random _random = Random();

  final Map<String, String> gifs = {
    'basico': 'assets/images/rayo.gif',
    'aventura': 'assets/images/rayo.gif',
    'desafio': 'assets/images/rayo.gif',
    'confesiones': 'assets/images/rayo.gif',
    'extremo': 'assets/images/fuego.gif',
  };

  List<String> retosBasicos = [
      'Retos Basicos',
      'Retos Basicos',
      'Retos Basicos',
  ];

  List<String> retosAventura = [
      'Retos de Aventura',
      'Retos de Aventura',
      'Retos de Aventura',
  ];

  List<String> retosConfesiones = [
      'Retos de Confesiones',
      'Retos de Confesiones',
      'Retos de Confesiones',
  ];

  List<String> retosDesafios = [
      'Retos de Desafios',
      'Retos de Desafios',
      'Retos de Desafios',
  ];

  List<String> retosExtremos = [
    '¿Alguna vez has tenido una aventura de una noche?',
    '¿Cuál es tu mayor secreto sexual?',
    '¿Te has enamorado de alguien que no debería?',
    '¿Cuál es la cosa más loca que has hecho por amor?',
    '¿Alguna vez has enviado un mensaje íntimo a la persona equivocada?',
    'Reto: Besa a la persona a tu izquierda en la mejilla.',
    '¿Alguna vez has tenido un crush en un amigo de tu pareja?',
    '¿Cuál es tu fantasía más salvaje?',
    '¿Te has desnudado en público?',
    'Reto: Llama a alguien y dile que lo amas (sin importar quién sea).',
    '¿Alguna vez has hecho algo ilegal? ¿Qué fue?',
    '¿Cuál es la mayor mentira que has dicho a tus padres?',
    'Reto: Haz una imitación de alguien en el grupo.',
    '¿Te has enamorado de un profesor o profesor(a)?',
    '¿Cuál es el lugar más extraño donde has tenido relaciones sexuales?',
    'Reto: Envía un mensaje de texto a tu ex y dile que lo extrañas.',
    '¿Alguna vez has tenido un "amigo con beneficios"?',
    '¿Cuál es el peor lugar donde te has quedado a dormir?',
    'Reto: Haz una declaración de amor a alguien en el grupo.',
    '¿Alguna vez has hecho un striptease?',
    '¿Cuál es la mayor vergüenza que has tenido en una cita?',
    'Reto: Deja que alguien del grupo te haga un dibujo en la cara.',
    '¿Te has enamorado de alguien que estaba en una relación?',
    '¿Cuál es el secreto más oscuro que guardas?',
    'Reto: Publica una foto vergonzosa de ti en tus redes sociales.',
    '¿Alguna vez has tenido un sueño erótico con alguien del grupo?',
    '¿Cuál es tu mayor arrepentimiento en la vida?',
    'Reto: Haz una llamada a alguien y canta "Te amo" en lugar de hablar normalmente.',
    '¿Alguna vez has hecho algo por lo que te sientas muy culpable?',
    '¿Cuál es el rumor más extraño que has escuchado sobre ti?',
    'Reto: Muestra tu último mensaje de texto a alguien en el grupo.',
    '¿Alguna vez has tenido relaciones sexuales en un lugar público?',
    '¿Cuál es tu mayor miedo en una relación?',
    'Reto: Imita a alguien del grupo y haz que adivinen quién eres.',
    '¿Te has enamorado de alguien que conociste en línea?',
    '¿Cuál es el momento más vergonzoso de tu vida?',
    'Reto: Haz una pose sexy y manténla durante 10 segundos.',
    '¿Alguna vez has tenido un amor platónico por alguien famoso?',
    '¿Cuál es el peor consejo que has recibido sobre el amor?',
    'Reto: Comparte un secreto que nadie más en el grupo conozca.',
    '¿Te has peleado alguna vez por amor?',
    '¿Cuál es la cosa más atrevida que has hecho en una fiesta?',
    'Reto: Deja que alguien del grupo elija una prenda de ropa que debes quitarte.',
    '¿Alguna vez has tenido un encuentro sexual con alguien mucho mayor que tú?',
    '¿Cuál es tu posición favorita en la cama?',
    'Reto: Haz un baile sensual durante 30 segundos.',
    '¿Alguna vez has tenido un "amor a primera vista"?',
    '¿Cuál es el regalo más inusual que has recibido de un amante?',
    'Reto: Llama a un amigo y dile que estás pensando en mudarte a otro país.',
    '¿Cuál es el mayor riesgo que has tomado en tu vida?',
  ];

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
    String reto = '';

    switch (widget.modo) {
    case 'basico':
      reto = retosBasicos[Random().nextInt(retosBasicos.length)];
      break;
    case 'aventura':
      reto = retosAventura[Random().nextInt(retosAventura.length)];
      break;
    case 'desafio':
      reto = retosDesafios[Random().nextInt(retosDesafios.length)];
      break;
    case 'confesiones':
      reto = retosConfesiones[Random().nextInt(retosConfesiones.length)];
      break;
    case 'extremo':
      reto = retosExtremos[Random().nextInt(retosExtremos.length)];
      break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800], // Cambiar el color de fondo
          title: Center(child: Text('Es turno de $nombreSeleccionado', style: TextStyle(color: Colors.white))),
          content: Container(
            width: 300, // Establecer un ancho máximo para el contenido
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(child: Text(reto, style: TextStyle(color: Colors.white))),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Shot', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Shock', style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Continuar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
            gifs[widget.modo] ?? gifs['basico']!,
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