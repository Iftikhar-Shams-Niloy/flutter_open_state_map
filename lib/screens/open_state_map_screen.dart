import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';

class OpenStateMapScreen extends StatefulWidget {
  const OpenStateMapScreen({super.key});

  @override
  State<OpenStateMapScreen> createState() => _OpenStateMapScreen();
}

class _OpenStateMapScreen extends State<OpenStateMapScreen> {
  final MapController _myMapController = MapController();
  final GlobalKey _mapKey = GlobalKey();

  Future<void> _captureMapSnapshot() async {
    try {
      RenderRepaintBoundary boundary =
          _mapKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // Navigate back with the image
      Navigator.pop(context, image);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error capturing snapshot: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Open State Map")),
      body: Stack(
        children: [
          RepaintBoundary(
            key: _mapKey,
            child: FlutterMap(
              mapController: _myMapController,
              options: MapOptions(
                initialCenter: const LatLng(
                  40.7128,
                  -74.0060,
                ), // New York City as default
                initialZoom: 13.0,
                minZoom: 3.0,
                maxZoom: 18.0,
                onTap: (tapPosition, point) {},
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.flutter_open_state _map',
                ),
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: DefaultLocationMarker(
                      child: Icon(Icons.location_pin, color: Colors.red),
                    ),
                    markerSize: Size(32, 32),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              ],
            ),
          ),
          // Capture button at the bottom
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton.extended(
                onPressed: _captureMapSnapshot,
                backgroundColor: Colors.blue,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Capture Map'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
