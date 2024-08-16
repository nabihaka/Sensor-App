import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'display_picture_screen.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> _cameras; // Add underscore for private field

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      // Fetch the list of available cameras
      _cameras = await availableCameras();
      // Check if there are available cameras
      if (_cameras.isNotEmpty) {
        // Initialize the camera controller with the first camera
        _cameraController = CameraController(
          _cameras[0], // Select the first available camera
          ResolutionPreset.high,
        );
        // Initialize the controller
        _initializeControllerFuture = _cameraController.initialize();
        // Await the future and set state after initialization
        await _initializeControllerFuture;
        setState(() {}); // Update the UI after initialization
      } else {
        // Handle the case where no cameras are found
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose(); // Dispose of the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        title: Text('Camera'),
      ),
      body: _cameraController.value.isInitialized
          ? CameraPreview(_cameraController) // Show camera preview
          : Center(child: CircularProgressIndicator()), // Show loading indicator
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        onPressed: () async {
          try {
            // Ensure that the camera is initialized
            await _initializeControllerFuture;
            // Capture an image
            final image = await _cameraController.takePicture();
            // Navigate to the display picture screen
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: image.path),
              ),
            );
          } catch (e) {
            print('Error capturing image: $e');
          }
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
