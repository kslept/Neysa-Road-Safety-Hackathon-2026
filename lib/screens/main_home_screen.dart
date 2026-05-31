import 'package:flutter/material.dart';

import '../widgets/dashboard_card.dart';
import '../constants/app_colors.dart';

import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'users_screen.dart';
import 'monitoring_screen.dart';
import 'location_screen.dart';
import '../animations/fade_animation.dart';
import 'map_screen.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              FadeAnimation(

                delay: 200,

                child: const Text(
                  'Welcome Back 👋',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              FadeAnimation(

                delay: 400,

                child: const Text(
                  'Manage your Flutter application professionally.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              LayoutBuilder(

                builder: (context, constraints) {

                  int crossAxisCount = 1;

                  if (constraints.maxWidth > 1200) {
                    crossAxisCount = 4;
                  } else if (constraints.maxWidth > 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                  }

                  return GridView.count(

                    crossAxisCount: crossAxisCount,

                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    crossAxisSpacing: 20,

                    mainAxisSpacing: 20,

                    childAspectRatio: 1.5,

                    children: [

                      FadeAnimation(

                        delay: 600,

                        child: DashboardCard(
                          icon: Icons.dashboard,
                          title: 'Dashboard',
                          subtitle: 'Overview of app activity',
                          color: AppColors.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const DashboardScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      FadeAnimation(

                        delay: 800,

                        child: DashboardCard(
                          icon: Icons.analytics,
                          title: 'Analytics',
                          subtitle: 'Track app performance',
                          color: Colors.blue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const AnalyticsScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      FadeAnimation(

                        delay: 1000,

                        child: DashboardCard(
                          icon: Icons.settings,
                          title: 'Settings',
                          subtitle: 'Manage application settings',
                          color: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      FadeAnimation(

                        delay: 1200,

                        child: DashboardCard(
                          icon: Icons.people,
                          title: 'Users',
                          subtitle: 'Manage application users',
                          color: Colors.green,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const UsersScreen(),
                              ),
                            );
                          },
                        ),
                      ),

                      FadeAnimation(

                        delay: 1400,

                        child: DashboardCard(
                          icon: Icons.sensors,
                          title: 'Monitoring',
                          subtitle: 'Live accident monitoring',
                          color: Colors.red,

                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const MonitoringScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      FadeAnimation(

                        delay: 1600,

                        child: DashboardCard(
                          icon: Icons.location_on,
                          title: 'Location',
                          subtitle: 'Live GPS tracking',
                          color: Colors.redAccent,

                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const LocationScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      FadeAnimation(

                        delay: 1800,

                        child: DashboardCard(
                          icon: Icons.map,
                          title: 'Emergency Map',
                          subtitle: 'View live emergency location',
                          color: Colors.redAccent,

                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const MapScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}