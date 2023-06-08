import 'package:get/get.dart';
import 'package:paydo/core/const/app_strings.dart';

import '../enums/transaction_enum.dart';
import '../style/app_icons.dart';

class TransactionUtils {
  static bool isTopUp(final String? type) =>
      mapTransactionsEnums[type] == TransactionEnum.topUp;

  static String getTransactionIcon(final String? type) {
    switch (mapTransactionsEnums[type]) {
      case TransactionEnum.pay:
        return AppIcons.icItemPay;
      case TransactionEnum.topUp:
        return AppIcons.icItemTopUp;
      default:
        return '';
    }
  }

  static String getTransactionTitle({
    required final String? type,
    required final String? merchantTitle,
  }) {
    switch (mapTransactionsEnums[type]) {
      case TransactionEnum.topUp:
        return AppStrings.topUp.tr;
      default:
        return merchantTitle ?? '';
    }
  }
}
