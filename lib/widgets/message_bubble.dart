import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageBubble extends StatelessWidget {
  final bool isUser;
  final String message;

  const MessageBubble({Key? key, required this.isUser, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          const CircleAvatar(
            child: Icon(Icons.smart_toy, color: Colors.white),
            backgroundColor: Colors.indigo,
          ),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.indigo : Colors.grey[300],
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isUser ? const Radius.circular(12) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(12),
              ),
            ),
            child: Text(
              message,
              style: GoogleFonts.poppins(
                color: isUser ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
        if (isUser) ...[
          const SizedBox(width: 8),
          const CircleAvatar(
            child: Icon(Icons.person, color: Colors.white),
            backgroundColor: Colors.indigo,
          ),
        ],
      ],
    );
  }
}
