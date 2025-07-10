import 'package:flutter/material.dart';

class Exercise4TextField extends StatefulWidget {
  const Exercise4TextField({super.key});

  @override
  State<Exercise4TextField> createState() => _Exercise4TextFieldState();
}

class _Exercise4TextFieldState extends State<Exercise4TextField> {
  String _enteredText = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose(); // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 4: TextField'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _textEditingController,
              onChanged: (value) {
                setState(() {
                  _enteredText = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text here',
                hintText: 'Type something...',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Entered Text:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _enteredText.isEmpty ? 'No text entered yet.' : _enteredText,
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}