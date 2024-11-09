import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fourzerofour/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class Hunted extends StatelessWidget {
  const Hunted({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Positioned(
        left: controller.huntedLeft.value,
        top: controller.huntedTop.value,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateY(controller.huntedDirectionX >= 0 ? 0 : pi),
          child: SizedBox(
            height: 160,
            width: 110,
            child: RiveAnimation.asset(
              'assets/404.riv',
              fit: BoxFit.cover,
              onInit: controller.onHuntedRiveInit,
            ),
          ),
        ),
      );
    });
  }
}
