import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Firestore collection reference
  final CollectionReference exercises =
      FirebaseFirestore.instance.collection('exercises');

  // Shows a dialog for adding or editing an exercise
  Future<void> _showAddEditDialog([DocumentSnapshot? doc]) async {
    final TextEditingController controller = TextEditingController();
    String dialogTitle = "Add New Exercise";

    // If a document is passed, this is an edit operation
    if (doc != null) {
      controller.text = doc['title'];
      dialogTitle = "Edit Exercise";
    }

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(dialogTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter exercise name',
              prefixIcon: Icon(Icons.fitness_center),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.text.isNotEmpty) {
                  if (doc == null) {
                    // Add new exercise to Firestore
                    await exercises.add({'title': controller.text});
                  } else {
                    // Update existing exercise in Firestore using its ID
                    await exercises.doc(doc.id).update({'title': controller.text});
                  }
                  Navigator.of(context).pop(); // Close the dialog
                }
              },
              child: Text(doc == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  // Shows a confirmation dialog before deleting an exercise
  Future<void> _showDeleteConfirmationDialog(String exerciseTitle, String docId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Confirm Deletion', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text('Are you sure you want to delete "$exerciseTitle"?', style: const TextStyle(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Dismiss the dialog
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Delete exercise from Firestore using its ID
                await exercises.doc(docId).delete();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Workout Vibe'),
      ),
      // StreamBuilder listens for real-time updates from Firestore
      body: StreamBuilder<QuerySnapshot>(
        stream: exercises.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
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
            );
          }

          final List<DocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot doc = documents[index];
              final String exerciseTitle = doc['title'] as String;
              final String docId = doc.id;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          exerciseTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.deepPurple),
                            tooltip: 'Edit Exercise',
                            onPressed: () => _showAddEditDialog(doc),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            tooltip: 'Delete Exercise',
                            onPressed: () => _showDeleteConfirmationDialog(exerciseTitle, docId),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
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
