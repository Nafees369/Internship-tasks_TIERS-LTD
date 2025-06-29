import 'package:flutter/material.dart';

class Exercise2Alignment extends StatelessWidget {
  const Exercise2Alignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2: Alignment'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Row with MainAxisAlignment.spaceAround',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              height: 120,
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    color: Colors.orange,
                    child: const Center(child: Text('A')),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    color: Colors.teal,
                    child: const Center(child: Text('B')),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    color: Colors.brown,
                    child: const Center(child: Text('C')),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Column with CrossAxisAlignment.center',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // To center vertically
                crossAxisAlignment: CrossAxisAlignment.center, // To center horizontally
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 60,
                    color: Colors.red,
                    margin: const EdgeInsets.all(5),
                    child: const Center(child: Text('1')),
                  ),
                  Container(
                    width: 150,
                    height: 60,
                    color: Colors.green,
                    margin: const EdgeInsets.all(5),
                    child: const Center(child: Text('2')),
                  ),
                  Container(
                    width: 80,
                    height: 60,
                    color: Colors.blue,
                    margin: const EdgeInsets.all(5),
                    child: const Center(child: Text('3')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}