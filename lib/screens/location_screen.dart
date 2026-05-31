import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'map_screen.dart';

import 'verification_screen.dart';

class LocationScreen extends StatefulWidget {

  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() =>
      _LocationScreenState();
}

class _LocationScreenState
    extends State<LocationScreen> {

  String latitude = 'Loading...';
  String longitude = 'Loading...';

  String hospital1 = '';
  String hospital2 = '';
  String eta = '';

  @override
  void initState() {
    super.initState();

    getLocation();
  }

  Future<void> getLocation() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return;
    }

    permission =
    await Geolocator.checkPermission();

    if (permission ==
        LocationPermission.denied) {

      permission =
      await Geolocator.requestPermission();

      if (permission ==
          LocationPermission.denied) {

        return;
      }
    }

    if (permission ==
        LocationPermission.deniedForever) {

      return;
    }

    Position position =
    await Geolocator.getCurrentPosition(
      desiredAccuracy:
      LocationAccuracy.high,
    );

    setState(() {

double lat = position.latitude;
double lon = position.longitude;

// OMR Zone

if (lat >= 12.85 && lat <= 12.99 &&
lon >= 80.18 && lon <= 80.28) {

hospital1 = 'Apollo OMR';
hospital2 = 'Gleneagles Global';
eta = '6 mins';

// Aminjikarai Zone

} else if (lat >= 13.05 && lat <= 13.09 &&
lon >= 80.20 && lon <= 80.24) {

hospital1 = 'MGM Healthcare';
hospital2 = 'CFC Hospital';
eta = '8 mins';

// Velachery Zone

} else if (lat >= 12.95 && lat <= 13.05 &&
lon >= 80.20 && lon <= 80.25) {

hospital1 = 'Prashanth Hospital';
hospital2 = 'Vijaya Hospital';
eta = '7 mins';

// T Nagar Zone

} else if (lat >= 13.02 && lat <= 13.06 &&
lon >= 80.22 && lon <= 80.26) {

hospital1 = 'Apollo Main';
hospital2 = 'Kauvery Hospital';
eta = '7 mins';

// Anna Nagar Zone

} else if (lat >= 13.07 && lat <= 13.11 &&
lon >= 80.18 && lon <= 80.23) {

hospital1 = 'Sundaram Medical Foundation';
hospital2 = 'Frontier Lifeline';
eta = '9 mins';

// Porur Zone

} else if (lat >= 13.02 && lat <= 13.06 &&
lon >= 80.14 && lon <= 80.18) {

hospital1 = 'Ramachandra Hospital';
hospital2 = 'Saveetha Hospital';
eta = '8 mins';

// Adyar Zone

} else if (lat >= 12.98 && lat <= 13.02 &&
lon >= 80.24 && lon <= 80.28) {

hospital1 = 'Fortis Malar';
hospital2 = 'Apollo Spectra';
eta = '6 mins';

// Tambaram Zone

} else if (lat >= 12.90 && lat <= 12.95 &&
lon >= 80.10 && lon <= 80.16) {

hospital1 = 'Hindu Mission Hospital';
hospital2 = 'Annai Arul Hospital';
eta = '10 mins';

// Default Chennai

} else {

  hospital1 = 'Apollo Hospitals';
  hospital2 = 'Kauvery Hospital';
  eta = '10 mins';
}

      longitude =
          position.longitude.toString();

      latitude =
          position.latitude.toString();

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Live Location',
        ),
      ),

      body: SingleChildScrollView(

        child: Center(

        child: Padding(

          padding: const EdgeInsets.all(24),

           child: Column(

            mainAxisAlignment:
            MainAxisAlignment.start,

            children: [

              const SizedBox(height: 30),

              const Icon(
                Icons.location_on,
                size: 80,
                color: Colors.red,
              ),

              const SizedBox(height: 20),

              const Text(
                'Current GPS Location',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                'Latitude:\n$latitude',

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Longitude:\n$longitude',

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(width: 25),


              Row(

                mainAxisAlignment:
                MainAxisAlignment.center,

                children: [

                  ElevatedButton(

                    onPressed: getLocation,

                    child: const Padding(

                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),

                      child: Text(
                        'REFRESH',
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                          const MapScreen(),
                        ),
                      );
                    },

                    child: const Padding(

                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),

                      child: Text(

                        'OPEN MAP',

                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              Container(

                width: 500,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.red.shade50,

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(
                    color: Colors.red,
                    width: 2,
                  ),
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(

                      'Emergency Routing System',

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Nearby Emergency Centres:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      '• $hospital1',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      '• $hospital2',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      'Estimated Arrival: $eta',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Emergency Route Activated',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'Emergency Workflow Initiated',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                      const VerificationScreen(),
                    ),
                  );
                },

                child: const Text(

                  'VERIFY INCIDENT',

                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
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