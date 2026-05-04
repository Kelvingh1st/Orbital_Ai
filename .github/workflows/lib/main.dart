import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // The AI Brain

void main() {
  runApp(const OrbitalApp());
  }

  class OrbitalApp extends StatelessWidget {
    const OrbitalApp({super.key});

      @override
        Widget build(BuildContext context) {
            return MaterialApp(
                  debugShowCheckedModeBanner: false,
                        theme: ThemeData.dark(),
                              home: const OrbitalHome(),
                                  );
                                    }
                                    }

                                    class OrbitalHome extends StatefulWidget {
                                      const OrbitalHome({super.key});

                                        @override
                                          State<OrbitalHome> createState() => _OrbitalHomeState();
                                          }

                                          class _OrbitalHomeState extends State<OrbitalHome> {
                                            final stt.SpeechToText _speech = stt.SpeechToText();
                                              final FlutterTts _tts = FlutterTts();
                                                
                                                  // Replace My app key' with your actual Gemini API Key later
                                                    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: 'AIzaSyB0naSjcFO1SmVykNOdm6GwvS8eCIvqkOM');
                                                      
                                                        bool _isListening = false;
                                                          String _text = "Wait for Orbital...";

                                                            @override
                                                              void initState() {
                                                                  super.initState();
                                                                      _initVoice();
                                                                        }

                                                                          void _initVoice() async {
                                                                              await _speech.initialize();
                                                                                  setState(() {
                                                                                        _text = "Orbital is online. Tap the mic!";
                                                                                            });
                                                                                              }

                                                                                                void _listen() async {
                                                                                                    if (!_isListening) {
                                                                                                          bool available = await _speech.listen(onResult: (val) {
                                                                                                                  setState(() => _text = val.recognizedWords);
                                                                                                                        });
                                                                                                                              if (available) {
                                                                                                                                      setState(() => _isListening = true);
                                                                                                                                            }
                                                                                                                                                } else {
                                                                                                                                                      setState(() => _isListening = false);
                                                                                                                                                            _speech.stop();
                                                                                                                                                                  _askGemini(_text); // Send what you said to the AI
                                                                                                                                                                      }
                                                                                                                                                                        }

                                                                                                                                                                          // The function that talks to Gemini
                                                                                                                                                                            void _askGemini(String prompt) async {
                                                                                                                                                                                setState(() => _text = "Orbital is thinking...");
                                                                                                                                                                                    final content = [Content.text(prompt)];
                                                                                                                                                                                        final response = await model.generateContent(content);
                                                                                                                                                                                            
                                                                                                                                                                                                setState(() {
                                                                                                                                                                                                      _text = response.text ?? "I couldn't process that.";
                                                                                                                                                                                                          });
                                                                                                                                                                                                              
                                                                                                                                                                                                                  _speak(_text); // Make Orbital say the answer out loud
                                                                                                                                                                                                                    }

                                                                                                                                                                                                                      void _speak(String message) async {
                                                                                                                                                                                                                          await _tts.speak(message);
                                                                                                                                                                                                                            }

                                                                                                                                                                                                                              @override
                                                                                                                                                                                                                                Widget build(BuildContext context) {
                                                                                                                                                                                                                                    return Scaffold(
                                                                                                                                                                                                                                          appBar: AppBar(title: const Text('Orbital AI')),
                                                                                                                                                                                                                                                body: Padding(
                                                                                                                                                                                                                                                        padding: const EdgeInsets.all(20.0),
                                                                                                                                                                                                                                                                child: Center(child: Text(_text, style: const TextStyle(fontSize: 18))),
                                                                                                                                                                                                                                                                      ),
                                                                                                                                                                                                                                                                            floatingActionButton: FloatingActionButton(
                                                                                                                                                                                                                                                                                    onPressed: _listen,
                                                                                                                                                                                                                                                                                            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                                                                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                                                                                      );
                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                        }
                                                                                                                                                                                                                                                                                                        