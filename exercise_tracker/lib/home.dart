
import 'package:flutter/material.dart';
import 'helper.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _exercises = []; // List to store exercise names
  final DatabaseHelper _dbHelper = DatabaseHelper.instance; // Database helper instance

  @override
  void initState() {
    super.initState();
    _loadExercises(); // Load exercises when the widget starts
  }

  // Loads exercises from the SQLite database
  Future<void> _loadExercises() async {
    final List<String> loadedExercises = await _dbHelper.getExercises();
    setState(() {
      _exercises = loadedExercises;
    });
  }

  // Shows a dialog for adding or editing an exercise
  Future<void> _showAddEditDialog({String? initialValue, int? index}) async {
    final TextEditingController controller = TextEditingController(text: initialValue);
    final bool isEditing = initialValue != null; // Determine editing based on initialValue

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
            onSubmitted: (value) async {
              if (value.isNotEmpty) {
                if (isEditing) {
                  // For editing, we need the original title to find the ID
                  // This assumes exercise titles are unique. For production, use actual IDs.
                  await _editExercise(initialValue!, value);
                } else {
                  await _addExercise(value);
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
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  if (isEditing) {
                    // For editing, we need the original title to find the ID
                    await _editExercise(initialValue!, controller.text);
                  } else {
                    await _addExercise(controller.text);
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

  // Adds a new exercise to the database and updates the list
  Future<void> _addExercise(String exerciseName) async {
    await _dbHelper.insertExercise(exerciseName);
    await _loadExercises(); // Reload exercises from DB
    _showSnackBar('Exercise added: $exerciseName');
  }

  // Edits an existing exercise in the database and updates the list
  Future<void> _editExercise(String oldName, String newName) async {
    // In a real app, you would pass the ID of the exercise to edit.
    // For simplicity, we'll find the ID by the old name. This assumes unique names.
    final List<Map<String, dynamic>> exercisesFromDb = await _dbHelper.database.then((db) => db.query(DatabaseHelper.tableName, where: '${DatabaseHelper.columnTitle} = ?', whereArgs: [oldName]));
    if (exercisesFromDb.isNotEmpty) {
      int id = exercisesFromDb.first[DatabaseHelper.columnId];
      await _dbHelper.updateExercise(id, newName);
      await _loadExercises(); // Reload exercises from DB
      _showSnackBar('Exercise updated: $newName');
    } else {
      _showSnackBar('Error: Exercise not found to edit.');
    }
  }

  // Shows a confirmation dialog before deleting an exercise
  Future<void> _showDeleteConfirmationDialog(String exerciseName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirm Deletion', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "$exerciseName"?', style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _deleteExercise(exerciseName);
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

  // Deletes an exercise from the database and updates the list
  Future<void> _deleteExercise(String exerciseName) async {
    await _dbHelper.deleteExercise(exerciseName);
    await _loadExercises(); // Reload exercises from DB
    _showSnackBar('Exercise deleted: $exerciseName');
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
                              onPressed: () => _showAddEditDialog(initialValue: exercise),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                              tooltip: 'Delete Exercise',
                              onPressed: () => _showDeleteConfirmationDialog(exercise),
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
