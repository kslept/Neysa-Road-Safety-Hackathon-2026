import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../analytics_data.dart';
import 'emergency_popup_screen.dart';
import 'verification_screen.dart';

import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:sensors_plus/sensors_plus.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}


class _MonitoringScreenState extends State<MonitoringScreen> {

  bool emergencyTriggered = false;

  bool isCheckingAccident = false;

  double impactForce = 0;

  double accidentThreshold = 25;

  double x = 0;
  double y = 0;
  double z = 0;

  StreamSubscription? accelerometerSubscription;


  Future<void> loadSensitivity() async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {

      accidentThreshold =
          prefs.getDouble(
            'accidentSensitivity',
          ) ?? 25;
    });
  }

  @override
  void initState() {

    super.initState();

    AnalyticsData.monitoringSessions++;

    loadSensitivity();

    startMonitoring();

    setMonitoringState(true);

  }

  Future<void> setMonitoringState(
      bool value) async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setBool(
      'isMonitoring',
      value,
    );
  }

  void resetEmergencyTrigger() {

    Future.delayed(

      const Duration(seconds: 15),

          () {

        emergencyTriggered = false;

        isCheckingAccident = false;
      },
    );
  }

  void startMonitoring() {



    accelerometerSubscription =
        accelerometerEventStream().listen(

              (AccelerometerEvent event) {

            setState(() {

              x = event.x;
              y = event.y;
              z = event.z;
              impactForce = sqrt(
                (x * x) +
                    (y * y) +
                    (z * z),
              );
              if (impactForce > accidentThreshold &&
                  !emergencyTriggered &&
                  !isCheckingAccident) {

                isCheckingAccident = true;

                Future.delayed(

                  const Duration(seconds: 3),

                      () {

                    double currentForce = sqrt(
                      (x * x) +
                          (y * y) +
                          (z * z),
                    );

                    if (currentForce < 5) {

                      emergencyTriggered = true;

                      AnalyticsData.accidentsDetected++;

                      AnalyticsData.emergencyAlerts++;

                      resetEmergencyTrigger();

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>
                          const EmergencyPopupScreen(),
                        ),
                      );

                    } else {

                      isCheckingAccident = false;
                    }
                  },
                );
              }
            });
          },
        );
  }

  @override
  void dispose() {

    setMonitoringState(false);

    accelerometerSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Live Monitoring'),
      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.sensors,
                size: 100,
                color: Colors.red,
              ),

              const SizedBox(height: 40),

              Text(
                'X Axis: ${x.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Y Axis: ${y.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Z Axis: ${z.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              Text(
                'Impact Force: '
                    '${impactForce.toStringAsFixed(2)}',

                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Monitoring Device Movement...',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 50),

              ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                ),

                onPressed: () {

                  AnalyticsData.accidentsDetected++;

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                      const EmergencyPopupScreen(),
                    ),
                  );
                },

                child: const Text(
                  'SIMULATE ACCIDENT',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}