import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fourzerofour/main.dart';
import 'package:rive/rive.dart';

class Hunter extends StatefulWidget {
  const Hunter({
    super.key,
    // required this.side,
    // required this.color,
    // required this.top,
    // required this.left,
    // required this.speed,
    // required this.updateTargetBoardPosition,
    // required this.index,
    // required this.hitCount,
    // required this.assetPath,
    // required this.hitted,
  });

  // final double side;

  // final Color color;
  // final double top;
  // final double left;
  // final double speed;
  // final Function updateTargetBoardPosition;
  // final int index;
  // final int hitCount;
  // final String assetPath;
  // final bool hitted;

  @override
  State<Hunter> createState() => _HunterState();
}

class _HunterState extends State<Hunter> {
  double left = 10.0;
  double top = 10.0;

  int directionX = 1;
  int directionY = 1;

  Timer? timer;

  @override
  void initState() {
    left = 20;
    top = 20;
    timer = Timer.periodic(
        const Duration(milliseconds: 1000 ~/ FRAME_PER_SECOND), (Timer timer) {
      update(100);
    });

    super.initState();
  }

  SMITrigger? _bump;

  void _onRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Artboard');
    artboard.addController(controller!);
    _bump = controller.getTriggerInput('bump');
  }

  void _hitBump() => _bump?.fire();

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void update(double containerWidth) {
    final Size size = MediaQuery.of(context).size;
    if (left > (size.width - containerWidth)) {
      if (directionX == 1) {
        directionX = -1;
      }
    }
    if ((left < 0)) {
      if (directionX == -1) {
        directionX = 1;
      }
    }

    if (top > (size.height - containerWidth)) {
      if (directionY == 1) {
        directionY = -1;
      }
    }
    if ((top < 0)) {
      if (directionY == -1) {
        directionY = 1;
      }
    }

    setState(() {
      left = (left) + (SPEED * directionX);
      top = (top) + (SPEED * directionY);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: SizedBox(
        height: 160,
        width: 110,
        child: RiveAnimation.asset(
          'assets/Robi.riv',
          fit: BoxFit.cover,
          onInit: _onRiveInit,
        ),
      ),
    );
  }
}
