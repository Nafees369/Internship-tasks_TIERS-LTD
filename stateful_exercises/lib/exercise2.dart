import 'package:flutter/material.dart';

class Exercise2Checkbox extends StatefulWidget {
  const Exercise2Checkbox({super.key});

  @override
  State<Exercise2Checkbox> createState() => _Exercise2CheckboxState();
}

class _Exercise2CheckboxState extends State<Exercise2Checkbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2: Checkbox'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? newValue) {
                    setState(() {
                      _isChecked = newValue ?? false;
                    });
                  },
                ),
                const Text('Check me!'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _isChecked ? 'Checkbox is checked!' : 'Checkbox is unchecked.',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}