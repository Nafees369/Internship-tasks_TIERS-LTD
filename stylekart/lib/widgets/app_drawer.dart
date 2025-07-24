
import 'package:flutter/material.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // Drawer Header with a modern gradient background
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.8),
                  child: const Icon(Icons.shopping_bag, size: 30, color: Colors.deepPurple),
                ),
                const SizedBox(height: 10),
                const Text(
                  'StyleKart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Your Style, Your Way',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          // Navigation Links
          _buildDrawerItem(context, Icons.home, 'Home', '/home'),
          const Divider(), // Separator
          _buildDrawerItem(context, Icons.male, 'Men', '/men'),
          _buildDrawerItem(context, Icons.female, 'Women', '/women'),
          _buildDrawerItem(context, Icons.child_care, 'Kids', '/kids'),
          _buildDrawerItem(context, Icons.roller_skating, 'Shoes', '/shoes'),
          _buildDrawerItem(context, Icons.watch, 'Accessories', '/accessories'),
          _buildDrawerItem(context, Icons.ac_unit, 'Winter Collection', '/winter_collection'),
          const Divider(),
          _buildDrawerItem(context, Icons.shopping_cart, 'Cart', '/cart'),
          _buildDrawerItem(context, Icons.person, 'Profile', '/profile'),
          _buildDrawerItem(context, Icons.logout, 'Logout', '/logout'),
        ],
      ),
    );
  }

  // Helper method to build consistent drawer list tiles
  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        // Close the drawer first
        Navigator.pop(context);
        // Navigate to the desired route, replacing the current one
        Navigator.pushReplacementNamed(context, routeName);
      },
    );
  }
  
}
