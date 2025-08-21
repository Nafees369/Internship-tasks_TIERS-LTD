
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:your_assistant/register/login.dart';
import 'package:your_assistant/register/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async'; // Added for Timer

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email address.';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Please enter a valid email address.';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password.';
    if (value.length < 8) return 'Password must be at least 8 characters long.';
    if (!value.contains(RegExp(r'[A-Z]'))) return 'Password must contain at least one uppercase letter.';
    if (!value.contains(RegExp(r'[a-z]'))) return 'Password must contain at least one lowercase letter.';
    if (!value.contains(RegExp(r'[0-9]'))) return 'Password must contain at least one number.';
    if (!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) return 'Password must contain at least one special character.';
    return null;
  }

  Future<void> _handleEmailSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Send email verification as soon as the user is created
      await userCredential.user!.sendEmailVerification();

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'created_at': Timestamp.now(),
      });

      if (mounted) {
        // Navigate to the verification screen after a successful sign-up
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showError('The account already exists for that email.');
      } else {
        _showError('An unexpected error occurred: ${e.message}');
      }
    } catch (e) {
      debugPrint('Sign up error: $e');
      _showError('An unexpected error occurred. Please try again.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Google Sign-In (works for web and mobile)
  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);

    try {
      if (kIsWeb) {
        // On web use the popup flow which doesn't require google_sign_in package
        final provider = GoogleAuthProvider();
        final result = await FirebaseAuth.instance.signInWithPopup(provider);

        // Save to Firestore for new users
        if (result.user != null && result.additionalUserInfo != null && result.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set({
            'name': result.user!.displayName ?? 'Unnamed User',
            'email': result.user!.email ?? 'No email',
            'created_at': Timestamp.now(),
          });
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
          );
        }
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        if (googleUser == null) {
          // user cancelled
          if (mounted) setState(() => _isLoading = false);
          return;
        }

        // Use dynamic to avoid analyzer errors if package version differs
        final dynamic googleAuth = await googleUser.authentication;

        // Different google_sign_in versions expose tokens with slightly different names.
        // Try both accessToken and access_token.
        final String? idToken = googleAuth.idToken as String?;
        final String? accessToken = (googleAuth.accessToken ?? googleAuth.access_token) as String?;

        if (idToken == null && accessToken == null) {
          throw Exception('Failed to obtain Google auth tokens.');
        }

        final credential = GoogleAuthProvider.credential(
          idToken: idToken,
          accessToken: accessToken,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null && userCredential.additionalUserInfo != null && userCredential.additionalUserInfo!.isNewUser) {
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'name': userCredential.user!.displayName ?? 'Unnamed User',
            'email': userCredential.user!.email ?? 'No email',
            'created_at': Timestamp.now(),
          });
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      _showError('Failed to sign in with Google: ${e.message}');
      debugPrint('Google Sign-In error: $e');
    } catch (e) {
      _showError('An unexpected error occurred. Please try again.');
      debugPrint('Google Sign-In error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF2E084D),
            Color(0xFF6A0C9D),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Sign Up', style: TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton(
                          onPressed: _handleEmailSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD431FF),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
                        ),
                  const SizedBox(height: 18),
                  const Text('Or sign up with', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _SocialButton(
                        icon: Icons.g_mobiledata,
                        onPressed: _signInWithGoogle,
                        color: Colors.green[700],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Already have an account? Log In',
                      style: TextStyle(color: Colors.white70, decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  const _SocialButton({
    required this.icon,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.22),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        iconSize: 40,
        onPressed: onPressed,
      ),
    );
  }
}



