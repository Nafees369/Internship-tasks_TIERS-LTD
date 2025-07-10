import 'package:flutter/material.dart';

class Exercise2GoogleUI extends StatelessWidget {
  const Exercise2GoogleUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark background for the Google UI
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Gmail',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Images',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.apps, color: Colors.white70),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    child: Text('D', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),

            // Google Logo
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google_logo.png', // You'll need to add a Google logo image
                    height: 92,
                    color: Colors.white, // Invert color for dark theme if original is black
                  ),
                  const SizedBox(height: 25),

                  // Search Bar
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5, // Adjust width as needed
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey[700]!),
                    ),
                    child: const TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search Google or type a URL',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.mic, color: Colors.grey),
                            SizedBox(width: 8),
                            Icon(Icons.camera_alt, color: Colors.grey),
                          ],
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('Google Search', style: TextStyle(fontSize: 13)),
                      ),
                      const SizedBox(width: 15),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text('I\'m Feeling Lucky', style: TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Google offered in: اردو پښتو سنڌي',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13),
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              color: Colors.grey[850],
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Pakistan',
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('About', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Advertising', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Business', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('How Search works', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text('Privacy', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Terms', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Settings', style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
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