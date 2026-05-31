import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';

import 'providers/theme_provider.dart';

import 'screens/dashboard_layout.dart';
import 'screens/home_screen.dart';

void main() {

  runApp(

    ChangeNotifierProvider(

      create: (_) => ThemeProvider(),

      child: const NeysaApp(),
    ),
  );
}

class NeysaApp extends StatelessWidget {

  const NeysaApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Neysa App',

      theme: AppTheme.lightTheme,

      darkTheme: ThemeData.dark(),

      themeMode:
      Provider.of<ThemeProvider>(context).currentTheme,

      home: const DashboardLayout(),
    );
  }
}