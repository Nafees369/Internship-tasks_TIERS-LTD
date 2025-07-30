import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenZ Exercise Tracker',
      theme: ThemeData(
        // Define a vibrant and modern color scheme
        primarySwatch: Colors.deepPurple,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.pinkAccent, // A vibrant accent color
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5), // Light grey background
        fontFamily: 'Inter', // A modern, clean font (ensure it's in pubspec.yaml if not default)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners for cards
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.pinkAccent,
          foregroundColor: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)), // Square-ish FAB
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded buttons
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepPurple,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.pinkAccent, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintStyle: TextStyle(color: Colors.grey.shade500),
        ),
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
  List<String> _exercises = []; // List to store exercise names
  late SharedPreferences _prefs; // SharedPreferences instance

  @override
  void initState() {
    super.initState();
    _initSharedPreferences(); // Initialize and load exercises when the widget starts
  }

  // Initializes SharedPreferences and loads exercises
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadExercises();
  }

  // Loads exercises from SharedPreferences
  void _loadExercises() {
    // Try to get the stored JSON string of exercises
    final String? exercisesJson = _prefs.getString('exercises');
    if (exercisesJson != null) {
      // Decode the JSON string back into a List<String>
      setState(() {
        _exercises = List<String>.from(json.decode(exercisesJson));
      });
    }
  }

  // Saves the current list of exercises to SharedPreferences
  void _saveExercises() {
    // Encode the List<String> into a JSON string
    _prefs.setString('exercises', json.encode(_exercises));
  }

  // Shows a dialog for adding or editing an exercise
  Future<void> _showAddEditDialog({String? initialValue, int? index}) async {
    final TextEditingController controller = TextEditingController(text: initialValue);
    final bool isEditing = index != null;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(isEditing ? 'Edit Exercise' : 'Add New Exercise', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter exercise name',
              prefixIcon: Icon(Icons.fitness_center),
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                if (isEditing) {
                  _editExercise(index, value);
                } else {
                  _addExercise(value);
                }
                Navigator.of(context).pop(); // Close dialog on submit
              }
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (isEditing) {
                    _editExercise(index, controller.text);
                  } else {
                    _addExercise(controller.text);
                  }
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }

  // Adds a new exercise to the list
  void _addExercise(String exerciseName) {
    setState(() {
      _exercises.add(exerciseName);
      _saveExercises(); // Save changes to SharedPreferences
    });
    _showSnackBar('Exercise added: $exerciseName');
  }

  // Edits an existing exercise in the list
  void _editExercise(int? index, String newName) {
    if (index != null && index >= 0 && index < _exercises.length) {
      setState(() {
        _exercises[index] = newName;
        _saveExercises(); // Save changes to SharedPreferences
      });
      _showSnackBar('Exercise updated: $newName');
    }
  }

  // Shows a confirmation dialog before deleting an exercise
  Future<void> _showDeleteConfirmationDialog(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirm Deletion', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "${_exercises[index]}"?', style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteExercise(index);
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), // Red button for delete
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // Deletes an exercise from the list
  void _deleteExercise(int index) {
    setState(() {
      final String deletedExercise = _exercises.removeAt(index);
      _saveExercises(); // Save changes to SharedPreferences
      _showSnackBar('Exercise deleted: $deletedExercise');
    });
  }

  // Helper to show a snackbar message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Workout Vibe'),
      ),
      body: _exercises.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 20),
                  Text(
                    'No exercises yet! Let\'s add some 🔥',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                final exercise = _exercises[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            exercise,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.deepPurple),
                              tooltip: 'Edit Exercise',
                              onPressed: () => _showAddEditDialog(initialValue: exercise, index: index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              tooltip: 'Delete Exercise',
                              onPressed: () => _showDeleteConfirmationDialog(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditDialog(),
        label: const Text('Add Exercise'),
        icon: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
