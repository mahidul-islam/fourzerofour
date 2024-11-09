import 'package:flutter/material.dart';
import 'package:fourzerofour/app/modules/home/widget/hunted.dart';
import 'package:fourzerofour/app/modules/home/widget/hunter.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set Scaffold background to transparent
      body: SizedBox.expand(
        child: Stack(
          children: [
            // Gradient background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xff333333)
                        .withOpacity(0.5), // Darker charcoal at the top
                    const Color(0xff555555)
                        .withOpacity(0.3), // Lighter charcoal at the bottom
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Main content on top of the background
            Positioned.fill(
              child: Stack(
                children: [
                  Hunter(controller: controller),
                  Hunted(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
