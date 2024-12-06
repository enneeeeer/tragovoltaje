import 'dart:async';
import 'package:TragoVoltaje/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  
import 'package:shared_preferences/shared_preferences.dart';  

class ControlarVoltaje extends StatefulWidget {  
  const ControlarVoltaje({super.key});  

  @override  
  _ControlarVoltajeState createState() => _ControlarVoltajeState();  
}  

class _ControlarVoltajeState extends State<ControlarVoltaje> {
  bool _isButtonTestEnabled = true;
  double _timeValue = 1.0; // Valor inicial para el tiempo  

  @override  
  void initState() {  
    super.initState();  
    _loadSettings(); // Carga los valores cuando se inicializa el estado  
  }  

  // Cargar configuraciones guardadas  
  Future<void> _loadSettings() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();  
    setState(() {  
      _timeValue = prefs.getDouble('time') ?? 1.0;  
    });  
  }  

  // Guardar configuraciones  
  Future<void> _saveSettings() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('time', _timeValue);  
    final bluetoothModel = Provider.of<BluetoothModel>(context, listen: false); 
    if (_timeValue == 1.0) {
      bluetoothModel.sendConfig('1', context);
    } else if (_timeValue == 2.0) {
      bluetoothModel.sendConfig('2', context);
    } else if (_timeValue == 3.0) {
      bluetoothModel.sendConfig('3', context);
    } else if (_timeValue == 4.0) {
      bluetoothModel.sendConfig('4', context);
    } else if (_timeValue == 5.0) {
      bluetoothModel.sendConfig('5', context);
    }
  }  

  void _testDescarga() {
    if (_isButtonTestEnabled) {
      final bluetoothModel = Provider.of<BluetoothModel>(context, listen: false);
      bluetoothModel.sendMessage('0');

      // Deshabilitar el botón
      setState(() {
        _isButtonTestEnabled = false;
      });

      // Habilitar el botón después de _timeValue segundos
      Timer(Duration(seconds: _timeValue.toInt()), () {
        setState(() {
          _isButtonTestEnabled = true;
        });
      });
    }
  }

  @override  
  Widget build(BuildContext context) {  
    final bluetoothModel = Provider.of<BluetoothModel>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFA726), // Naranja vibrante
              Color(0xFFEC407A), // Rosa vibrante
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(  
          child: Column(  
            mainAxisAlignment: MainAxisAlignment.center,  
            children: [  
              Text(  
                'Control de Descargas',  
                style: TextStyle(  
                  fontSize: 24,  
                  fontWeight: FontWeight.bold,  
                  color: Colors.white,  
                ),  
              ),  
              SizedBox(height: 20), // Espaciado entre el título y los sliders  
              Row(  
                mainAxisAlignment: MainAxisAlignment.center,  
                children: [ 
                  CustomSliderTime(  
                    icon: Icons.timer,  
                    value: _timeValue,  
                    onChanged: (value) {  
                      setState(() {  
                        _timeValue = value;  
                      });  
                    },  
                  ),  
                ],  
              ),  
              SizedBox(height: 20),
              Text(
                bluetoothModel.connectionStatus,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 20), 
              ElevatedButton(  
                onPressed: _saveSettings,  
                child: const Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white
                  )
                  ),  
                style: ElevatedButton.styleFrom(  
                  backgroundColor: Colors.blueAccent, // Color del botón  
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
                  textStyle: TextStyle(fontSize: 18),  
                ),  
              ),
              SizedBox(height: 20), 
              GestureDetector(
                onTap: _testDescarga,
                child: Text(
                  '¿Quieres probar la descarga? Haz clic aquí',
                  style: TextStyle(
                    fontSize: 16,
                    color: _isButtonTestEnabled ? Colors.white : Colors.grey,
                  ),
                ),
              ),  
            ],  
          ),  
        ),
      ),
    );
  }  
}

class CustomSliderTime extends StatelessWidget {  
  final IconData icon;  
  final double value;  
  final ValueChanged<double> onChanged;  

  const CustomSliderTime({  
    Key? key,  
    required this.icon,  
    required this.value,  
    required this.onChanged,  
  }) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return _SliderWidget(value: value, onChanged: onChanged, icon: icon, levels: [1.0, 2.0, 3.0, 4.0, 5.0], labels: ["1 tiempo", "2 tiempos", "3 tiempos", "4 tiempos", "5 tiempos"]);  
  }  
}  

class _SliderWidget extends StatefulWidget {  
  final double value;  
  final ValueChanged<double> onChanged;  
  final IconData icon;  
  final List<double> levels;  
  final List<String> labels;  

  const _SliderWidget({  
    Key? key,  
    required this.value,  
    required this.onChanged,  
    required this.icon,  
    required this.levels,  
    required this.labels,  
  }) : super(key: key);  

  @override  
  State<_SliderWidget> createState() => _SliderWidgetState();  
}  

class _SliderWidgetState extends State<_SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(30),
          ),
          child: RotatedBox(
            quarterTurns: -1,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _getTrackColor(widget.value),
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.white,
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              ),
              child: Slider(
                value: widget.value,  // Usar el valor del widget directamente
                min: widget.levels.first,
                max: widget.levels.last,
                divisions: widget.levels.length - 1,
                onChanged: (value) {
                  double closestLevel = widget.levels.reduce((a, b) => (value - a).abs() < (value - b).abs() ? a : b);
                  widget.onChanged(closestLevel);
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(widget.labels[widget.levels.indexOf(widget.value)], style: TextStyle(color: Colors.white)),
        Icon(widget.icon, color: Colors.white),
      ],
    );
  }

  Color _getTrackColor(double value) {
    int index = widget.levels.indexOf(value);
    switch (index) {
      case 0: return Colors.lightGreenAccent; // Bajo
      case 1: return Colors.yellow; // Bajo - Medio
      case 2: return Colors.orange; // Medio
      case 3: return Colors.red; // Medio - Alto
      case 4: return const Color.fromARGB(255, 203, 1, 1); // Alto
      default: return Colors.grey;
    }
  }
}