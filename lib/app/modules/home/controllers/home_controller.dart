// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

const FRAME_PER_SECOND = 30;
const HUNTER_SPEED = 5;
const HUNTED_SPEED = 15;

class HomeController extends GetxController {
  SMIInput<bool>? hunterKlick;
  SMIInput<bool>? huntedKlick;

  RxBool isLoading = false.obs;

  RxDouble hunterLeft = 10.0.obs;
  RxDouble hunterTop = 10.0.obs;

  RxDouble huntedLeft = 10.0.obs;
  RxDouble huntedTop = 10.0.obs;

  int hunterDirectionX = 1;
  int hunterDirectionY = 1;

  int huntedDirectionX = 1;
  int huntedDirectionY = 1;

  Timer? timer;

  @override
  void onInit() {
    hunterLeft.value = 20;
    hunterTop.value = 20;

    huntedLeft.value = 20;
    huntedTop.value = 20;
    timer = Timer.periodic(
        const Duration(milliseconds: 1000 ~/ FRAME_PER_SECOND), (Timer timer) {
      updateHunterPosition(100);
      updateHuntedPosition(100);
    });

    super.onInit();
  }

  void onHunterRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);

      // Initialize the SMIInputs
      hunterKlick = controller.findInput<bool>('Klick');
      // widget.getKlick.call(klick);
      triggerHunterKlick();
    }
  }

  void onHuntedRiveInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');
    if (controller != null) {
      artboard.addController(controller);

      // Initialize the SMIInputs
      huntedKlick = controller.findInput<bool>('Klick');
      // widget.getKlick.call(klick);
      triggerHuntedKlick();
    }
  }

  void triggerHunterKlick() async {
    await Future.delayed(const Duration(milliseconds: 100));
    hunterKlick?.value = true;
  }

  void triggerHuntedKlick() async {
    await Future.delayed(const Duration(milliseconds: 100));
    huntedKlick?.value = true;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void updateHunterPosition(double containerWidth) {
    final Size size = Get.size;
    if (hunterLeft > (size.width - containerWidth)) {
      if (hunterDirectionX == 1) {
        hunterDirectionX = -1;
      }
    }
    if ((hunterLeft < 0)) {
      if (hunterDirectionX == -1) {
        hunterDirectionX = 1;
      }
    }

    if (hunterTop > (size.height - containerWidth)) {
      if (hunterDirectionY == 1) {
        hunterDirectionY = -1;
      }
    }
    if ((hunterTop < 0)) {
      if (hunterDirectionY == -1) {
        hunterDirectionY = 1;
      }
    }

    hunterLeft.value = (hunterLeft.value) + (HUNTER_SPEED * hunterDirectionX);
    hunterTop.value = (hunterTop.value) + (HUNTER_SPEED * hunterDirectionY);
  }

  void updateHuntedPosition(double containerWidth) {
    final Size size = Get.size;

    huntedLeft.value = (huntedLeft.value) + (HUNTED_SPEED * huntedDirectionX);
    huntedTop.value = (huntedTop.value) + (HUNTED_SPEED * huntedDirectionY);
  }
}
