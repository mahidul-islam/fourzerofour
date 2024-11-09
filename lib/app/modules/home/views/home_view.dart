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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.triggerHunterKlick();
        },
        foregroundColor: Colors.amber,
      ),
      backgroundColor: Colors.black38,
      body: SizedBox.expand(
        child: Stack(
          children: [
            Hunter(controller: controller),
            Hunted(controller: controller),
          ],
        ),
      ),
    );
  }
}
