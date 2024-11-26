import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; // Importa el paquete para las animaciones
import 'home_page.dart'; // Importa home_page.dart para navegar

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin {
  bool _visible = false;
  bool allVisible = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    setState(() {
      _visible = !_visible;
      allVisible = false; // Oculta el botón al iniciar la animación
    });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFA726), // Naranja vibrante
              Color(0xFFEC407A), // Rosa brillante
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Imagen de fondo animada
            Positioned.fill(
              child: AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  'assets/images/lightning.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: allVisible,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pulse(
                        duration: const Duration(seconds: 2),
                        child: const Text(
                          '¿LISTO PARA ELECTRIZARTE?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                blurRadius: 20.0,
                                color: Colors.yellow,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 10),
                    // Animación de FadeIn para el subtítulo
                    FadeIn(
                      duration: const Duration(seconds: 1),
                      delay: const Duration(milliseconds: 500), // Retraso para un efecto más dinámico
                      child: Text(
                        '⚡ TRAGOVOLTAJE ⚡',
                        style: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoMono',
                          letterSpacing: 2.0,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black54,
                              offset: Offset(3, 3),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Imagen del logo con animación
                    ZoomIn(
                      duration: const Duration(seconds: 1),
                      child: Image.asset(
                        'assets/images/nuevo-logo.png',
                        height: 250,
                        width: 250,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Botón con animación de Bounce
                    Bounce(
                      duration: const Duration(milliseconds: 800),
                      child: ElevatedButton(
                        onPressed: _startAnimation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E88E5), // Azul vibrante
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8.0,
                          shadowColor: Colors.black45,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 60,
                            vertical: 15,
                          ),
                        ),
                        child: const Text(
                          '¡EMPEZAR!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
