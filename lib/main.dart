import 'package:flutter/material.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/theme/app_theme.dart';
import 'package:haytek/theme/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  AppColors colors = AppColors();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: LoginScreen(),
    );
  }
}
