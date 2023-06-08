import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/enums/pay_enum.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_progress.dart';
import '../controllers/pay_controller.dart';
import '../widgets/pay_buy_item_widget.dart';
import '../widgets/pay_top_up_widget.dart';

class PayView extends GetView<PayController> {
  const PayView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayController>(
      autoRemove: false,
      builder: (_) {
        if (controller.viewState == ViewStateEnum.error) {
          return const AppErrorWidget(
            hideBack: false,
          );
        } else if (controller.viewState == ViewStateEnum.loading) {
          return const AppProgress();
        } else {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              backgroundColor: Get.theme.primaryColor,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  AppStrings.appName,
                  style: Get.textTheme.headlineLarge!
                      .copyWith(color: AppColors.white),
                ),
                actions: [
                  AppCancelButton(
                    onTap: controller.onWillPop,
                    color: Get.theme.appBarTheme.titleTextStyle?.color,
                  ),
                ],
              ),
              body: SafeArea(
                child: Builder(
                  builder: (_) {
                    if (controller.payEnum == PayEnum.payTopUp) {
                      return PayTopUpWidget(
                        price: controller.amount,
                        onTapNext: controller.onNextTap,
                      );
                    } else if (controller.payEnum == PayEnum.payWho) {
                      return PayBuyItemWidget(
                        itemTC: controller.amountController,
                        onTapPay: controller.onPayTap,
                      );
                    } else {
                      return const AppErrorWidget();
                    }
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
