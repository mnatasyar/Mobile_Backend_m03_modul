import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomBackgroundApp(),
    );
  }
}

class RandomBackgroundApp extends StatefulWidget {
  @override
  _RandomBackgroundAppState createState() => _RandomBackgroundAppState();
}

class _RandomBackgroundAppState extends State<RandomBackgroundApp> {
  Color _backgroundColor = Colors.white; // Warna latar belakang awal
  Timer? _timer;

  void _changeBackgroundColor() {
    setState(() {
      // Menghasilkan warna acak
      final random = Random();
      _backgroundColor = Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      );
    });
  }

  @override
  void initState() {
    super.initState();

    // Mengganti warna latar belakang setiap detik
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _changeBackgroundColor();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Membatalkan timer saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _backgroundColor,
        child: Center(
          child: Text(
            'Random Background',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
