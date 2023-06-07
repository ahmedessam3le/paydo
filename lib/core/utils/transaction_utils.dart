import 'package:get/get.dart';
import 'package:paydo/core/const/app_strings.dart';

import '../enums/transaction_enum.dart';
import '../style/app_icons.dart';

class TransactionUtils {
  bool isTopUp(final String? type) =>
      mapTransactionsEnums[type] == TransactionsEnum.topUp;

  String getTransactionIcon(final String? type) {
    switch (mapTransactionsEnums[type]) {
      case TransactionsEnum.pay:
        return AppIcons.icItemPay;
      case TransactionsEnum.topUp:
        return AppIcons.icItemTopUp;
      default:
        return '';
    }
  }

  String getTransactionTitle({
    required final String? type,
    required final String? merchantTitle,
  }) {
    switch (mapTransactionsEnums[type]) {
      case TransactionsEnum.topUp:
        return AppStrings.topUp.tr;
      default:
        return merchantTitle ?? '';
    }
  }
}
