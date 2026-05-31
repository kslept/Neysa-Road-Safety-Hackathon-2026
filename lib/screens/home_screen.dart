import 'package:flutter/material.dart';

import '../widgets/bottom_nav_bar.dart';

import 'main_home_screen.dart';
import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'settings_screen.dart';
import 'users_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;

  final List<Widget> screens = [

    const MainHomeScreen(),

    const DashboardScreen(),

    const AnalyticsScreen(),

    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;
          });
        },
      ),
    );
  }
}