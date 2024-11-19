import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import '../utils/voice_helper.dart';
import '../widgets/message_bubble.dart';
import 'chat_history_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, String>> _messages = [];
  final VoiceHelper _voiceHelper = VoiceHelper();
  bool _isBotTyping = false;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _voiceHelper.initTTS();
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({'user': message});
      _isBotTyping = true;
    });

    try {
      final gemini = Gemini.instance;
      final response = await gemini.text(message);
      final botResponse = response?.output ?? 'Sin respuesta';

      setState(() {
        _isBotTyping = false;
        _messages.add({'bot': botResponse});
        _isSpeaking = true;  // Se establece en true cuando el bot empieza a hablar
      });

      await _voiceHelper.speak(botResponse);

      setState(() {
        _isSpeaking = false;  // Se establece en false una vez que el bot termina de hablar
      });

      print("Speaking: $_isSpeaking");  // Verificación de estado

    } catch (e) {
      setState(() {
        _isBotTyping = false;
        _isSpeaking = false;
        _messages.add({'bot': 'Error al procesar la solicitud.'});
      });
      print(e);
    }
  }

  void _viewHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatHistoryScreen(messages: _messages),
      ),
    );
  }

  Future<void> _stopSpeaking() async {
    await _voiceHelper.stop();
    setState(() {
      _isSpeaking = false;  // Detiene el TTS y oculta el botón "stop"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat - Practica Inglés',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length + (_isBotTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isBotTyping && index == _messages.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final message = _messages[index];
                return MessageBubble(
                  isUser: message.containsKey('user'),
                  message: message.values.first,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.grey,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.indigo),
                  onPressed: () async {
                    String spokenText = await _voiceHelper.listen();
                    _sendMessage(spokenText);
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Escribe aquí...',
                      labelStyle: GoogleFonts.poppins(),
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: _sendMessage,
                  ),
                ),
                if (_isSpeaking)
                  IconButton(
                    icon: const Icon(Icons.stop, color: Colors.red),
                    onPressed: _stopSpeaking,
                  ),
                IconButton(
                  icon: const Icon(Icons.history, color: Colors.indigo),
                  onPressed: _viewHistory,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
