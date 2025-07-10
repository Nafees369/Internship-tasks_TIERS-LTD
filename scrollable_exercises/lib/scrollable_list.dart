import 'package:flutter/material.dart';
import 'dart:math'; // For generating random colors

class Exercise1ScrollableList extends StatelessWidget {
  const Exercise1ScrollableList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 1: Scrollable List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: 20, // Number of containers in the list
        itemBuilder: (BuildContext context, int index) {
          // Generate a random color for each container
          final Color randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

          return Container(
            height: 100, // Height of each container
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Container ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}