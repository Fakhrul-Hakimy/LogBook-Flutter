import 'package:flutter/material.dart';
import 'package:logbook/pages/add_page.dart';
import 'package:logbook/pages/home_page.dart';
import 'package:logbook/pages/login_page.dart';
import 'package:logbook/pages/list_page.dart';
import 'package:logbook/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home :  LoginPage(),

      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => listPage(),
        '/add': (context) => const AddPage(),
        '/register': (context) => registerPage(),
      },
    );
  }
}