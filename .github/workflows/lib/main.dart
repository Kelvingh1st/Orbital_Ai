import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

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
                                                bool _isListening = false;
                                                  String _text = "Tap the mic and say something!";

                                                    @override
                                                      void initState() {
                                                          super.initState();
                                                              _initVoice();
                                                                }

                                                                  void _initVoice() async {
                                                                      await _speech.initialize();
                                                                          setState(() {});
                                                                            }

                                                                              void _listen() async {
                                                                                  if (!_isListening) {
                                                                                        bool available = await _speech.listen(onResult: (val) {
                                                                                                setState(() {
                                                                                                          _text = val.recognizedWords;
                                                                                                                  });
                                                                                                                        });
                                                                                                                              if (available) {
                                                                                                                                      setState(() => _isListening = true);
                                                                                                                                            }
                                                                                                                                                } else {
                                                                                                                                                      setState(() => _isListening = false);
                                                                                                                                                            _speech.stop();
                                                                                                                                                                  _speak("I heard you say: $_text");
                                                                                                                                                                      }
                                                                                                                                                                        }

                                                                                                                                                                          void _speak(String message) async {
                                                                                                                                                                              await _tts.speak(message);
                                                                                                                                                                                }

                                                                                                                                                                                  @override
                                                                                                                                                                                    Widget build(BuildContext context) {
                                                                                                                                                                                        return Scaffold(
                                                                                                                                                                                              appBar: AppBar(title: const Text('Orbital AI')),
                                                                                                                                                                                                    body: Center(child: Text(_text, style: const TextStyle(fontSize: 20))),
                                                                                                                                                                                                          floatingActionButton: FloatingActionButton(
                                                                                                                                                                                                                  onPressed: _listen,
                                                                                                                                                                                                                          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                    );
                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                      