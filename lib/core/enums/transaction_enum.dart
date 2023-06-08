import 'package:flutter/foundation.dart';

import '../const/app_values.dart';

enum TransactionEnum {
  pay,
  topUp,
  none,
}

const Map<String, TransactionEnum> mapTransactionsEnums =
    <String, TransactionEnum>{
  AppValues.transactionPay: TransactionEnum.pay,
  AppValues.transactionTopUp: TransactionEnum.topUp,
};

extension TransactionsEnumsX on TransactionEnum {
  String get name => describeEnum(this);

  String get getName {
    switch (this) {
      case TransactionEnum.pay:
        return AppValues.transactionPay;
      case TransactionEnum.topUp:
        return AppValues.transactionTopUp;
      default:
        return '';
    }
  }
}
