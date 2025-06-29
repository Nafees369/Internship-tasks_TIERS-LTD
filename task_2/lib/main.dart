import 'package:flutter/material.dart';
import 'exercise1.dart' as ex1;
import 'exercise2.dart' as ex2;
import 'exercise3.dart' as ex3;
import 'exercise4.dart' as ex4;
import 'exercise5.dart' as ex5;
import 'exercise6.dart' as ex6;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart Exercises',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Using Inter font as per instructions
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _output = [];

  @override
  void initState() {
    super.initState();
    _runAllExercises();
  }

  void _runAllExercises() {
    _output.clear();
    _output.add("--- Running All Dart Exercises ---");

    // Exercise 1: Declare Variables
    _output.add("\n--- Exercise 1: Declare Variables ---");
    final ex1Result = ex1.declareVariables();
    _output.add("Name: ${ex1Result['name']}");
    _output.add("Age: ${ex1Result['age']}");
    _output.add("Favorite Colors: ${ex1Result['colors']}");

    // Exercise 2: Control Flow
    _output.add("\n--- Exercise 2: Control Flow ---");
    _output.add("Is 7 even or odd? ${ex2.checkEvenOrOdd(7)}");
    _output.add("Is 10 even or odd? ${ex2.checkEvenOrOdd(10)}");

    // Exercise 3: Functions
    _output.add("\n--- Exercise 3: Functions ---");
    double radius = 5.0;
    _output.add("Area of circle with radius $radius: ${ex3.calculateCircleArea(radius).toStringAsFixed(2)}");

    // Exercise 4: Classes
    _output.add("\n--- Exercise 4: Classes ---");
    ex4.Car myCar = ex4.Car('Toyota', 'Camry', 2020);
    _output.add(myCar.getCarDetails()); // Get details as a string

    // Exercise 5: Getters and Setters
    _output.add("\n--- Exercise 5: Getters and Setters ---");
    ex5.Student student = ex5.Student('Alice', 20);
    _output.add("Initial Student Details: ${student.getStudentDetails()}");
    student.name = 'Alicia'; // Using setter
    student.age = 21;       // Using setter
    _output.add("Updated Student Details: ${student.getStudentDetails()}");
    _output.add("Student Name (getter): ${student.name}");
    _output.add("Student Age (getter): ${student.age}");

    // Exercise 6: Inheritance
    _output.add("\n--- Exercise 6: Inheritance ---");
    ex6.Vehicle genericVehicle = ex6.Vehicle();
    _output.add("Generic Vehicle: ${genericVehicle.move()}");
    ex6.Bicycle myBicycle = ex6.Bicycle();
    _output.add("My Bicycle: ${myBicycle.move()}");

    _output.add("\n--- All Exercises Completed ---");

    setState(() {}); // Update the UI to show the output
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dart Exercises Runner'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _runAllExercises,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                elevation: 5,
                shadowColor: Colors.blueAccent.withOpacity(0.5),
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Run All Exercises'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  itemCount: _output.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Text(
                        _output[index],
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          color: _output[index].startsWith('---') ? Colors.blue.shade800 : Colors.black87,
                          fontWeight: _output[index].startsWith('---') ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}





















