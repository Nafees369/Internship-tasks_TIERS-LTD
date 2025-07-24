import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialog Exercises',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog Exercises'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _showAlertDialog(context),
                child: const Text('Exercise 1: Show Alert Dialog (Delete)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showSimpleDialog(context),
                child: const Text('Exercise 2: Show Simple Dialog (Options)'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showCustomDialog(context),
                child: const Text('Exercise 3: Show Custom Dialog'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showInputDialog(context),
                child: const Text('Exercise 4: Show Input Dialog'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showStatefulDialog(context),
                child: const Text('Exercise 5: Show Stateful Dialog (Counter)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Exercise 1: Create an AlertDialog for Deleting an item.
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item? This action cannot be undone.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Deletion cancelled.')),
                );
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform deletion logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item deleted successfully!')),
                );
              },
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

 
  void _showSimpleDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Choose an Option'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Option 1');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigating to screen for Option 1')),
                );
              },
              child: const Text('Option 1: View Details'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Option 2');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigating to screen for Option 2')),
                );
              },
              child: const Text('Option 2: Edit Item'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Option 3');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Navigating to screen for Option 3')),
                );
              },
              child: const Text('Option 3: Share Item'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null) {
        debugPrint('Selected: $value');
      }
    });
  }

  // Exercise 3: Create a Dialog with Custom content and a close button.
  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Custom Dialog Title',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  'This is a custom dialog with flexible content. You can put any widget here, '
                  'like images, forms, or complex layouts.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Exercise 4: Create an input dialog that allows the user to enter text and submit it.
  void _showInputDialog(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();

    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Your Name'),
          content: TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'e.g., Nafees Ahmad',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close without submitting
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop(_textEditingController.text); // Submit text
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You entered: "$value"')),
        );
        debugPrint('Input submitted: $value');
      } else if (value != null && value.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Input was empty.')),
        );
      }
    });
  }

  // Exercise 5: Create a stateful dialog that maintains a counter and updates its content when a button is pressed.
  void _showStatefulDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int counter = 0; // Initial value for the counter

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Stateful Counter Dialog'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Current Counter Value:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$counter',
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            counter--;
                          });
                        },
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            counter++;
                          });
                        },
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}