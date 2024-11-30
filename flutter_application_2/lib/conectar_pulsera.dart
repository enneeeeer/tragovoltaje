import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart'; 
import 'package:TragoVoltaje/bluetooth_manager.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:geolocator/geolocator.dart';

class ConectarPulsera extends StatefulWidget {
  const ConectarPulsera({super.key});

  @override
  _ConectarPulseraState createState() => _ConectarPulseraState();
}

class _ConectarPulseraState extends State<ConectarPulsera> {
  BluetoothDevice? connectedDevice;
  List<BluetoothDevice> devices = [];
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermission();
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Si el permiso está denegado, abrir la configuración de la aplicación
      await openAppSettings();
    } else if (status.isGranted) {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      print('Location service enabled: $serviceEnabled');
      if (!serviceEnabled) {
        const intent = AndroidIntent(
          action: 'android.settings.LOCATION_SOURCE_SETTINGS',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        intent.launch();
      }
    }
  }

  Future<void> _requestBluetoothPermission() async {
    var status = await Permission.bluetooth.request();
    if (status.isGranted) {
      await FlutterBluePlus.turnOn();
      await Future.delayed(Duration(seconds: 1));
      _checkLocationPermission();
      return;
    } else {
      // El usuario no otorgó el permiso
      Future.delayed(Duration.zero, () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Es necesario acceder al Bluetooth para poder jugar con la pulsera.'),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }

  void startScan() async {
    _requestBluetoothPermission();
    setState(() {
      isScanning = true; // Deshabilitar el botón
    });

    // Iniciar escaneo
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 3));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        // Filtrar dispositivos que tienen nombre
        devices = results
            .map((r) => r.device)
            .where((device) => device.platformName.isNotEmpty) // Filtrar dispositivos sin nombre
            .toList();
      });
    });

    // Esperar 3 segundos
    await Future.delayed(const Duration(seconds: 3));

    // Detener escaneo
    FlutterBluePlus.stopScan();
    setState(() {
      isScanning = false; // Habilitar el botón nuevamente
    });
  }

  @override
  Widget build(BuildContext context) {
    final bluetoothModel = Provider.of<BluetoothModel>(context);
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Pulse(
                duration: const Duration(seconds: 2),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text('CONECTA TU PULSERA',
                      style: TextStyle(
                        fontSize: 32,
                        color: const Color.fromARGB(255, 244, 83, 3),
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: const Color.fromARGB(255, 255, 162, 68),
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center),
                ),
              ),
              SizedBox(height: 25),
              ZoomIn(
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  'assets/images/blutu.png', // Ruta
                  width: 150, // ancho
                  height: 150, // altura
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: isScanning ? null : startScan, // Deshabilitar si está escaneando
                child: const Text('Iniciar Escaneo'),
              ),
              SizedBox(height: 25),
              FadeIn(
                duration: const Duration(seconds: 1),
                child: DropdownButton<BluetoothDevice>(
                  hint: Text(
                    'Selecciona un dispositivo',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: connectedDevice,
                  onChanged: (BluetoothDevice? device) {
                    if (device != null) {
                      bluetoothModel.connect(device, context);
                    }
                  },
                  items: devices.map((BluetoothDevice device) {
                    return DropdownMenuItem<BluetoothDevice>(
                      value: device,
                      child: Text(device.platformName),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                bluetoothModel.connectionStatus,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    FlutterBluePlus.stopScan();
    super.dispose();
  }
}