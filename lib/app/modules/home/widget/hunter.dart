import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fourzerofour/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

class Hunter extends StatelessWidget {
  const Hunter({super.key, required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Positioned(
        // Adjust position to center the circle around the hunter
        left: controller.hunterLeft.value - (Get.width / 3 - 55),
        top: controller.hunterTop.value - (Get.width / 3 - 80),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Semi-transparent circle
            Container(
              width: Get.width / 3 * 2,
              height: Get.width / 3 * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFF4CC).withOpacity(0.3),
              ),
            ),
            // Hunter character
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(controller.hunterDirectionX >= 0 ? 0 : pi),
              child: SizedBox(
                height: 160,
                width: 110,
                child: RiveAnimation.asset(
                  'assets/Robi.riv',
                  fit: BoxFit.cover,
                  onInit: controller.onHunterRiveInit,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
