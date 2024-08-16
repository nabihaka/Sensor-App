import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async'; // Import ini diperlukan untuk StreamSubscription

class GyroscopePage extends StatefulWidget {
  const GyroscopePage({super.key});

  @override
  _GyroscopePageState createState() => _GyroscopePageState();
}

class _GyroscopePageState extends State<GyroscopePage> {
  GyroscopeEvent? _gyroscopeEvent;
  late StreamSubscription<GyroscopeEvent> _gyroscopeSubscription;

  @override
  void initState() {
    super.initState();
    // Listen to gyroscope events
    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted) {
        setState(() {
          _gyroscopeEvent = event;
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel subscription to prevent memory leaks
    _gyroscopeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.yellow[700], // Warna kuning untuk AppBar
        foregroundColor: Colors.black, // Warna teks hitam untuk kontras
        title: Text('Gyroscope'),
      ),
      body: Container(
        padding: EdgeInsets.all(16), // Tambahkan padding di sekitar konten
        color: Colors.yellow[50], // Latar belakang kuning muda
        child: _gyroscopeEvent == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSensorCard("X", _gyroscopeEvent!.x),
                  _buildSensorCard("Y", _gyroscopeEvent!.y),
                  _buildSensorCard("Z", _gyroscopeEvent!.z),
                ],
              ),
      ),
    );
  }

  Widget _buildSensorCard(String label, double value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$label Axis",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[900], // Warna teks kuning gelap
              ),
            ),
            Text(
              value.toStringAsFixed(2), // Format nilai dengan dua desimal
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow[900], // Warna teks kuning gelap
              ),
            ),
          ],
        ),
      ),
    );
  }
}
