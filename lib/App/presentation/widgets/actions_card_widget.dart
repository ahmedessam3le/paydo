import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/const/app_values.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_icons.dart';

class ActionsCardWidget extends StatelessWidget {
  final void Function() onTapPay;
  final void Function() onTapTopUp;

  const ActionsCardWidget({
    Key? key,
    required this.onTapPay,
    required this.onTapTopUp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 20,
      left: 20,
      child: Center(
        child: Container(
          height: 100,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          constraints: const BoxConstraints(
            maxWidth: AppValues.mainWidthLimiter,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionIcon(
                icon: AppIcons.icPay,
                title: AppStrings.pay,
                onTap: onTapPay,
              ),
              _buildActionIcon(
                icon: AppIcons.icTopUp,
                title: AppStrings.topUp,
                onTap: onTapTopUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon({
    required String icon,
    required String title,
    required void Function() onTap,
  }) {
    return InkWell(
      focusColor: AppColors.transparent,
      hoverColor: AppColors.transparent,
      splashColor: AppColors.transparent,
      highlightColor: AppColors.transparent,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
          ),
          Text(
            title.tr,
            textAlign: TextAlign.center,
            style: Get.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
