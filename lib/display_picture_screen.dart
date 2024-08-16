import 'package:flutter/material.dart';
import 'dart:io'; // Import dart:io for file operations

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath; // Path to the captured image

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text(
          'Picture',
        ),
      ),
      body: Center(
        child: Image.file(File(imagePath)), // Display the image file
      ),
    );
  }
}
