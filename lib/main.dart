import 'package:flutter/material.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/theme/app_theme.dart';
import 'package:haytek/theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppColors colors = AppColors();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haytek Süt Takip ',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      home: LoginScreen(),
    );
  }
}
