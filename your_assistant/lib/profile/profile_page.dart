import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:your_assistant/register/login.dart';
import 'package:your_assistant/home.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reauthEmailController = TextEditingController();
  bool _isLoading = false;
   File? _pickedImage;

  @override
  void dispose() {
    _passwordController.dispose();
    _reauthEmailController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      // Navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> _handleDeleteAccount() async {
    // Show a confirmation and re-authentication dialog
    final credentials = await _showReauthDialog();
    if (credentials == null) {
      return; // User canceled re-authentication
    }

    setState(() => _isLoading = true);
    try {
      await user!.reauthenticateWithCredential(credentials);
      await user!.delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully.')),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const VoiceAssistantPage()),
          (Route<dynamic> route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'requires-recent-login') {
        errorMessage = 'This operation is sensitive and requires a recent login. Please log out and log back in.';
      } else {
        errorMessage = 'Error deleting account: ${e.message}';
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<AuthCredential?> _showReauthDialog() async {
    return showDialog<AuthCredential?>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text('Re-authenticate to delete account'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('For your security, please re-enter your email and password to confirm this action.'),
                const SizedBox(height: 16),
                TextField(
                  controller: _reauthEmailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  final email = _reauthEmailController.text.trim();
                  final password = _passwordController.text.trim();
                  if (email.isNotEmpty && password.isNotEmpty) {
                    final credentials = EmailAuthProvider.credential(email: email, password: password);
                    Navigator.of(context).pop(credentials);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter both email and password.')),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Updated function to pick an image and store it locally
  Future<void> _pickAndUploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Update the state with the new local image file
    setState(() {
      _pickedImage = File(image.path);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image picked successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? profileImage;
    // Check if a local image has been picked first
    if (_pickedImage != null) {
      profileImage = FileImage(_pickedImage!);
    } else if (user?.photoURL != null) {
      // Fallback to the Firebase photoURL if no local image is picked
      profileImage = NetworkImage(user!.photoURL!);
    }
    return Scaffold(
      backgroundColor: const Color(0xFF2E084D),
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    backgroundImage: user?.photoURL != null
                        ? NetworkImage(user!.photoURL!)
                        : null,
                    child: user?.photoURL == null
                        ? const Icon(Icons.person, size: 80, color: Colors.white70)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white, size: 30),
                      onPressed: _pickAndUploadImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                user?.email ?? 'User',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Column(
                      children: [
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          onPressed: _handleLogout,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete Account'),
                          onPressed: _handleDeleteAccount,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            backgroundColor: Colors.red[800],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}