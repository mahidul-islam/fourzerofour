import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Hunted extends StatefulWidget {
  const Hunted({
    super.key,
  });

  @override
  State<Hunted> createState() => _HuntedState();
}

class _HuntedState extends State<Hunted> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: left,
      // top: top,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(0),
        child: const SizedBox(
          height: 160,
          width: 110,
          child: RiveAnimation.asset(
            'assets/404.riv',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
