
import 'package:flutter/material.dart';
import 'screens/pantalla_clima.dart';

void main() {
  runApp(const ClimaApp());
}

class ClimaApp extends StatelessWidget {
  const ClimaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const PantallaClima(),
    );
  }
}
