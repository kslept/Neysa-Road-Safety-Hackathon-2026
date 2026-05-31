import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  double accidentSensitivity = 25;

  bool autoAlertsEnabled = true;

  bool notificationsEnabled = true;

  bool darkModeEnabled = false;

  int emergencyCountdown = 10;

  @override
  void initState() {

    super.initState();

    loadSettings();
  }

  Future<void> loadSettings() async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {

      accidentSensitivity =
          prefs.getDouble(
            'accidentSensitivity',
          ) ?? 25;

      autoAlertsEnabled =
          prefs.getBool(
            'autoAlertsEnabled',
          ) ?? true;

      notificationsEnabled =
          prefs.getBool(
            'notificationsEnabled',
          ) ?? true;

      darkModeEnabled =
          prefs.getBool(
            'darkModeEnabled',
          ) ?? false;

      emergencyCountdown =
          prefs.getInt(
            'emergencyCountdown',
          ) ?? 10;
    });
  }

  Future<void> saveSettings() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setDouble(
      'accidentSensitivity',
      accidentSensitivity,
    );

    await prefs.setBool(
      'autoAlertsEnabled',
      autoAlertsEnabled,
    );

    await prefs.setBool(
      'notificationsEnabled',
      notificationsEnabled,
    );

    await prefs.setBool(
      'darkModeEnabled',
      darkModeEnabled,
    );

    await prefs.setInt(
      'emergencyCountdown',
      emergencyCountdown,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xfff5f5f5),

      appBar: AppBar(

        title: const Text(
          'Safety & System Settings',
        ),

        backgroundColor: Colors.deepPurple,

        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(

              'Emergency Safety Controls 🚨',

              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              'Configure intelligent accident detection and emergency response settings.',

              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 40),

            buildSectionTitle(
              'Accident Detection Sensitivity',
            ),

            Slider(

              value: accidentSensitivity,

              min: 10,
              max: 50,

              divisions: 8,

              label:
              accidentSensitivity
                  .toStringAsFixed(0),

              onChanged: (value) {

                setState(() {

                  accidentSensitivity = value;
                });

                saveSettings();
              },
            ),

            Text(

              'Current Threshold: '
                  '${accidentSensitivity.toStringAsFixed(0)}',

              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            buildSectionTitle(
              'Emergency Countdown',
            ),

            DropdownButton<int>(

              value: emergencyCountdown,

              isExpanded: true,

              items: [5, 10, 15, 20]
                  .map(

                    (seconds) {

                  return DropdownMenuItem(

                    value: seconds,

                    child: Text(
                      '$seconds seconds',
                    ),
                  );
                },
              ).toList(),

              onChanged: (value) {

                setState(() {

                  emergencyCountdown =
                  value!;
                });

                saveSettings();
              },
            ),

            const SizedBox(height: 30),

            buildSectionTitle(
              'Safety Automation',
            ),

            SwitchListTile(

              title: const Text(
                'Enable Auto Emergency Alerts',
              ),

              value: autoAlertsEnabled,

              onChanged: (value) {

                setState(() {

                  autoAlertsEnabled =
                      value;
                });

                saveSettings();
              },
            ),

            SwitchListTile(

              title: const Text(
                'Enable Notifications',
              ),

              value:
              notificationsEnabled,

              onChanged: (value) {

                setState(() {

                  notificationsEnabled =
                      value;
                });

                saveSettings();
              },
            ),

            SwitchListTile(

              title: const Text(
                'Dark Mode',
              ),

              value: darkModeEnabled,

              onChanged: (value) {

                setState(() {

                  darkModeEnabled =
                      value;
                });

                saveSettings();
              },
            ),

            const SizedBox(height: 40),

            buildSectionTitle(
              'System Status',
            ),

            buildStatusCard(
              'GPS Status',
              'ACTIVE',
              Colors.green,
            ),

            buildStatusCard(
              'Accelerometer Sensors',
              'CONNECTED',
              Colors.blue,
            ),

            buildStatusCard(
              'Emergency Monitoring',
              'READY',
              Colors.orange,
            ),

            const SizedBox(height: 40),

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: const Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    'About Neysa',

                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 10),

                  Text(

                    'Neysa is an AI-powered emergency response and accident detection system designed to reduce emergency response time using smartphone sensors, GPS tracking, intelligent analytics, and automated emergency workflows.',

                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(
      String title) {

    return Padding(

      padding:
      const EdgeInsets.only(bottom: 10),

      child: Text(

        title,

        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildStatusCard(
      String title,
      String status,
      Color color) {

    return Card(

      margin:
      const EdgeInsets.only(bottom: 15),

      child: ListTile(

        leading: CircleAvatar(
          backgroundColor: color,
          child: const Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),

        title: Text(title),

        trailing: Text(

          status,

          style: TextStyle(

            color: color,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}