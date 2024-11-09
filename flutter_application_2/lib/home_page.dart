import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _showTitle = true;

  @override
  void initState() {
    super.initState();
    // Inicia un temporizador que ocultará el titulo luego de unos segundos
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showTitle = false;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _widgetOptions = <Widget>[
    const Center(child: Text('Home')),
    const Center(child: Text('Perfil')),
    const Center(child: Text('Ajustes')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: AnimatedOpacity(
          opacity: _showTitle ? 1.0 : 0.0, 
          duration: const Duration(seconds: 1),
          child: const Center(child: Text('¡Bienvenido a Tragovoltaje!')),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: const Icon(Icons.account_box),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem <int>(
                value: 0,
                child: Text('Registrarse'),
              ),
              const PopupMenuItem <int>(
                value: 1,
                child: Text('Iniciar Sesion'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Cerrar Sesion'),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.blue,
              alignment: Alignment.centerLeft,
              child: const Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              title: const Text('Ajustes'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context); // Cierra el drawer
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
