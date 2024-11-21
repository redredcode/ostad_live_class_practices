import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CounterController extends GetxController {
  int counter = 0;

  void increment() {
    counter++;
    update();
  }
}