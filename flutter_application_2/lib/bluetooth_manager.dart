import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';  
import 'package:flutter_blue_plus/flutter_blue_plus.dart';  
import 'package:shared_preferences/shared_preferences.dart';

class BluetoothModel extends ChangeNotifier {  
  BluetoothDevice ? _connectedDevice;  
  String connectionStatus = 'No conectado';
  List<BluetoothService>? services;
  StreamSubscription<BluetoothConnectionState>? _stateSubscription;

  BluetoothDevice? get connectedDevice => _connectedDevice;  

  Future<void> cargarYEnviarConfiguracion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double voltageValue = prefs.getDouble('voltage') ?? 0.0; // Valor por defecto
    double timeValue = prefs.getDouble('time') ?? 1.0; // Valor por defecto

    // Enviar señales según la configuración cargada
    if (voltageValue == 0.0 && timeValue == 1.0) {
      sendMessage('1');
    } else if (voltageValue == 0.0 && timeValue == 2.0) {
      sendMessage('2');
    } else if (voltageValue == 0.0 && timeValue == 3.0) {
      sendMessage('3');
    } else if (voltageValue == 0.5 && timeValue == 1.0) {
      sendMessage('4');
    } else if (voltageValue == 0.5 && timeValue == 2.0) {
      sendMessage('5');
    } else if (voltageValue == 0.5 && timeValue == 3.0) {
      sendMessage('6');
    } else if (voltageValue == 1.0 && timeValue == 1.0) {
      sendMessage('7');
    } else if (voltageValue == 1.0 && timeValue == 2.0) {
      sendMessage('8');
    } else if (voltageValue == 1.0 && timeValue == 3.0) {
      sendMessage('9');
    }
  }

  void _handleDisconnection(BuildContext context) {
    connectionStatus = 'Desconectado';
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('La conexión se ha perdido.')),
    );
  }

  Future<void> connect(BluetoothDevice device, BuildContext context) async {  
    try {  
      await device.connect();  
      _connectedDevice = device;  
      services = await device.discoverServices();
      notifyListeners();  
      print('Conectado a ${device.platformName} (${device.remoteId})');  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(
          content: Text('${device.platformName} conectada con éxito'), 
          duration: Duration(seconds: 1),
        ),  
      );
      connectionStatus = 'Conectado a ${device.platformName}';
      notifyListeners();
      cargarYEnviarConfiguracion(context);
      _stateSubscription = device.connectionState.listen((state) {
        if (state == BluetoothConnectionState.disconnected) {
          _handleDisconnection(context);
        }
      });
    } catch (e) {  
      connectionStatus = 'No se pudo conectar a ${device.platformName}';
      notifyListeners();
    }  
  }  

  void sendConfig(String message, context) {  
    if ((connectedDevice != null && services != null) && (connectionStatus != 'Desconectado')) {
      // ignore: avoid_print
      print('Si se encontraron servicios');
      const String serviceUUID = "4fafc201-1fb5-459e-8d6c-78eaa0e9d4f0"; // Cambia esto por tu UUID
      const String characteristicUUID = "beb5483e-36e1-4688-b7f5-5a2f1a3f5c04"; // Cambia esto por tu UUID

      BluetoothService? service = services!.firstWhere((s) => s.uuid.toString() == serviceUUID);
      BluetoothCharacteristic characteristic = service.characteristics.firstWhere((c) => c.uuid.toString() == characteristicUUID);

      // Enviar el mensaje
      characteristic.write(utf8.encode(message)); // Envía el mensaje como bytes
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Configuración guardada correctamente'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo guardar la configuración. Conexión perdida.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } 

  void sendMessage(String message) {  
    if ((connectedDevice != null && services != null) && (connectionStatus != 'Desconectado')) {
      // ignore: avoid_print
      print('Si se encontraron servicios');
      const String serviceUUID = "4fafc201-1fb5-459e-8d6c-78eaa0e9d4f0"; // Cambia esto por tu UUID
      const String characteristicUUID = "beb5483e-36e1-4688-b7f5-5a2f1a3f5c04"; // Cambia esto por tu UUID

      BluetoothService? service = services!.firstWhere((s) => s.uuid.toString() == serviceUUID);
      BluetoothCharacteristic characteristic = service.characteristics.firstWhere((c) => c.uuid.toString() == characteristicUUID);

      // Enviar el mensaje
      characteristic.write(utf8.encode(message)); // Envía el mensaje como bytes
    }
  }  

  void disconnect() {  
    if (_connectedDevice != null) {
      _connectedDevice!.disconnect();  
      _connectedDevice = null;  
      notifyListeners();  
      connectionStatus = 'Desconectado';
    }
  }  

  @override
  void dispose() {
    _stateSubscription?.cancel();
    disconnect(); // Desconectar el dispositivo al cerrar la aplicación
    super.dispose();
  }
}