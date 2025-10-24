import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Open State Map")),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _myMapController,
            options: MapOptions(
              initialCenter: const LatLng(
                40.7128,
                -74.0060,
              ), // New York City as default
              initialZoom: 13.0,
              minZoom: 3.0,
              maxZoom: 18.0,
              onTap: (tapPosition, point) {
              },
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
        ],
      ),
    );
  }
}
