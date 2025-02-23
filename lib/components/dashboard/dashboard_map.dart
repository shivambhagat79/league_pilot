import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:hunger_games/components/common/heading_cut_card.dart';
import 'package:latlong2/latlong.dart';
// import 'package:url_launcher/url_launcher.dart';

class DashboardMap extends StatefulWidget {
  const DashboardMap({super.key});

  @override
  State<DashboardMap> createState() => _DashboardMapState();
}

class _DashboardMapState extends State<DashboardMap> {
  @override
  Widget build(BuildContext context) {
    return HeadingCutCard(
      heading: "Campus Map",
      tail: Container(
        padding: EdgeInsets.only(top: 6),
        alignment: Alignment.center,
        width: double.maxFinite,
        child: Text(
          "Find Venues",
          style: TextStyle(
            fontWeight: FontWeight.w100,
            fontFamily: "Overcame",
            fontSize: 18,
            color: Colors.black.withAlpha(150),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(30.968826233399174, 76.47331329133168),
            initialZoom: 14.8,
            minZoom: 14,
            maxZoom: 16.8,
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            MarkerLayer(markers: [
              customMarker(
                "Football Ground",
                LatLng(30.963086043184678, 76.47551895868489),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

Marker customMarker(String label, LatLng point) {
  return Marker(
    width: 100.0,
    height: 80.0,
    point: point, // Example location
    child: Column(
      // alignment: Alignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade100),
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            onTap: () => () {},
            child: Text(
              label,
              style: TextStyle(
                color: Colors.blue.shade600,
                fontSize: 9.0,
              ),
            ),
          ),
        ),
        const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 20.0,
        ),
      ],
    ),
  );
}
