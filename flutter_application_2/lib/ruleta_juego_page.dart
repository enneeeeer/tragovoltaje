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

class _RuletaJuegoPageState extends State<RuletaJuegoPage>
    with SingleTickerProviderStateMixin {
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
    '¿Prefieres el día o la noche?',
    '¿Prefieres el olor a tierra mojada o la brisa del mar?',
    '¿Cuál es tu película favorita hasta ahora?',
    'Si solo pudieras comer una comida por el resto de tu vida, ¿Cuál elegirías? Y ¿por qué?',
    '¿Cuál es tu estación favorita del año? Y ¿por qué?',
    '¿Te gusta más el dulce o salado?',
    '¿Qué tipo de música te gusta?',
    '¿Qué serie o película recomendarías a un amigo?',
    '¿Tienes alguna fobia o miedo irracional a algo o alguien?',
    '¿Cuál fue el último concierto al que asististe?',
    '¿Qué deporte te gusta practicar o ver? ¿por qué practicas ese deporte/ por qué no practicas deporte?',
    '¿Qué harías si tuvieras un superpoder?',
    '¿Cuál es tu red social favorita? ¿por qué la utilizas?',
    '¿Te gusta viajar en avión, tren, barco, auto?',
    '¿Cuál es tu recuerdo favorito de la infancia?',
    'Si ganas la lotería, ¿Qué sería lo primero que harías?',
    '¿Qué personaje histórico te gustaría conocer?',
    '¿Cuál es el país que más te gustaría visitar?',
    '¿Tocas algún instrumento musical?',
    '¿Eres más de té o café? ¿por qué?',
    '¿Has pensado en casarte? ¿A los cuantos años lo harías?',
    '¿Cuál es el sueño más raro que has tenido?',
    '¿Te gusta la pizza con piña o sin piña?',
    '¿Si pudieras reencarnar en un animal, en que animal lo harías?',
    '¿Tienes algún talento oculto?',
    '¿Te gusta el mar o la montaña?',
    '¿Qué animal elegirías si pudieras tener cualquier mascota?',
    '¿Cuál es el último libro que leíste?',
    '¿Tienes algún talento oculto? demuéstralo',
    '¿Cuál es el último libro que tenías?',
    '¿Qué tipo de música te anima un mal día?',
    '¿Cuál es tu comida favorita para una ocasión especial?',
    '¿Te consideras una persona de gatos o de perros (o de ambos)?',
    '¿Eres más de hacer planes espontáneos o de planearlo todo con anticipación?',
    '¿Cuál es tu comida favorita para una ocasión especial?',
    '¿Cuál ha sido tu mayor aventura este año?',
    'Si pudieras escribir un libro sobre ti, ¿Sobre qué trataría?',
    '¿Prefieres las actividades al aire libre o eres más de actividades en interiores?',
    '¿Qué te gusta hacer para relajarte después de un día largo?',
    '¿Qué cualidades valoras en una amistad?',
    '¿Hay alguna tradición o costumbre que te guste especialmente?',
    '¿Te gusta cocinar? ¿Cuál es tu plato estrella?',
    '¿Qué te inspira o motiva tu vida?',
  ];

  List<String> retosAventura = [
    'Imita un famoso por 1 min, si nadie lo adivina prepárate para el castigo',
    'Haz un "story time" de una experiencia vergonzosa que tuviste',
    'Intenta hacer malabares con cualquier objeto que tengas cerca durante 30 segundos',
    'Baila una coreografía de TikTok que el grupo elija para ti',
    'Llena tu vaso de alcohol, colócalo en tu cabeza y camina 10 pasos sin derramarlo',
    'Tararea una canción por 1 min, si nadie lo adivina prepárate para el castigo',
    'Grita la primera palabra que se te venga a la mente',
    'Quédate en forma de estatua por 1 minuto sin hacer ninguna mueca',
    'Habla con alguien en la reunión como si no los conocieras y finjan una conversación incómoda',
    'Cierra los ojos y señala a alguien e intenta adivinar quién es',
    'Párate en un pie por 2 min',
    'Imita a un animal y haz que los demás adivinen cuál es',
    'Imita a un personaje de caricatura mientras hablas durante los siguientes 3 turnos',
    'Tómate una foto ridícula y súbela a tus redes',
    'Mantén una postura que el grupo elija durante 40 segundos',
    'Simula estar en cámara lenta durante 3 turnos',
    'Llena tus mejillas de aire y habla así durante un minuto',
    '¿Cuál es el mejor regalo que te han dado?',
    '¿Tienes alguna manía o hábito que haces sin darte cuenta?',
    '¿Qué es algo que siempre quisiste aprender pero aún no has intentado?',
    '¿Cuál es el mejor cumplido que te han dado?',
    'Actúa como si tuvieras acento extranjero durante los próximos 2 turnos',
    'Baila la Macarena en medio de la reunión',
    'Desafía a alguien a ver quién da más vueltas sobre sí mismo sin marearse',
    'Con los ojos cerrados, intenta adivinar los nombres de 5 objetos que toques',
    'Haz una mini coreografía improvisada con quien tengas más cerca',
    '¿Cuál es el mejor regalo que has dado y a quién?',
    '¿Cuál es la canción más embarazosa que tienes en tu lista de reproducción?',
    'Di 5 cosas raras sobre ti',
  ];

  List<String> retosConfesiones = [
    '¿Quién de tus amigos de aquí te cae peor?',
    '¿Qué es lo más raro que has hecho por amor?',
    'Cuenta una historia divertida de una cita fallida.',
    '¿Alguna vez te has sentido atraído/a por el novio/a de un amigo/a?',
    '¿A quién matarías, con quién te casarías y a quién besarías? (De los aquí presentes)',
    '¿Quién es la persona a la que más rencor le tienes?',
    '¿Alguna vez te has sentido atraído por alguna de las personas que están aquí?',
    'Confiesa un secreto que nadie sepa.',
    'Algo extraño que hagas cuando no hay nadie presente.',
    'Una manía vergonzosa que no le hayas contado a nadie.',
    'Un apodo ofensivo que le hayas puesto a alguien de tu círculo cercano.',
    '¿Quién de tus amigos es más probable que el día de su boda salga corriendo antes de darse el ‘sí, quiero’?',
    '¿Qué te gustaría cambiar de tu cuerpo?',
    '¿Quién es más probable que tenga una cita a ciegas?',
    '¿Cuánto ha sido lo máximo que has estado sin tener relaciones sexuales?',
    '¿Qué es lo primero que harías si te despertaras siendo del sexo opuesto?',
    '¿Has cotilleado el móvil de tu pareja sin su permiso?',
    '¿Alguna vez has tenido una cuenta en redes falsa para stalkear a alguien?',
    '¿Alguna vez has tenido una relación en secreto?',
    'Lee un mensaje que hayas mandado borracha/o y que te de vergüenza ajena.',
    '¿Qué es lo más ridículo que te han pillado haciendo?',
    '¿Alguna vez has sentido atracción por alguien que ni siquiera conocías?',
    '¿Cuál es la mentira menos creíble que has dicho nunca a tus amigos?',
    'Cuenta una maldad que hicieras de pequeñ@ y ahora te arrepientas.',
    '¿Qué es lo más ilegal que has hecho?',
    '¿Has mentido sobre tu edad con algún objetivo? ¿Cuál?',
    '¿Cambiarías algo de tu pasado? ¿El qué?',
    'Un comentario que hayan dicho sobre ti y te haya dolido mucho.',
    '¿Cuál es tu peor hábito?',
    '¿Cuál es la mentira más grave que has contado?',
    'Un rumor que hayan dicho de ti y que hubieras preferido que fuera verdad.',
    '¿Te has meado en la cama recientemente?',
    '¿Qué es lo más desesperado que has hecho por dinero?',
    '¿Has sentido atracción por el padre/madre de alguno de tus amigos?',
    '¿Quién es la persona que peor viste de aquí?',
    '¿Cuál es la cosa más extraña que has buscado en internet?',
    '¿Qué es lo más caro que has robado alguna vez?',
    '¿Qué es la cosa más infantil que todavía haces?',
    '¿Cómo fue la peor cita de tu vida?',
    '¿Alguna vez has tenido algún pensamiento inapropiado con una persona de aquí?',
    '¿Quién es más probable que lleve una doble vida?',
    'Una decisión que hayas tomado estando borracho y te arrepientas.',
    '¿Te has reído de alguno de los aquí presentes a sus espaldas?',
    'Un amigo que no soportes, pero te juntes con él por pena.',
    '¿Has sido infiel alguna vez?',
    '¿Quién podría caer en bancarrota antes de que acabe el año?',
    '¿Alguna vez has espiado a alguien sin que lo supiera?',
    'Define a tu expareja con una palabra.',
    '¿Alguna vez has hecho ghosting?',
    '¿Alguna vez has intentado llamar la atención de alguien y te ha salido mal? Cuenta tu experiencia.'
  ];

  List<String> retosDesafios = [   
    'Lámete el codo',
    'Haz fuercitas con el jugador que elijan los demás, el que pierda recibe el castigo',
    'Imita a cualquier persona presente y que los demás adivinen de quien se trata',
    'Di el alfabeto al revés sin equivocarte',
    'Enseña tu historial a los demás, si no deseas sométete a las consecuencias 😈',
    'Quédate 1 minuto en posición de plank',
    'Completa un trabalenguas sin equivocarte',
    'Haz la imitación de un famoso durante 30 segundos',
    'Haz 15 flexiones completas',
    'Deletrea esta palabra al revés: TRAGOVOLTAJE',
    'Cuenta un chiste, si nadie se ríe toma un shot o un shock',
    'Haz una pregunta a una persona que apenas conozcas de tus redes sociales',
    'Dibuja cualquier cosa en una hoja con los ojos cerrados y deja que el resto adivine que es. Si no lo logran, shot o shock',
    'Habla con un acento extranjero durante 5 minutos',
    'Di 2 verdades y una mentira sobre ti. Deja que el resto adivine cuál es la mentira. Si adivinan, te espera un shock ⚡️',
    'Imita la forma de caminar de un animal',
    'Ponte una venda en los ojos y adivina qué objeto te han pasado',
    'Haz una mímica de una película famosa y los demás deben tratar de adivinarla',
    'Escoge a alguien de la sala, ¿Con quién pasarías un mes en una isla desierta?',
    'Si solo pudieras usar una aplicación por el resto de tu vida, ¿cuál sería?',
    'Encuentra algo en la habitación que empiece con la letra "R" y crea una historia alrededor de eso',
    '¿Cuál sería una habilidad o superpoder que desearías tener?',
    'Modo bilingüe: responde solo en inglés a partir de ahora durante 5 minutos',
    'Sostén una conversación con el jugador de tu derecha solo haciendo señas',
    'Di el nombre de todos los jugadores presentes al revés',
    'Cuenta un chiste, si nadie se ríe recibe un shock ⚡️',
    'Haz una rima improvisada usando el nombre de tres jugadores',
    'Nombra a 5 animales que empiecen con la letra L',
    'Di las capitales de todos los países de Sudamérica',
    'Baila una canción que te guste en frente de todos',

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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child:
                            Text('Shot', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Shock',
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Continuar',
                            style: TextStyle(color: Colors.white)),
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
                    onPressed: _girarRuleta,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
