import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(50),
              color: Colors.white10,
            ),
            child: ListView(
              padding: const EdgeInsets.all(18.0),
              children: const [
               Text(
              'Music Player',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Version: 0.1',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'Developer:Fathima Sifna ',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'Email: sifnafathima09@gmail.com',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Description',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              'Music Player is a feature-rich app that allows you to enjoy your favorite music on the go. With a sleek and intuitive interface, it provides seamless navigation and a great listening experience.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: 16),
            Text(
              'Features',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 8),
            Text(
              '• Play music from your device',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '• Create playlists and manage your library',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '• Discover new music with personalized recommendations',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              '• Customize the app with themes and settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
