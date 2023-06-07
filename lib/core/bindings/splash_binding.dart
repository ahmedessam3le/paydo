import 'package:get/get.dart';

import '../../App/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
