import 'package:flutter/material.dart';

class Exercise3Switch extends StatefulWidget {
  const Exercise3Switch({super.key});

  @override
  State<Exercise3Switch> createState() => _Exercise3SwitchState();
}

class _Exercise3SwitchState extends State<Exercise3Switch> {
  bool _isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3: Switch'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Toggle Switch: '),
                Switch(
                  value: _isSwitched,
                  onChanged: (bool newValue) {
                    setState(() {
                      _isSwitched = newValue;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _isSwitched ? 'Switch is ON' : 'Switch is OFF',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}