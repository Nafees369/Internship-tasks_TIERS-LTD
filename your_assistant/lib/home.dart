import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:audioplayers/audioplayers.dart';
import 'register/signup.dart';
import 'profile/profile_page.dart';


class VoiceAssistantPage extends StatefulWidget {
  const VoiceAssistantPage({super.key});

  @override
  State<VoiceAssistantPage> createState() => _VoiceAssistantPageState();
}

/// The state class for the VoiceAssistantPage.
class _VoiceAssistantPageState extends State<VoiceAssistantPage>
    with TickerProviderStateMixin {
  // Speech-to-Text and Text-to-Speech instances
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  //  API key. 
  final String _apiKey = '';

  // State variables for UI and functionality
  bool _isListening = false;
  bool _isInitialized = false;
  bool _isProcessing = false;
  String _lastWords = '';
  String _displayText = 'Tap the microphone to start talking...';

  // Animation controllers
  late AnimationController _micScaleAnimationController;
  late Animation<double> _micScaleAnimation;
  late AnimationController _pulseAnimationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _initTts();
    _initStt();

    // Initialize animation controllers
    _micScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _micScaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _micScaleAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _pulseAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseAnimationController,
        curve: Curves.easeIn,
      ),
    );
  }

  /// Initializes the Text-to-Speech engine.
  Future<void> _initTts() async {
    await _flutterTts.setLanguage('en-US');
    await _flutterTts.setSpeechRate(0.5);
  }

  /// Requests microphone permissions from the user.
  Future<bool> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.request();
    if (!status.isGranted) {
      debugPrint('Microphone permission denied.');
      return false;
    }
    return true;
  }

  /// Initializes the Speech-to-Text engine.
  Future<void> _initStt() async {
    bool hasPermission = await _requestMicrophonePermission();
    if (!hasPermission) return;

    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening' && _isListening) {
          // Listening has stopped, so process the last recognized words.
          _isListening = false;
          _micScaleAnimationController.repeat(reverse: true);
          if (_lastWords.isNotEmpty) {
            _handleUserQuery(_lastWords);
          } else {
            setState(() {
              _displayText = 'Please try again...';
            });
          }
        } else if (status == 'listening') {
          _micScaleAnimationController.stop();
        }
      },
    );
    if (available) {
      _isInitialized = true;
    } else {
      debugPrint('Speech recognition is not available on this device.');
    }
  }

  /// Toggles the listening state.
  void _toggleListening() async {
    if (_isInitialized && !_isProcessing) {
      if (!_isListening) {
        // Check if the microphone is available before trying to listen
        if (!_speech.isAvailable) {
          setState(() {
            _displayText =
                'Microphone is busy. Please close other apps using the mic, like a screen recorder.';
          });
          _speak(
              'I am sorry, the microphone is currently in use by another application.');
          return;
        }

        setState(() {
          _isListening = true;
          _displayText = 'Listening...';
        });
        await _playMicSound('sounds/mic_on.mp3');
        await _speech.listen(
          onResult: (result) {
            setState(() {
              _lastWords = result.recognizedWords;
              _displayText = 'You said: "${result.recognizedWords}"';
            });
          },
          listenFor: const Duration(seconds: 5),
          onDevice: true,
        );
      } else {
        _speech.stop();
      }
    } else if (_isProcessing) {
      // Do nothing if already processing
      debugPrint('Already processing a request.');
    } else {
      debugPrint('Speech recognition is not available or initialized.');
      _speak('Speech recognition is not available. Please check your settings.');
    }
  }

  /// Handles the user's recognized query, checking for specific commands.
  Future<void> _handleUserQuery(String query) async {
    setState(() {
      _isProcessing = true;
      _displayText = 'Processing...';
    });
    _pulseAnimationController.repeat(reverse: true);

    final normalizedQuery = query.toLowerCase();

    // Check for specific commands
    if (normalizedQuery.contains('add a note')) {
      _speak('What would you like to note?');
    } else if (normalizedQuery.contains('thank you') ||
        normalizedQuery.contains('like the app')) {
      _showThankYouDialog(context);
      _speak('You\'re welcome! I\'m glad you like it.');
    } else if (normalizedQuery.contains('your name')) {
      _speak('My name is Gemini Assistant, and I am here to help you.');
    } else {
      await _getGeminiResponse(query);
    }

    _pulseAnimationController.stop();
    _pulseAnimationController.value = 0;

    // Reset the state for the next query. This is the crucial fix.
    setState(() {
      _isProcessing = false;
      _lastWords = ''; 
      _displayText = 'Tap to talk again...';
    });
  }

  /// Plays a sound from the assets folder.
  Future<void> _playMicSound(String assetPath) async {
    try {
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (e) {
      debugPrint('Error playing sound: $e');
    }
  }

  /// Gets a response from the Gemini API and updates the UI.
  Future<void> _getGeminiResponse(String prompt) async {
    if (_apiKey.isEmpty) {
      debugPrint('API key is not set.');
      _speak('My apologies, the API key is not configured.');
      return;
    }

    try {
      final url =
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-05-20:generateContent?key=$_apiKey';

      final concisePrompt = 'Give a concise and to-the-point answer: $prompt';

      final payload = {
        'contents': [
          {
            'parts': [
              {'text': concisePrompt}
            ]
          }
        ]
      };

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final geminiResponse =
            jsonResponse['candidates'][0]['content']['parts'][0]['text'];
        _speak(geminiResponse);
      } else {
        debugPrint('API Error: ${response.body}');
        _speak('I am sorry, I could not get a response from the server.');
      }
    } catch (e) {
      debugPrint('Error: $e');
      _speak('An unexpected error occurred.');
    }
  }

  /// Speaks the given text using TTS.
  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _micScaleAnimationController.dispose();
    _pulseAnimationController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// Shows a dialog for adding a note.
  Future<void> _showNoteDialog(BuildContext context) async {
    final TextEditingController noteController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2E084D),
          title: const Text('Add a Note', style: TextStyle(color: Colors.white)),
          content: TextField(
            controller: noteController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter your note here...",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            maxLines: 3,
          ),
          actions: <Widget>[
            TextButton(
              child:
                  const Text('Cancel', style: TextStyle(color: Colors.white70)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6A0C9D),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
              onPressed: () {
                debugPrint('Note saved: ${noteController.text}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Shows a "Thank you" dialog with a short delay.
  void _showThankYouDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return const AlertDialog(
          backgroundColor: Color(0xFF6A0C9D),
          content: Text(
            'Thank you for liking the app!',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        );
      },
    );
  }

  /// Builds the interactive buttons in the app bar.
  Widget _buildInteractiveButtons() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final hasUser = snapshot.hasData && snapshot.data != null;
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                colors: [Color(0xFFD431FF), Color(0xFF9F28FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white),
                  onPressed: () {},
                ),
                const SizedBox(width: 8),
                Container(
                  height: 30,
                  width: 1.5,
                  color: Colors.white.withOpacity(0.3),
                ),
                const SizedBox(width: 8),
                if (hasUser)
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                  )
                else
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text('Register'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
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
          title: const Text(''),
          actions: [
            _buildInteractiveButtons(),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Center(
                      child: Container(
                        width: 500,
                        height: 500,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 13, 3, 107)
                                  .withOpacity(0.55),
                              blurRadius: 80,
                              spreadRadius: 30,
                              offset: const Offset(0, 30),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: AnimatedBuilder(
                            animation: _pulseAnimationController,
                            builder: (context, child) {
                              final opacity = _isProcessing
                                  ? 0.5 + (_pulseAnimation.value * 0.5)
                                  : 1.0;
                              return Opacity(
                                opacity: opacity,
                                child: Image.asset(
                                  'assets/images/Voice-assistant-motion-effect-unscreen.gif',
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
              Positioned(
                top: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _displayText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                height: 70,
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 80),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () => _showNoteDialog(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
                      onPressed: () => _showThankYouDialog(context),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 45,
                child: GestureDetector(
                  onTap: _toggleListening,
                  child: ScaleTransition(
                    scale: _micScaleAnimation,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFFD431FF), Color(0xFF9F28FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _isListening
                                ? const Color(0xFFD431FF).withOpacity(0.5)
                                : Colors.transparent,
                            blurRadius: 20.0,
                            spreadRadius: 5.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
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