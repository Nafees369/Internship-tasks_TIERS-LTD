import 'package:flutter/material.dart';

void main() {
  runApp(const DailyInsightsApp());
}

// Main Application Widget
class DailyInsightsApp extends StatelessWidget {
  const DailyInsightsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Insights',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // A modern, clean font
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // More rounded for GenZ feel
          ),
          elevation: 6,
          shadowColor: Colors.deepPurple.withOpacity(0.3),
        ),
        buttonTheme: const ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.deepPurple; // Selected color
              }
              return Colors.grey.shade400; // Unselected color
            },
          ),
        ),
        // Input decoration for text fields (if any, though not used directly here)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.deepPurple.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Home Screen with both exercises
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Insights'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise 1: Stack Layout with Positioned Widget
            Text(
              'Daily Inspiration',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
            ),
            const SizedBox(height: 20),
            const StackLayoutExample(),
            const SizedBox(height: 40), // Spacing between exercises

            // Exercise 2: Radio Widgets
            Text(
              'Quick Survey',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
            ),
            const SizedBox(height: 20),
            const RadioWidgetsExample(),
          ],
        ),
      ),
    );
  }
}

// Exercise 1: Creating a Stack Layout using Positioned Widget
class StackLayoutExample extends StatelessWidget {
  const StackLayoutExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        // Card wraps the Stack to give it the GenZ rounded corners and shadow
        margin: EdgeInsets.zero,
        child: SizedBox(
          width: double.infinity,
          height: 200, // Fixed height for the quote card
          child: Stack(
            clipBehavior: Clip.antiAlias, // Ensures children respect card's rounded corners
            children: [
              // Background image or color for the quote card
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Match card border radius
                  child: Image.network(
                    'https://placehold.co/600x200/5E35B1/FFFFFF/PNG?text=Inspire+Your+Day', // Placeholder image
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.deepPurple.shade100,
                      child: Center(
                        child: Icon(Icons.lightbulb_outline, size: 60, color: Colors.deepPurple.shade400),
                      ),
                    ),
                  ),
                ),
              ),
              // Overlay with gradient for better text readability
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
              ),
              // Quote text - positioned at the bottom center
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '"The only way to do great work is to love what you do."',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      '- Steve Jobs',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              // Icon - positioned at the top left
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade700.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.auto_awesome, // A "sparkle" icon for Gemini
                    color: Colors.white,
                    size: 28,
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

// Exercise 2: Using Radio Widgets
class RadioWidgetsExample extends StatefulWidget {
  const RadioWidgetsExample({super.key});

  @override
  State<RadioWidgetsExample> createState() => _RadioWidgetsExampleState();
}

enum LearningStyle { visual, auditory, kinesthetic, readingWriting }

class _RadioWidgetsExampleState extends State<RadioWidgetsExample> {
  LearningStyle? _selectedLearningStyle; // Nullable to indicate no selection initially

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What\'s your primary learning style?',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade900,
                  ),
            ),
            const SizedBox(height: 16),
            // RadioListTile for a more integrated look
            _buildRadioListTile(
              title: 'Visual Learner',
              subtitle: 'Prefers diagrams, charts, and visual aids.',
              value: LearningStyle.visual,
            ),
            _buildRadioListTile(
              title: 'Auditory Learner',
              subtitle: 'Learns best through listening and discussions.',
              value: LearningStyle.auditory,
            ),
            _buildRadioListTile(
              title: 'Kinesthetic Learner',
              subtitle: 'Benefits from hands-on activities and practical experience.',
              value: LearningStyle.kinesthetic,
            ),
            _buildRadioListTile(
              title: 'Reading/Writing Learner',
              subtitle: 'Excels through reading texts and writing notes.',
              value: LearningStyle.readingWriting,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _selectedLearningStyle == null
                    ? null // Disable button if no option is selected
                    : () {
                        // Show selected option
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'You selected: ${_selectedLearningStyle.toString().split('.').last.toUpperCase()}'),
                            backgroundColor: Colors.deepPurple,
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Button background
                  foregroundColor: Colors.white, // Text color
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Submit Choice',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a consistent RadioListTile
  Widget _buildRadioListTile({
    required String title,
    required String subtitle,
    required LearningStyle value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 2, // Slightly less elevation for individual radio cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(
          color: _selectedLearningStyle == value ? Colors.deepPurple.shade300 : Colors.grey.shade200,
          width: _selectedLearningStyle == value ? 2.0 : 1.0,
        ),
      ),
      child: RadioListTile<LearningStyle>(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade900,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        value: value,
        groupValue: _selectedLearningStyle,
        onChanged: (LearningStyle? newValue) {
          setState(() {
            _selectedLearningStyle = newValue;
          });
        },
        activeColor: Colors.deepPurple, // Color when selected
        controlAffinity: ListTileControlAffinity.trailing, // Radio button on the right
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
