// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:rive/rive.dart';

const FRAME_PER_SECOND = 30;
const SPEED = 5;

class HomeController extends GetxController {
  SMIInput<bool>? hunterKlick;

  RxBool isLoading = false.obs;

  RxDouble hunterLeft = 10.0.obs;
  RxDouble hunterTop = 10.0.obs;

  int hunterDirectionX = 1;
  int hunterDirectionY = 1;

  Timer? timer;

  @override
  void onInit() {
    hunterLeft.value = 20;
    hunterTop.value = 20;
    timer = Timer.periodic(
        const Duration(milliseconds: 1000 ~/ FRAME_PER_SECOND), (Timer timer) {
      updateHunterPosition(100);
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
      triggerKlick();
    }
  }

  void triggerKlick() async {
    await Future.delayed(const Duration(milliseconds: 100));
    hunterKlick?.value = true;
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

    hunterLeft.value = (hunterLeft.value) + (SPEED * hunterDirectionX);
    hunterTop.value = (hunterTop.value) + (SPEED * hunterDirectionY);
  }
}
