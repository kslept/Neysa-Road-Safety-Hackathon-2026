import 'package:flutter/material.dart';

import '../widgets/sidebar_widget.dart';

import 'dashboard_screen.dart';
import 'analytics_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {

  int selectedIndex = 0;

  final List<Widget> screens = const [
    DashboardScreen(),
    AnalyticsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    final bool isMobile = screenWidth < 768;

    return Scaffold(

      backgroundColor: const Color(0xfff5f5f5),

      drawer: isMobile
          ? Drawer(
        child: SidebarWidget(
          selectedIndex: selectedIndex,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
            Navigator.pop(context);
          },
        ),
      )
          : null,

      appBar: isMobile
          ? AppBar(
        title: const Text('NEYSA'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      )
          : null,

      body: isMobile

          ? screens[selectedIndex]

          : Row(
        children: [

          SidebarWidget(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),

          Expanded(
            child: screens[selectedIndex],
          ),
        ],
      ),
    );
  }
}