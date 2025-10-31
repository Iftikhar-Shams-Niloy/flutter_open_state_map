import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'open_state_map_screen.dart';

class MapSnapshotScreen extends StatefulWidget {
  const MapSnapshotScreen({super.key});

  @override
  State<MapSnapshotScreen> createState() => _MapSnapshotScreenState();
}

class _MapSnapshotScreenState extends State<MapSnapshotScreen> {
  ui.Image? _mapSnapshot;

  Future<void> _navigateToMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OpenStateMapScreen()),
    );

    if (result != null && result is ui.Image) {
      setState(() {
        _mapSnapshot = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Snapshot')),
      body: Column(
        children: [
          // Container from start to middle section
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade300, Colors.blue.shade100],
                ),
              ),
              child: _mapSnapshot == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.map, size: 100, color: Colors.white),
                          const SizedBox(height: 20),
                          const Text(
                            'Map Preview',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No snapshot yet',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomPaint(
                      painter: ImagePainter(_mapSnapshot!),
                      child: Container(),
                    ),
            ),
          ),
          // Bottom section with button
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: SizedBox(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  onPressed: _navigateToMap,
                  backgroundColor: Colors.blue,
                  elevation: 8,
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter to draw the ui.Image
class ImagePainter extends CustomPainter {
  final ui.Image image;

  ImagePainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the aspect ratio and fit the image
    final imageAspectRatio = image.width / image.height;
    final containerAspectRatio = size.width / size.height;

    double drawWidth;
    double drawHeight;
    double offsetX = 0;
    double offsetY = 0;

    if (imageAspectRatio > containerAspectRatio) {
      // Image is wider than container
      drawWidth = size.width;
      drawHeight = size.width / imageAspectRatio;
      offsetY = (size.height - drawHeight) / 2;
    } else {
      // Image is taller than container
      drawHeight = size.height;
      drawWidth = size.height * imageAspectRatio;
      offsetX = (size.width - drawWidth) / 2;
    }

    final srcRect = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );
    final dstRect = Rect.fromLTWH(offsetX, offsetY, drawWidth, drawHeight);

    canvas.drawImageRect(image, srcRect, dstRect, Paint());
  }

  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    return oldDelegate.image != image;
  }
}
