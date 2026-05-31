import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'verification_screen.dart';

class MapScreen extends StatelessWidget {

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    appBar: AppBar(
    title: const Text('Emergency Map'),
    ),

    floatingActionButton:
    FloatingActionButton.extended(

    backgroundColor: Colors.blue,

    onPressed: () {

    Navigator.push(

    context,

    MaterialPageRoute(

    builder: (context) =>
    const VerificationScreen(),
    ),
    );
    },

    icon: const Icon(
    Icons.people,
    color: Colors.white,
    ),

    label: const Text(

    'VERIFY INCIDENT',

    style: TextStyle(
    color: Colors.white,
    ),
    ),
    ),

    body: FlutterMap(

        options: MapOptions(

          initialCenter: LatLng(
            13.068579,
            80.225353,
          ),

          initialZoom: 15,
        ),

        children: [

          Align(

            alignment: Alignment.topRight,

            child: Container(

              margin: const EdgeInsets.all(15),

              padding: const EdgeInsets.all(10),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(12),

                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black26,
                  ),
                ],
              ),

              child: const Column(

                mainAxisSize:
                MainAxisSize.min,

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(
                    '🔴 Incident Zone',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    '🔵 Emergency Centers',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Align(

            alignment: Alignment.bottomCenter,

            child: Container(

              margin: const EdgeInsets.only(
                bottom: 20,
              ),

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),

              decoration: BoxDecoration(

                color: Colors.red,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black26,
                  ),
                ],
              ),

              child: const Text(

                'Emergency Coordination Active',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),



          TileLayer(

            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

            userAgentPackageName:
            'com.example.neysa_app',
          ),

          PolylineLayer(

            polylines: [

              Polyline(

                points: [

                  LatLng(
                    13.068579,
                    80.225353,
                  ),

                  LatLng(
                    13.0720,
                    80.2200,
                  ),

                  LatLng(
                    13.0650,
                    80.2300,
                  ),
                ],

                strokeWidth: 5,

                color: Colors.red,
              ),
            ],
          ),

          MarkerLayer(

            markers: [

              // Accident Location Marker

              Marker(

                point: LatLng(
                  13.068579,
                  80.225353,
                ),

                width: 80,
                height: 80,

                child: const Icon(
                  Icons.warning,
                  size: 50,
                  color: Colors.red,
                ),
              ),

              // MGM Hospital Marker

              Marker(

                point: LatLng(
                  13.0720,
                  80.2200,
                ),

                width: 80,
                height: 80,

                child: const Icon(
                  Icons.local_hospital,
                  size: 40,
                  color: Colors.blue,
                ),
              ),

              // CFC Hospital Marker

              Marker(

                point: LatLng(
                  13.0650,
                  80.2300,
                ),

                width: 80,
                height: 80,

                child: const Icon(
                  Icons.local_hospital,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}