import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/style/app_icons.dart';
import '../../../core/utils/transaction_utils.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/responsive_view.dart';
import '../controllers/transaction_details_controller.dart';
import '../widgets/transaction_action_item.dart';
import '../widgets/transaction_header.dart';

class TransactionDetailsView extends GetView<TransactionDetailsController> {
  const TransactionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionDetailsController>(
      autoRemove: false,
      builder: (_) {
        if (controller.viewState == ViewStateEnum.error) {
          return const AppErrorWidget();
        } else if (controller.viewState == ViewStateEnum.loading) {
          return const AppProgress();
        } else {
          return WillPopScope(
            onWillPop: controller.onWillPop,
            child: Scaffold(
              appBar: AppBar(
                leading: AppBackButton(
                  onTap: controller.onWillPop,
                  color: Get.theme.appBarTheme.titleTextStyle?.color,
                ),
                title: Text(
                  AppStrings.appName,
                  style: Get.textTheme.headlineLarge!
                      .copyWith(color: AppColors.white),
                ),
              ),
              body: SingleChildScrollView(
                child: ResponsiveView(
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TransactionHeader(
                          transaction: controller.transaction!,
                        ),
                        TransactionActionItem(
                          icon: AppIcons.icAddReceipt,
                          title: AppStrings.addReceipt,
                          function: controller.addReceipt,
                          margin: const EdgeInsets.only(
                            top: 31,
                            bottom: 57,
                          ),
                        ),
                        _buildHeader(AppStrings.shareTheCost),
                        TransactionActionItem(
                          offstage: TransactionUtils.isTopUp(
                              controller.transaction?.type),
                          icon: AppIcons.icSplitBill,
                          title: AppStrings.splitThisBill,
                          function: controller.splitBill,
                          margin: const EdgeInsets.only(
                            bottom: 31,
                          ),
                        ),
                        _buildHeader(AppStrings.subscription),
                        TransactionActionItem(
                          offstage: TransactionUtils.isTopUp(
                              controller.transaction?.type),
                          switchValue: controller.transaction?.isRepeated,
                          action: TransactionActionEnums.switchAction,
                          title: AppStrings.repeatingPayment,
                          function: controller.repeatingPayment,
                          margin: const EdgeInsets.only(
                            bottom: 57,
                          ),
                        ),
                        TransactionActionItem(
                          title: AppStrings.somethingWrongGetHelp,
                          color: AppColors.red,
                          function: controller.getHelp,
                        ),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader(final String header) {
    return Offstage(
      offstage: TransactionUtils.isTopUp(controller.transaction?.type),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 17,
          bottom: 2,
        ),
        child: Text(
          header.tr.toUpperCase(),
          style: Get.textTheme.titleSmall,
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 48,
          bottom: 12,
        ),
        child: Text(
          _getFooterText(),
          textAlign: TextAlign.center,
          style: Get.textTheme.labelSmall,
        ),
      ),
    );
  }

  String _getFooterText() {
    String res = '';
    if ((controller.transaction?.id ?? '').isNotEmpty) {
      res =
          '$res${AppStrings.transactionID.tr} #${controller.transaction?.id}\n';
    }
    if ((controller.transaction?.itemName ?? '').isNotEmpty) {
      res = '$res${controller.transaction?.itemName}';
    }
    if ((controller.transaction?.itemId ?? '').isNotEmpty &&
        (controller.transaction?.itemName ?? '').isNotEmpty) {
      res = '$res - ';
    }
    if ((controller.transaction?.itemId ?? '').isNotEmpty) {
      res =
          '$res${AppStrings.merchantID.tr} #${controller.transaction?.itemId}';
    }
    return res;
  }
}
