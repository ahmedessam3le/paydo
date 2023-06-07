import 'package:flutter/foundation.dart';

import '../const/app_values.dart';

enum TransactionsEnum {
  pay,
  topUp,
  none,
}

const Map<String, TransactionsEnum> mapTransactionsEnums =
    <String, TransactionsEnum>{
  AppValues.transactionPay: TransactionsEnum.pay,
  AppValues.transactionTopUp: TransactionsEnum.topUp,
};

extension TransactionsEnumsX on TransactionsEnum {
  String get name => describeEnum(this);

  String get getName {
    switch (this) {
      case TransactionsEnum.pay:
        return AppValues.transactionPay;
      case TransactionsEnum.topUp:
        return AppValues.transactionTopUp;
      default:
        return '';
    }
  }
}
