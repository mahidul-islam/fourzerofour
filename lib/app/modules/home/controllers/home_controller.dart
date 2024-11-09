// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

const FRAME_PER_SECOND = 30;
const HUNTER_SPEED = 5;
const HUNTED_SPEED = 10;

class HomeController extends GetxController {
  final random = Random();
  double huntedAngle = 0.0; // Current angle of movement

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

    huntedLeft.value = Get.width - 120;
    huntedTop.value = Get.height - 180;
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
    final double scareDistance = size.width / 3;
    final double safeDistance = size.width / 2;

    // Calculate distance between hunter and hunted
    double dx = hunterLeft.value - huntedLeft.value;
    double dy = hunterTop.value - huntedTop.value;
    double distance = sqrt(dx * dx + dy * dy);

    // If hunter is too far, stop flee
    if (distance > safeDistance) {
      // triggerHuntedKlick();
      return;
    }

    if (distance < scareDistance) {
      // Calculate base angle away from hunter
      double baseAngle = atan2(-dy, -dx);

      // Add random deviation (-π/4 to π/4, or -45° to +45°)
      double randomDeviation = (random.nextDouble() - 0.5) * pi / 2;

      // If near wall, adjust angle to move away from it
      final wallMargin = containerWidth * 1.5;
      if (huntedLeft.value < wallMargin) {
        baseAngle = baseAngle.abs(); // Move right
      } else if (huntedLeft.value > size.width - wallMargin) {
        baseAngle = pi - baseAngle.abs(); // Move left
      }
      if (huntedTop.value < wallMargin) {
        baseAngle =
            (baseAngle < 0 ? -pi / 2 : pi / 2) + (baseAngle / 2); // Move down
      } else if (huntedTop.value > size.height - wallMargin) {
        baseAngle =
            (baseAngle < 0 ? -pi / 2 : pi / 2) - (baseAngle / 2); // Move up
      }

      // Set new movement angle with smooth transition
      huntedAngle = baseAngle + randomDeviation;

      // Convert angle to directions
      huntedDirectionX = cos(huntedAngle).sign.toInt();
      huntedDirectionY = sin(huntedAngle).sign.toInt();

      // Calculate actual movement using the angle
      double speedMultiplier = 1.0;
      if (distance < scareDistance / 2) {
        speedMultiplier = 1.5; // Boost speed when very close
      }

      huntedLeft.value += HUNTED_SPEED * speedMultiplier * cos(huntedAngle);
      huntedTop.value += HUNTED_SPEED * speedMultiplier * sin(huntedAngle);

      // Trigger scared animation
      // triggerHuntedKlick();

      return;
    }

    // Check screen boundaries and bounce
    if (huntedLeft.value > (size.width - containerWidth)) {
      if (huntedDirectionX == 1) {
        huntedDirectionX = -1;
      }
    }
    if (huntedLeft.value < 0) {
      if (huntedDirectionX == -1) {
        huntedDirectionX = 1;
      }
    }

    if (huntedTop.value > (size.height - containerWidth)) {
      if (huntedDirectionY == 1) {
        huntedDirectionY = -1;
      }
    }
    if (huntedTop.value < 0) {
      if (huntedDirectionY == -1) {
        huntedDirectionY = 1;
      }
    }

    // Regular movement when hunter is not too close
    huntedLeft.value = huntedLeft.value + (HUNTED_SPEED * huntedDirectionX);
    huntedTop.value = huntedTop.value + (HUNTED_SPEED * huntedDirectionY);
  }
}
