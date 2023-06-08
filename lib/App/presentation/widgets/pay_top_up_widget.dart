import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paydo/App/presentation/widgets/numeric_keyboard.dart';
import 'package:paydo/App/presentation/widgets/pay_amount_widget.dart';
import 'package:paydo/App/presentation/widgets/pay_header.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/widgets/app_buttons.dart';

class PayTopUpWidget extends StatelessWidget {
  final RxString price;
  final void Function() onTapNext;

  const PayTopUpWidget({
    Key? key,
    required this.price,
    required this.onTapNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PayHeader(
          header: AppStrings.howMuch,
          child: PayAmountWidget(
            price: price,
          ),
        ),
        NumericKeyboard(
          value: price,
        ),
        AppMainButton(
          title: AppStrings.next,
          margin: const EdgeInsets.only(
            bottom: 34,
          ),
          onPressed: onTapNext,
        ),
      ],
    );
  }
}
