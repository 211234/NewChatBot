import 'package:flutter/material.dart';
import '../widgets/message_bubble.dart';

class ChatHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> messages;

  const ChatHistoryScreen({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Conversación'),
        backgroundColor: Colors.indigo,
      ),
      body: messages.isEmpty
          ? const Center(
        child: Text(
          'No hay mensajes en el historial.',
          style: TextStyle(fontSize: 16),
        ),
      )
          : ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return MessageBubble(
            isUser: message.containsKey('user'),
            message: message.values.first,
          );
        },
      ),
    );
  }
}
