import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:convert';

class BluetoothControl extends StatefulWidget {
  @override
  _BluetoothControlState createState() => _BluetoothControlState();
}

class _BluetoothControlState extends State<BluetoothControl> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();
  BluetoothDevice? connectedDevice;

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });
  }

  void sendCommand(String command) async {
    if (connectedDevice != null) {
      List<BluetoothService> services = await connectedDevice!.discoverServices();
      // Encuentra el servicio y la característica correctos
      // Aquí debes ajustar el UUID según tu configuración
      var characteristic = services
          .expand((s) => s.characteristics)
          .firstWhere((c) => c.uuid.toString() == "YOUR_CHARACTERISTIC_UUID");

      await characteristic.write(utf8.encode(command));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control Bluetooth'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => sendCommand('1'),
            child: Text('Encender LED 1'),
          ),
          ElevatedButton(
            onPressed: () => sendCommand('2'),
            child: Text('Apagar LED 1'),
          ),
          // Agrega más botones para otros LEDs
        ],
      ),
    );
  }
}