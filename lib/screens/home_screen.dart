import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NewChatBot - Home',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/LogoUp.jpeg',
                height: 100,
              ), // Asegúrate de agregar el logo en assets.
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre de la App: NewChatBot',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Carrera: Ingeniería en Desarrollo de Software', style: GoogleFonts.poppins()),
            Text('Materia: Programación para Móviles II', style: GoogleFonts.poppins()),
            Text('Grupo: 211234', style: GoogleFonts.poppins()),
            Text('Nombre: Cesar Josue Martinez Castillejos', style: GoogleFonts.poppins()),
            Text('Matrícula: 211234', style: GoogleFonts.poppins()),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final Uri url = Uri.parse('https://github.com/211234/NewChatBot.git');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                'Repositorio: https://github.com/211234/NewChatBot.git',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.indigo,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/chat');
                },
                child: Text(
                  'Ir al Chat',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
