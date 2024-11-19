import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceHelper {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<void> initTTS() async {
    await _tts.setLanguage('en-US');
    await _tts.setPitch(1.0);
  }

  Future<String> listen() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen();
      return _speech.lastRecognizedWords;
    }
    return 'Error recognizing speech.';
  }

  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  Future<void> stop() async {
    await _tts.stop();  // Detiene la reproducción de voz
  }

  Future<String> getBotResponse(String userInput) async {
    // Aquí conectas con la IA de Gemini
    return "Response based on: $userInput"; // Simulación de respuesta
  }
}
