// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:fourzerofour/hunter.dart';
import 'package:rive/rive.dart';

const FRAME_PER_SECOND = 30;
const SPEED = 5;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  SMIInput<bool>? klick;
  void getKlickRef(SMIInput<bool>? k) {
    klick = k;
  }

  void triggerKlick() {
    klick?.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            triggerKlick();
          },
          foregroundColor: Colors.amber,
        ),
        backgroundColor: Colors.black38,
        body: SizedBox.expand(
          child: Stack(
            children: [
              Hunter(
                getKlick: getKlickRef,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
