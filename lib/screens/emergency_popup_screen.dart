  import 'dart:async';
  
  import 'package:flutter/material.dart';
  
  import 'package:shared_preferences/shared_preferences.dart';
  
  import '../analytics_data.dart';
  
  import 'location_screen.dart';
  
  import 'verification_screen.dart';


  class EmergencyPopupScreen extends StatefulWidget {
  
    const EmergencyPopupScreen({super.key});
  
    @override
    State<EmergencyPopupScreen> createState() =>
        _EmergencyPopupScreenState();
  }
  
  class _EmergencyPopupScreenState
      extends State<EmergencyPopupScreen> {
  
    List<String> emergencyContacts = [];
  
    int countdown = 10;
  
    Timer? timer;
  
    @override
    void initState() {
  
      super.initState();
  
      loadContacts();
  
      startCountdown();
    }
  
    Future<void> loadContacts() async {
  
      final prefs =
      await SharedPreferences.getInstance();
  
      setState(() {
  
        emergencyContacts =
            prefs.getStringList('contacts') ?? [];
      });
    }
  
    void startCountdown() {
  
      timer = Timer.periodic(
  
        const Duration(seconds: 1),
  
            (timer) {
  
          if (countdown == 0) {
  
            timer.cancel();
  
            showDialog(
  
              context: context,
  
              barrierDismissible: false,
  
              builder: (context) {
  
                return AlertDialog(
  
                  title: const Text(
                    'Emergency Alert Sent',
                  ),
  
                  content: Column(
  
                    mainAxisSize: MainAxisSize.min,
  
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
  
                    children: [
  
                      const Text(
                        'Emergency Alert Sent Successfully',
                      ),
  
                      const SizedBox(height: 20),
  
                      if (emergencyContacts.isEmpty)
  
                        const Text(
                          'No emergency contacts found.',
                        )
  
                      else
  
                        ...emergencyContacts.map(
  
                              (contact) {
  
                            return Padding(
  
                              padding:
                              const EdgeInsets.only(
                                bottom: 10,
                              ),
  
                              child: Text(
                                'Alert sent to: $contact',
                              ),
                            );
                          },
                        ),
                    ],
                  ),
  
                  actions: [
  
                    ElevatedButton(
  
                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
  
  
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
                            const LocationScreen(),
                          ),
                        );
                      },
  
                      child: const Text(
  
                        'OPEN LIVE LOCATION',
  
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
  
                    TextButton(
  
                      onPressed: () {
  
                        Navigator.pop(context);
  
                        Navigator.pop(context);
                      },
  
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
  
          } else {
  
            setState(() {
  
              countdown--;
            });
          }
        },
      );
    }
  
    @override
    void dispose() {
  
      timer?.cancel();
  
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
  
      return Scaffold(
  
        backgroundColor: Colors.red.shade50,
  
        body: SingleChildScrollView(
  
          child: Center(
  
            child: Padding(
  
            padding: const EdgeInsets.all(24),
  
            child: Column(
  
              mainAxisAlignment:
              MainAxisAlignment.center,
  
              children: [
  
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.red,
                  size: 120,
                ),
  
                const SizedBox(height: 40),
  
                const Text(
                  'Possible Accident Detected!',
  
                  textAlign: TextAlign.center,
  
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
  
                const SizedBox(height: 20),
  
                const Text(
                  'Emergency alert will be sent unless cancelled.',
  
                  textAlign: TextAlign.center,
  
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black54,
                  ),
                ),
  
                const SizedBox(height: 50),
  
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
  
                  child: Column(
  
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
  
                    children: [
  
                      const Text(
  
                        'Emergency Intelligence Flow',
  
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
  
                      const SizedBox(height: 20),
  
                      Wrap(
  
                        spacing: 16,
                        runSpacing: 16,
  
                        children: [
  
                          buildFlowItem(
                            Icons.warning,
                            'Accident',
                            Colors.red,
                          ),
  
                          buildFlowItem(
                            Icons.gps_fixed,
                            'GPS Locked',
                            Colors.green,
                          ),
  
                          buildFlowItem(
                            Icons.contacts,
                            'Contacts Alerted',
                            Colors.blue,
                          ),
  
                          buildFlowItem(
                            Icons.local_hospital,
                            'Hospital Found',
                            Colors.purple,
                          ),
  
                          buildFlowItem(
                            Icons.route,
                            'ETA 8 mins',
                            Colors.orange,
                          ),
  
                          buildFlowItem(
                            Icons.support_agent,
                            'Coordination',
                            Colors.teal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
  
                const SizedBox(height: 40),
  
                Container(
  
                  padding: const EdgeInsets.all(30),
  
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
  
                  child: Text(
  
                    countdown.toString(),
  
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
  
                const SizedBox(height: 50),
  
                ElevatedButton(
  
                  style: ElevatedButton.styleFrom(
  
                    backgroundColor: Colors.green,
  
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),
                  ),

                  onPressed: () {

                    timer?.cancel();

                    AnalyticsData.falsePositives++;

                    Navigator.pop(context);
                  },
  
                  child: const Text(
  
                    'I AM SAFE',
  
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
      ),
      );
    }
  
    Widget buildFlowItem(
        IconData icon,
        String title,
        Color color) {
  
      return Container(
  
        width: 180,
  
        padding: const EdgeInsets.all(16),
  
        decoration: BoxDecoration(
  
          color: Colors.white,
  
          borderRadius:
          BorderRadius.circular(16),
  
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
  
        child: Column(
  
          mainAxisSize: MainAxisSize.min,
  
          children: [
  
            CircleAvatar(
  
              backgroundColor:
              color.withOpacity(0.15),
  
              child: Icon(
                icon,
                color: color,
              ),
            ),
  
            const SizedBox(height: 12),
  
            Text(
  
              title,
  
              textAlign: TextAlign.center,
  
              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }