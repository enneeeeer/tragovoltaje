import 'package:flutter/material.dart';

class ControlarVoltaje extends StatelessWidget {
  const ControlarVoltaje({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSliderVoltage(
            icon: Icons.battery_charging_full,
            value: 0.5, // Valor inicial (medio)
            onChanged: (value) {
              print("Potencia: $value");
            },
          ),
          SizedBox(width: 20), // Espaciado entre sliders
          CustomSliderTime(
            icon: Icons.timer,
            value: 1.0, // Valor inicial (1 segundo)
            onChanged: (value) {
              print("Tiempo: $value");
            },
          ),
        ],
      ),
    );
  }
}

class CustomSliderVoltage extends StatefulWidget {
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
  _CustomSliderVoltageState createState() => _CustomSliderVoltageState();
}

class _CustomSliderVoltageState extends State<CustomSliderVoltage> {
  late double _currentValue;

  // Define los niveles
  final List<double> levels = [0.0, 0.5, 1.0]; // Bajo, Medio, Alto
  final List<String> levelLabels = ["Bajo", "Medio", "Alto"]; // Etiquetas

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  void _onSliderChanged(double value) {
    double closestLevel = levels.reduce((a, b) => (value - a).abs() < (value - b).abs() ? a : b);
    setState(() {
      _currentValue = closestLevel;
    });
    widget.onChanged(closestLevel);
  }

  Color _getTrackColor() {
    if (_currentValue == levels[0]) {
      return Colors.green; // Bajo
    } else if (_currentValue == levels[1]) {
      return Colors.orange; // Medio
    } else {
      return Colors.red; // Alto
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = levels.indexOf(_currentValue);
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
            quarterTurns: -1, // Hace el Slider vertical
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _getTrackColor(),
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.white,
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              ),
              child: Slider(
                value: _currentValue,
                min: levels.first,
                max: levels.last,
                divisions: levels.length - 1,
                onChanged: _onSliderChanged,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(levelLabels[currentIndex], style: TextStyle(color: Colors.white)), // Etiqueta de nivel
        Icon(widget.icon, color: Colors.white),
      ],
    );
  }
}

class CustomSliderTime extends StatefulWidget {
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
  _CustomSliderTimeState createState() => _CustomSliderTimeState();
}

class _CustomSliderTimeState extends State<CustomSliderTime> {
  late double _currentValue;

  // Define los niveles de tiempo
  final List<double> timeLevels = [1.0, 2.0, 3.0]; // 1 seg, 2 seg, 3 seg
  final List<String> timeLabels = ["1 seg", "2 seg", "3 seg"]; // Etiquetas de tiempo

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  void _onSliderChanged(double value) {
    double closestTimeLevel = timeLevels.reduce((a, b) => (value - a).abs() < (value - b).abs() ? a : b);
    setState(() {
      _currentValue = closestTimeLevel;
    });
    widget.onChanged(closestTimeLevel);
  }

  Color _getTrackColor() {
    if (_currentValue == timeLevels[0]) {
      return Colors.green; // 1 seg
    } else if (_currentValue == timeLevels[1]) {
      return Colors.orange; // 2 seg
    } else {
      return Colors.red; // 3 seg
    }
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = timeLevels.indexOf(_currentValue);
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
            quarterTurns: -1, // Hace el Slider vertical
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: _getTrackColor(),
                inactiveTrackColor: Colors.grey,
                thumbColor: Colors.white,
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
              ),
              child: Slider(
                value: _currentValue,
                min: timeLevels.first,
                max: timeLevels.last,
                divisions: timeLevels.length - 1,
                onChanged: _onSliderChanged,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(timeLabels[currentIndex], style: TextStyle(color: Colors.white)), // Etiqueta de tiempo
        Icon(widget.icon, color: Colors.white),
      ],
    );
  }
}