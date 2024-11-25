import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';  
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';  
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class BluetoothModel extends ChangeNotifier {  
  BluetoothConnection? _connection;  
  BluetoothDevice? _connectedDevice;  
  String connectionStatus = 'No conectado';

  BluetoothDevice? get connectedDevice => _connectedDevice;  

  Future<void> cargarYEnviarConfiguracion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double voltageValue = prefs.getDouble('voltage') ?? 0.0; // Valor por defecto
    double timeValue = prefs.getDouble('time') ?? 1.0; // Valor por defecto

    final bluetoothModel = Provider.of<BluetoothModel>(context, listen: false);
    
    // Enviar señales según la configuración cargada
    if (voltageValue == 0.0 && timeValue == 1.0) {
      bluetoothModel.sendMessage('1');
    } else if (voltageValue == 0.0 && timeValue == 2.0) {
      bluetoothModel.sendMessage('2');
    } else if (voltageValue == 0.0 && timeValue == 3.0) {
      bluetoothModel.sendMessage('3');
    } else if (voltageValue == 0.5 && timeValue == 1.0) {
      bluetoothModel.sendMessage('4');
    } else if (voltageValue == 0.5 && timeValue == 2.0) {
      bluetoothModel.sendMessage('5');
    } else if (voltageValue == 0.5 && timeValue == 3.0) {
      bluetoothModel.sendMessage('6');
    } else if (voltageValue == 1.0 && timeValue == 1.0) {
      bluetoothModel.sendMessage('7');
    } else if (voltageValue == 1.0 && timeValue == 2.0) {
      bluetoothModel.sendMessage('8');
    } else if (voltageValue == 1.0 && timeValue == 3.0) {
      bluetoothModel.sendMessage('9');
    }
  }

  Future<void> connect(BluetoothDevice device, context) async {  
    try {  
      _connection = await BluetoothConnection.toAddress(device.address);  
      _connectedDevice = device;  
      notifyListeners();  
      print('Conectado a ${device.name} (${device.address})');  
      ScaffoldMessenger.of(context).showSnackBar(  
        SnackBar(
          content: Text('${device.name} conectada con éxito'), 
          duration: Duration(seconds: 1),
        ),  
      );
      connectionStatus = 'Conectado a ${device.name}';
      notifyListeners();
      cargarYEnviarConfiguracion(context);
    } catch (e) {  
      connectionStatus = 'No se pudo conectar a ${device.name}';
      notifyListeners();
    }  
  }  

  void sendMessage(String message) {  
    if (_connection?.isConnected ?? false) {  
      _connection?.output.add(Uint8List.fromList(utf8.encode(message + "\n")));  
    }  
  }  

  void sendConfig(String message, context) {  
    if (_connection?.isConnected ?? false) {  
      _connection?.output.add(Uint8List.fromList(utf8.encode(message + "\n")));  
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

  void disconnect() {  
    _connection?.dispose();  
    _connectedDevice = null;  
    notifyListeners();  
  }  
}