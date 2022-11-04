import 'package:flutter/material.dart';
import 'package:sertifikasi/Screens/geomaps.dart';
import 'package:sertifikasi/Screens/home.dart';
import 'package:sertifikasi/Screens/login.dart';
import 'package:sertifikasi/Screens/maps.dart';
import 'package:sertifikasi/Screens/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sertifikasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginForm(),
      routes: {
        '/home' : (context) => const Home(),
        '/profile' : (context) => Profile(),
        '/maps' : (context) => const GeoMaps(dataUser: null,) 
      },
    );
  }
}

