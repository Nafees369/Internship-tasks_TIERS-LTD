import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _dogImageUrl = '';
  String _errorMessage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchRandomDogImage();
  }

  Future<void> _fetchRandomDogImage() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));

      if (response.statusCode == 200) {
        // Exercise 2: Parsing JSON Data
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          setState(() {
            _dogImageUrl = data['message'];
          });
        } else {
          setState(() {
            _errorMessage = 'API returned an error: ${data['status']}';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load dog image. Status code: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Dog Image App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Exercise 1: Making a GET Request and displaying image
              _isLoading
                  ? const CircularProgressIndicator()
                  : _errorMessage.isNotEmpty
                      ? Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red))
                      : _dogImageUrl.isNotEmpty
                          ? Image.network(
                              _dogImageUrl,
                              height: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Failed to load image');
                              },
                            )
                          : const Text('Press the button to fetch a dog image.'),
              const SizedBox(height: 20),
              // Exercise 2: Displaying the image URL
              if (_dogImageUrl.isNotEmpty && !_isLoading && _errorMessage.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Image URL: $_dogImageUrl',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fetchRandomDogImage,
                child: const Text('Fetch New Dog Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}