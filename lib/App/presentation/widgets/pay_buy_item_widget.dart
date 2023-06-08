import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paydo/App/presentation/widgets/pay_header.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/const/app_values.dart';
import '../../../core/style/app_styles.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/responsive_view.dart';

class PayBuyItemWidget extends StatelessWidget {
  final TextEditingController itemTC;
  final void Function() onTapPay;

  const PayBuyItemWidget({
    Key? key,
    required this.itemTC,
    required this.onTapPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PayHeader(
          header: AppStrings.toWhom.tr,
          child: SizedBox(
            height: 100,
            child: ResponsiveView(
              maxWidth: AppValues.secondaryWidthLimiter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 44,
                ),
                child: TextField(
                  controller: itemTC,
                  cursorColor: Get.textTheme.displayLarge?.color,
                  style: Get.textTheme.displayLarge?.copyWith(
                    fontSize: 25,
                  ),
                  decoration: AppStyles.inputDecorationUnderline(
                      Get.textTheme.displayLarge?.color),
                ),
              ),
            ),
          ),
        ),
        AppMainButton(
          title: AppStrings.next.tr,
          margin: const EdgeInsets.only(
            bottom: 34,
          ),
          onPressed: onTapPay,
        ),
      ],
    );
  }
}
