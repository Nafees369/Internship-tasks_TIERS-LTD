import 'package:flutter/material.dart';
import 'exercise1_counter.dart';
import 'exercise2.dart';
import 'exercise3.dart';
import 'exercise4.dart';
import 'exercise5.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stateful Exercises',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Stateful Exercises'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[700],
      ),
      body: Center(
        child: SingleChildScrollView( // Use SingleChildScrollView for more options in the future
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Make buttons stretch
            children: <Widget>[
              _buildExerciseButton(
                context,
                'Exercise 1: Stateful Counter',
                const Exercise1Counter(),
                Colors.blueAccent,
              ),
              const SizedBox(height: 15),
              _buildExerciseButton(
                context,
                'Exercise 2: Checkbox',
                const Exercise2Checkbox(),
                Colors.green,
              ),
              const SizedBox(height: 15),
              _buildExerciseButton(
                context,
                'Exercise 3: Switch',
                const Exercise3Switch(),
                Colors.orange,
              ),
              const SizedBox(height: 15),
              _buildExerciseButton(
                context,
                'Exercise 4: TextField',
                const Exercise4TextField(),
                Colors.purple,
              ),
              const SizedBox(height: 15),
              _buildExerciseButton(
                context,
                'Exercise 5: TextFormField with Validation',
                const Exercise5TextFormField(),
                Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseButton(BuildContext context, String title, Widget exerciseWidget, Color color) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => exerciseWidget),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title),
    );
  }
}