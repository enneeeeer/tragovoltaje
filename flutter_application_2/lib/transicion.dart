import 'package:flutter/material.dart';

class LightningTransition extends StatefulWidget {
  final Widget child;
  
  const LightningTransition({super.key, required this.child});
  
  @override
  _LightningTransitionState createState() => _LightningTransitionState();
}

class _LightningTransitionState extends State<LightningTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _visible = true; // Muestra el contenido después de la animación
          });
          _controller.reverse(); // Reversa la animación para hacer desaparecer la transición
        } else if (status == AnimationStatus.dismissed) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => widget.child),
          );
        }
      });
    _controller.forward(); // Comienza la animación al cargar el widget
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_visible) widget.child, // Muestra el contenido después de la animación
        AnimatedOpacity(
          opacity: _controller.value,
          duration: _controller.duration!,
          child: Image.asset(
            'assets/images/lightning.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
