import 'package:flutter/material.dart';

import 'dashboard_layout.dart';
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() =>
      _VerificationScreenState();
}

class _VerificationScreenState
    extends State<VerificationScreen> {

  String status =
      'Awaiting Witness Verification';

  Color statusColor = Colors.orange;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Witness Verification Simulation',
        ),
      ),

      body: Center(

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Icon(
                Icons.people_alt,
                size: 100,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              const Text(

                'Possible Accident Detected Nearby',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              const Text(

                'This screen simulates a nearby witness receiving a verification request.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(

                style:
                ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),

                onPressed: () {

                  setState(() {

                    status =
                    'Witness Verification Successful\n\nProceeding to Emergency Workflow...';

                    statusColor =
                        Colors.green;
                  });

                  Future.delayed(

                    const Duration(seconds: 2),

                        () {

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardLayout(),
                            ),
                                (route) => false,
                          );
                    },
                  );
                },

                child: const Text(
                  'CONFIRM ACCIDENT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(

                style:
                ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),

                onPressed: () {

                  setState(() {

                    status =
                    'False Alert Reported\n\nEmergency Workflow Cancelled';

                    statusColor = Colors.red;
                  });

                  Future.delayed(
                    const Duration(seconds: 2),
                        () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardLayout(),
                            ),
                                (route) => false,
                          );
                    },
                  );
                },

                child: const Text(
                  'FALSE ALERT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              Text(

                status,

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}