import 'package:flutter/material.dart';

import 'emergency_contacts_screen.dart';

import 'monitoring_screen.dart';

import 'location_screen.dart';

import 'emergency_popup_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:geolocator/geolocator.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState
    extends State<DashboardScreen> {

  int contactsCount = 0;
  String gpsStatus = 'CHECKING';
  String monitoringStatus = 'INACTIVE';
  List<String> activityLogs = [];

  @override
  void initState() {

    super.initState();

    loadContactsCount();

    checkGpsStatus();

    loadMonitoringStatus();

    addActivity('Dashboard initialized');

    addActivity('Emergency system ready');
  }

  void addActivity(String activity) {

    setState(() {

      activityLogs.insert(0, activity);

      if (activityLogs.length > 5) {

        activityLogs.removeLast();
      }
    });
  }

  Future<void> checkGpsStatus() async {

    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    LocationPermission permission =
    await Geolocator.checkPermission();

    setState(() {

      if (!serviceEnabled) {

        gpsStatus = 'DISABLED';

      } else if (
      permission == LocationPermission.denied ||
          permission ==
              LocationPermission.deniedForever) {

        gpsStatus = 'DISCONNECTED';

      } else {

        gpsStatus = 'CONNECTED';
        addActivity('GPS connected');
      }
    });
  }

  Future<void> loadMonitoringStatus() async {

    final prefs =
    await SharedPreferences.getInstance();

    bool isMonitoring =
        prefs.getBool('isMonitoring') ?? false;

    setState(() {

      monitoringStatus =
      isMonitoring
          ? 'ACTIVE'
          : 'INACTIVE';
    });
  }

  Future<void> loadContactsCount() async {

    final prefs =
    await SharedPreferences.getInstance();

    List<String> contacts =
        prefs.getStringList('contacts') ?? [];

    setState(() {

      contactsCount = contacts.length;
    });
  }

  Widget buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(

      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Row(
          children: [

            Container(
              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              ),

              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(width: 20),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  value,

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityTile(
      IconData icon,
      Color color,
      String title,
      String subtitle,
      ) {
    return ListTile(

      leading: CircleAvatar(
        backgroundColor: color,

        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),

      title: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),

      subtitle: Text(
        subtitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),

      appBar: AppBar(
        title: const Text('Neysa Emergency System'),

        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              'Welcome Back 👋',

              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'AI Powered Emergency Response System',

              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            buildStatCard(
              context,
              'Monitoring Status',
              monitoringStatus,
              Icons.sensors,
              Colors.red,

                  () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                    const MonitoringScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            buildStatCard(
              context,
              'GPS Status',
              gpsStatus,
              Icons.location_on,
              Colors.green,

                  () async {

                await Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                    const LocationScreen(),
                  ),
                );

                checkGpsStatus();
              },
            ),

            const SizedBox(height: 20),

            buildStatCard(
              context,
              'Emergency Contacts',
              '$contactsCount SAVED',
              Icons.contact_phone,
              Colors.orange,

                  () async {

                await Navigator.push(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                    const EmergencyContactsScreen(),
                  ),
                );
                loadContactsCount();
              },
            ),

            const SizedBox(height: 20),

            buildStatCard(
              context,
              'Emergency Alerts',
              'READY',
              Icons.warning,
              Colors.blue,

                  () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                    const EmergencyPopupScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 70,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                      const MonitoringScreen(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.warning_amber_rounded,
                  size: 32,
                  color: Colors.white,
                ),

                label: const Text(
                  'START MONITORING',

                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Emergency Activity',

              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Container(

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(

                children:

                activityLogs.map((activity) {

                  return Column(

                    children: [

                      buildActivityTile(

                        Icons.bolt,

                        Colors.red,

                        activity,

                        'Neysa emergency activity',
                      ),

                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}