import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'BMI CALCULATOR',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // the controller for the text field associated with "height"
  final _heightController = TextEditingController();

  // the controller for the text field associated with "weight"
  final _weightController = TextEditingController();

  double? _bmi;
  // the message at the beginning
  String _message = 'Please enter your height an weight';

  // This function is triggered when the user pressess the "Calculate" button
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }

    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('BMI CALCULATOR'),
        ),
        body: Center(
          child: SizedBox(
            width: 500,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration:
                      const InputDecoration(labelText: 'Height (m)'),
                      controller: _heightController,
                    ),
                    TextField(
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'Weight (kg)',
                      ),
                      controller: _weightController,
                    ),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      _bmi == null ? 'Result' : _bmi!.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      _message,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}