import 'package:flutter/material.dart';  
import 'package:shared_preferences/shared_preferences.dart';  

class ControlarVoltaje extends StatefulWidget {  
  const ControlarVoltaje({super.key});  

  @override  
  _ControlarVoltajeState createState() => _ControlarVoltajeState();  
}  

class _ControlarVoltajeState extends State<ControlarVoltaje> {  
  double _voltageValue = 0.5; // Valor inicial para el voltaje  
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
      _voltageValue = prefs.getDouble('voltage') ?? 0.5;  
      _timeValue = prefs.getDouble('time') ?? 1.0;  
    });  
  }  

  // Guardar configuraciones  
  Future<void> _saveSettings() async {  
    SharedPreferences prefs = await SharedPreferences.getInstance();  
    await prefs.setDouble('voltage', _voltageValue);  
    await prefs.setDouble('time', _timeValue);  
    ScaffoldMessenger.of(context).showSnackBar(  
      SnackBar(content: Text('Configuraciones guardadas')),  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: Column(  
        mainAxisAlignment: MainAxisAlignment.center,  
        children: [  
          Text(  
            'Controles de Descargas',  
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
              CustomSliderVoltage(  
                icon: Icons.battery_charging_full,  
                value: _voltageValue,  
                onChanged: (value) {  
                  setState(() {  
                    _voltageValue = value;  
                  });  
                },  
              ),  
              SizedBox(width: 20), // Espaciado entre sliders  
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
          SizedBox(height: 20), // Espaciado entre los sliders y el botón  
          ElevatedButton(  
            onPressed: _saveSettings,  
            child: Text('Guardar'),  
            style: ElevatedButton.styleFrom(  
              backgroundColor: Colors.blueAccent, // Color del botón  
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),  
              textStyle: TextStyle(fontSize: 18),  
            ),  
          ),  
        ],  
      ),  
    );  
  }  
}  

class CustomSliderVoltage extends StatelessWidget {  
  final IconData icon;  
  final double value;  
  final ValueChanged<double> onChanged;  

  const CustomSliderVoltage({  
    Key? key,  
    required this.icon,  
    required this.value,  
    required this.onChanged,  
  }) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return _SliderWidget(value: value, onChanged: onChanged, icon: icon, levels: [0.0, 0.5, 1.0], labels: ["Bajo", "Medio", "Alto"]);  
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
    return _SliderWidget(value: value, onChanged: onChanged, icon: icon, levels: [1.0, 2.0, 3.0], labels: ["1 seg", "2 seg", "3 seg"]);  
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
      case 0: return Colors.green; // Bajo
      case 1: return Colors.orange; // Medio
      case 2: return Colors.red; // Alto
      default: return Colors.grey;
    }
  }
}