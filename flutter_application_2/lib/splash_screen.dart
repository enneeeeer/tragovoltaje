import 'package:flutter/material.dart';
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
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Imagen de fondo que cubre toda la pantalla
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: Image.asset(
                'assets/images/lightning.jpg',
                fit: BoxFit.cover, // Para que la imagen se adapte al tamaño de la pantalla
              ),
            ),
          ),
          // Oculto cuando allVisible es false
          Center(
            child: Visibility(
              visible: allVisible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿LISTO PARA ELECTRIZARTE?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'TRAGOVOLTAJE',
                    style: TextStyle(
                      color: Color.fromARGB(255, 12, 19, 154),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    'assets/images/logo-sin-fondo.png', // Asegúrate de tener logo.png en la carpeta assets/images
                    height: 200,
                    width: 200,
                  ),
                  ElevatedButton(
                    onPressed: _startAnimation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 1, 32, 143),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text('Iniciar'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
