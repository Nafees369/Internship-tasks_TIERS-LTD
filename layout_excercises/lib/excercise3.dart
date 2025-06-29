import 'package:flutter/material.dart';

class Exercise3WidgetTree extends StatelessWidget {
  const Exercise3WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the widget tree structure:
    // MaterialApp
    //   Scaffold
    //     AppBar
    //     Center
    //       Column
    //         Container (1)
    //         Container (2)

    return MaterialApp(
      title: 'Widget Tree Exercise',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 3: Widget Tree'),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          // Inside the Center widget, add a Column
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Add two Container widgets inside the Column
              const Text(
                'I am inside the Column',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Container(
                width: 150,
                height: 100,
                color: Colors.pink,
                margin: const EdgeInsets.all(10),
                child: const Center(
                  child: Text(
                    'First Container',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 150,
                height: 100,
                color: Colors.teal,
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Second Container',
                    style: TextStyle(color: Colors.white),
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