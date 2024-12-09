import 'dart:convert';
import 'package:TragoVoltaje/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
  bool girando = false;
  Map<String, bool> shotButtonStates = {};

  final Map<String, String> gifs = {
    'basico': 'assets/images/rayo.gif',
    'aventura': 'assets/images/rayo.gif',
    'desafio': 'assets/images/rayo.gif',
    'confesiones': 'assets/images/rayo.gif',
    'extremo': 'assets/images/fuego.gif',
  };

  List<String> retosBasicos = [];
  List<String> retosAventura = [];
  List<String> retosConfesiones = [];
  List<String> retosDesafios = [];
  List<String> retosExtremos = [];

  List<String> retosBasicosDisponibles = [];
  List<String> retosAventuraDisponibles = [];
  List<String> retosConfesionesDisponibles = [];
  List<String> retosDesafiosDisponibles = [];
  List<String> retosExtremosDisponibles = [];

  @override
  void initState() {
    super.initState();
    loadRetos();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    for (var nombre in widget.nombres) {
      shotButtonStates[nombre] = true; // Todos los botones "Shot" están habilitados al inicio
    }

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

  Future<void> loadRetos() async {
    final String response = await rootBundle.loadString('assets/jsons/retos.json');
    final data = await json.decode(response);
    setState(() {
      retosBasicos = List<String>.from(data['retosBasicos']);
      retosAventura = List<String>.from(data['retosAventura']);
      retosConfesiones = List<String>.from(data['retosConfesiones']);
      retosDesafios = List<String>.from(data['retosDesafios']);
      retosExtremos = List<String>.from(data['retosExtremos']);

      // Inicializar las listas temporales
      retosBasicosDisponibles = List.from(retosBasicos);
      retosAventuraDisponibles = List.from(retosAventura);
      retosConfesionesDisponibles = List.from(retosConfesiones);
      retosDesafiosDisponibles = List.from(retosDesafios);
      retosExtremosDisponibles = List.from(retosExtremos);
    });
  }

  void reiniciarListaRetos(String modo) {
    switch (modo) {
      case 'basico':
        retosBasicosDisponibles = List.from(retosBasicos);
        break;
      case 'aventura':
        retosAventuraDisponibles = List.from(retosAventura);
        break;
      case 'confesiones':
        retosConfesionesDisponibles = List.from(retosConfesiones);
        break;
      case 'desafio':
        retosDesafiosDisponibles = List.from(retosDesafios);
        break;
      case 'extremo':
        retosExtremosDisponibles = List.from(retosExtremos);
        break;
    }
  }

  String obtenerRetoAleatorio(String modo) {
    List<String> retosDisponibles;

    switch (modo) {
      case 'basico':
        retosDisponibles = retosBasicosDisponibles;
        break;
      case 'aventura':
        retosDisponibles = retosAventuraDisponibles;
        break;
      case 'confesiones':
        retosDisponibles = retosConfesionesDisponibles;
        break;
      case 'desafio':
        retosDisponibles = retosDesafiosDisponibles;
        break;
      case 'extremo':
        retosDisponibles = retosExtremosDisponibles;
        break;
      default:
        return "Modo desconocido.";
    }

    // Si la lista temporal está vacía, reiniciarla con los retos originales
    if (retosDisponibles.isEmpty) {
      reiniciarListaRetos(modo);
    }

    // Seleccionar un reto al azar y eliminarlo de la lista temporal
    int index = Random().nextInt(retosDisponibles.length);
    String retoSeleccionado = retosDisponibles[index];
    retosDisponibles.removeAt(index);

    return retoSeleccionado;
  }

  void _girarRuleta() {
    setState(() {
      girando = true; // Deshabilitar el botón
    });
    double randomAngle = (2 * pi * _random.nextDouble()) + (2 * pi * 5);
    _controller.reset();
    _animation = Tween<double>(begin: _angle, end: _angle + randomAngle)
        .animate(_controller);
    _controller.forward();
  }

  void _mostrarNombreSeleccionado() {
    double angleFinal = _angle % (2 * pi);
    double anglePerSegment = 2 * pi / widget.nombres.length;
    int selectedIndex = ((2 * pi - angleFinal) / anglePerSegment).floor() %
        widget.nombres.length;

    String nombreSeleccionado = widget.nombres[selectedIndex];
    String reto = obtenerRetoAleatorio(widget.modo);

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.pinkAccent.shade400, // Color neón rosado
                  Colors.blueAccent.shade400, // Color neón azul
                  Colors.greenAccent.shade400, // Color neón verde
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // Borde interno para el efecto de borde neón
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            padding: EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[900],
                borderRadius: BorderRadius.circular(17),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Es turno de $nombreSeleccionado',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.pinkAccent,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    reto,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.blueAccent,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: shotButtonStates[nombreSeleccionado]! ? () {
                          setState(() {
                            shotButtonStates[nombreSeleccionado] = false; // Deshabilitar el botón "Shot" para el jugador actual
                          });
                          Navigator.of(context).pop();
                          setState(() {
                            girando = false; // Habilitar el botón nuevamente
                          });
                        } : null, // Deshabilitar el botón si el estado es false
                        child: Text('Shot', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          final bluetoothModel = Provider.of<BluetoothModel>(context, listen: false);
                          bluetoothModel.sendMessage('0');
                          Navigator.of(context).pop();
                          setState(() {
                            girando = false; // Habilitar el botón nuevamente
                            shotButtonStates[nombreSeleccionado] = true; // Permitir el uso de "Shot" nuevamente
                          });
                        },
                        child: Text('Shock', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {
                            girando = false; // Habilitar el botón nuevamente
                          });
                        },
                        child: Text('Continuar', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
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
                  child: SizedBox(
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
                SizedBox(
                  height: 500,
                ),
                Positioned(
                  bottom: 50,
                  child: ElevatedButton(
                    onPressed: girando ? null : _girarRuleta,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, 
                      disabledForegroundColor: Colors.red.withOpacity(0.50), 
                      disabledBackgroundColor: Colors.red.withOpacity(0.25),
                      padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0; // Ancho del borde
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
      Colors.deepPurpleAccent,
      Colors.teal,
      Colors.pink,
      Colors.grey,
      Colors.deepOrange,
      Colors.greenAccent,
      Colors.lightGreenAccent,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.deepPurple,
      Colors.deepOrangeAccent,
      Colors.amber,
      Colors.cyanAccent,
      Colors.redAccent,
      Colors.pinkAccent,
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
      textPainter.paint(
          canvas,
          Offset(
              textX - textPainter.width / 2, textY - textPainter.height / 2));
    }
    canvas.drawCircle(Offset(radius, radius), radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
