// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fourzerofour/hunter.dart';

const FRAME_PER_SECOND = 30;
const SPEED = 5;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              Hunter(),
            ],
          ),
        ),
      ),
    );
  }
}
