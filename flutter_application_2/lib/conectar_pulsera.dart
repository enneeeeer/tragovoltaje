import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' hide BluetoothDevice;  
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:TragoVoltaje/bluetooth_manager.dart';
import 'package:provider/provider.dart';

class ConectarPulsera extends StatefulWidget {
  const ConectarPulsera({super.key});

  @override
  _ConectarPulseraState createState() => _ConectarPulseraState();
}

class _ConectarPulseraState extends State<ConectarPulsera> {
  BluetoothConnection? connection;
  BluetoothDevice? connectedDevice;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermission();
    _getBondedDevices();
  }

    Future<void> _getBondedDevices() async {
    // Listar dispositivos emparejados
    List<BluetoothDevice> bondedDevices = await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      devices = bondedDevices; // Almacenar dispositivos emparejados
    });
  }

  Future<void> _requestBluetoothPermission() async {
    var status = await Permission.bluetooth.request();
    if (status.isGranted) {
      // Permiso concedido, intenta encender Bluetooth
      try {
        await FlutterBluePlus.turnOn();
        await Future.delayed(Duration(seconds: 1));
        await _getBondedDevices();
      } catch (e) {
        // Manejar la excepción si no se puede encender Bluetooth
        Future.delayed(Duration.zero, () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No se pudo encender Bluetooth.'),
              duration: Duration(seconds: 3),
            ),
          );
        });
      }
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

  @override
  Widget build(BuildContext context) {
    final bluetoothModel = Provider.of<BluetoothModel>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Alinear al inicio
        children: [
          Container(
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
          SizedBox(height: 25),
          Image.asset(
            'assets/images/blutu.png', // Ruta
            width: 150, // ancho
            height: 150, // altura
          ),
          SizedBox(height: 25),
          DropdownButton<BluetoothDevice>(
            hint: Text('Selecciona un dispositivo', style: TextStyle(color: Colors.white),),
            value: connectedDevice,
            onChanged: (BluetoothDevice? device) {
              if (device != null) {
                bluetoothModel.connect(device, context);
              }
            },
            items: devices.map((BluetoothDevice device) {
              return DropdownMenuItem<BluetoothDevice>(
                value: device,
                child: Text(device.name ?? "Desconocido"),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text(
            bluetoothModel.connectionStatus,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ],
      ),
    );
  }
}