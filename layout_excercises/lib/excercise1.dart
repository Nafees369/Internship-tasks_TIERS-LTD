import 'package:flutter/material.dart';

class Exercise1 extends StatelessWidget {
  const Exercise1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Basic Layout'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            color: Colors.lightBlue[100],
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Use min size to wrap content
            children: <Widget>[
              Container(
                height: 80,
                width: 80,
                color: Colors.red,
                margin: const EdgeInsets.all(8),
                child: const Center(child: Text('1')),
              ),
              Container(
                height: 80,
                width: 80,
                color: Colors.green,
                margin: const EdgeInsets.all(8),
                child: const Center(child: Text('2')),
              ),
              Container(
                height: 80,
                width: 80,
                color: Colors.purple,
                margin: const EdgeInsets.all(8),
                child: const Center(child: Text('3')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}