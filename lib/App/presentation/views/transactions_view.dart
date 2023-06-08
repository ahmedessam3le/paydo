import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/date_utils.dart' as du;
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_error_widget.dart';
import '../../../core/widgets/app_progress.dart';
import '../../../core/widgets/responsive_view.dart';
import '../controllers/transactions_controller.dart';
import '../widgets/actions_card_widget.dart';
import '../widgets/credit_widget.dart';
import '../widgets/transaction_item.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsController>(
      autoRemove: false,
      builder: (_) {
        if (controller.viewState == ViewStateEnum.error) {
          return const AppErrorWidget();
        } else if (controller.viewState == ViewStateEnum.loading) {
          return const AppProgress();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.appName,
                style: Get.textTheme.headlineLarge!
                    .copyWith(color: AppColors.white),
              ),
              actions: [
                SmallIconButton(
                  onPressed: controller.clearTransactions,
                  icon: AppUtils.isApple()
                      ? CupertinoIcons.delete
                      : Icons.delete_outline,
                  color: Get.theme.appBarTheme.titleTextStyle?.color,
                  message: AppStrings.clear,
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(250),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _buildBackground(),
                    CreditWidget(
                      price: controller.account?.amount,
                    ),
                    ActionsCardWidget(
                      onTapPay: controller.onPayTap,
                      onTapTopUp: controller.onTopUpTap,
                    ),
                  ],
                ),
              ),
            ),
            body: controller.transactions.isEmpty
                ? const AppErrorWidget(
                    title: AppStrings.youHaveNoTransactions,
                  )
                : ResponsiveView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: controller.transactions.length,
                            itemBuilder: (_, i) {
                              return _buildTransactionItem(i);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        }
      },
    );
  }

  Widget _buildBackground() {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ColoredBox(
              color: Get.theme.primaryColor,
            ),
          ),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ColoredBox(
              color: Get.theme.scaffoldBackgroundColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 20,
      ),
      child: Text(
        AppStrings.recentActivity.tr,
        style: Get.textTheme.labelLarge,
      ),
    );
  }

  Widget _buildTransactionItem(final int i) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Offstage(
          offstage: _checkDateSeparator(i),
          child: _buildDateSeparator(i),
        ),
        TransactionItem(
          transaction: controller.transactions[i],
          onTap: controller.navigateToTransactionDetails,
        ),
        _bottomSeparator(
          i: i,
          j: controller.transactions.length,
        ),
      ],
    );
  }

  Widget _buildDateSeparator(final int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 20,
      ),
      child: Text(
        du.DateUtils.getDateYT(controller.transactions[i].createdAt),
        style: Get.textTheme.labelSmall,
      ),
    );
  }

  bool _checkDateSeparator(final int i) {
    bool hideDate = false;
    if (i != controller.transactions.length &&
        i != 0 &&
        controller.transactions.isNotEmpty) {
      if (du.DateUtils.isTheSameDay(
        firstDate: controller.transactions[i - 1].createdAt,
        secondDate: controller.transactions[i].createdAt,
      )) {
        hideDate = true;
      }
    }
    return hideDate;
  }

  Widget _bottomSeparator({
    required final int i,
    required final int j,
  }) {
    return Offstage(
      offstage: i + 1 != j,
      child: const SafeArea(
        child: SizedBox(
          height: 8,
        ),
      ),
    );
  }
}
