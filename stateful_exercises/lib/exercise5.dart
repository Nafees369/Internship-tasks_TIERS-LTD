import 'package:flutter/material.dart';

class Exercise5TextFormField extends StatefulWidget {
  const Exercise5TextFormField({super.key});

  @override
  State<Exercise5TextFormField> createState() => _Exercise5TextFormFieldState();
}

class _Exercise5TextFormFieldState extends State<Exercise5TextFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _enteredText = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Triggers onSaved if present in TextFormField
      setState(() {
        _enteredText = _textEditingController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5: TextFormField with Validation'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text (required)',
                  hintText: 'Something important...',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null; // Return null if the input is valid
                },
                // onSaved: (value) { // Optional: You can use onSaved if you need to save the value separately
                //   _enteredText = value ?? '';
                // },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Submitted Text:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                _enteredText.isEmpty ? 'No text submitted yet.' : _enteredText,
                style: const TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}