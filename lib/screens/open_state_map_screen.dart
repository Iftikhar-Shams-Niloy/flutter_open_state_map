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
              initialCenter: LatLng(0, 0),
              initialZoom: 2,
              minZoom: 0,
              maxZoom: 100,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
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
