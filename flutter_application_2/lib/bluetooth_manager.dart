import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';  
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';  

class BluetoothModel extends ChangeNotifier {  
  BluetoothConnection? _connection;  
  BluetoothDevice? _connectedDevice;  

  BluetoothDevice? get connectedDevice => _connectedDevice;  

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
    } catch (e) {  
      print('No se pudo conectar: $e');  
    }  
  }  

  void sendMessage(String message) {  
    if (_connection?.isConnected ?? false) {  
      _connection?.output.add(Uint8List.fromList(utf8.encode(message + "\n")));  
    }  
  }  

  void disconnect() {  
    _connection?.dispose();  
    _connectedDevice = null;  
    notifyListeners();  
  }  
}