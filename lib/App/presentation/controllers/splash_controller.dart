import 'package:get/get.dart';

import '../../../core/utils/app_router.dart';
import '../../../core/utils/app_utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    goNext();
  }

  void goNext() async {
    await AppUtils.delay(milliseconds: 2000);
    navigateToTransactions();
  }

  void navigateToTransactions() => Get.offAllNamed(AppRoutes.transactionsRoute);
}
