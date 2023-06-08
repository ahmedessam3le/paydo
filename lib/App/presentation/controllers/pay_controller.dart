import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/enums/pay_enum.dart';
import '../../../core/enums/transaction_enum.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/date_utils.dart' as du;
import '../../data/models/account_model.dart';
import '../../data/models/transaction_model.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class PayController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  PayController({
    required this.accountRepository,
    required this.transactionsRepository,
  });

  ViewStateEnum _viewState = ViewStateEnum.loaded;

  ViewStateEnum get viewState => _viewState;

  set viewState(ViewStateEnum value) {
    _viewState = value;
    update();
  }

  PayEnum _payEnum = PayEnum.payTopUp;

  PayEnum get payEnum => _payEnum;

  set payEnum(PayEnum value) {
    _payEnum = value;
    update();
  }

  ViewStateEnum popResult = ViewStateEnum.none;

  AccountModel? account;

  RxString amount = ''.obs;

  final TextEditingController amountController = TextEditingController();
  TransactionEnum transactionEnum = TransactionEnum.none;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      transactionEnum = Get.arguments as TransactionEnum;
      viewState = ViewStateEnum.loading;
      await getAccountData();
      if (account == null) {
        viewState = ViewStateEnum.error;
      } else {
        viewState = ViewStateEnum.loaded;
      }
    } else {
      viewState = ViewStateEnum.error;
    }
  }

  Future<void> getAccountData() async {
    account = await accountRepository.getAccountData();
  }

  void onNextTap() {
    if (amount.value.isEmpty) {
      toast(AppStrings.somethingWentWrong.tr);
    } else {
      if (transactionEnum == TransactionEnum.pay) {
        if (_checkPayment()) {
          payEnum = PayEnum.payWho;
        } else {
          toast(AppStrings.somethingWentWrong.tr);
        }
      } else {
        doPayment();
      }
    }
  }

  void onPayTap() {
    if (amountController.text.trim().isEmpty) {
      toast(AppStrings.somethingWentWrong.tr);
    } else {
      doPayment();
    }
  }

  bool _checkPayment() {
    final double? v = double.tryParse(amount.value);
    final double? e = account?.amount;
    if (v != null && e != null) {
      return account!.amount >= v && v > 0;
    } else {
      return false;
    }
  }

  void doPayment() async {
    viewState = ViewStateEnum.loading;
    if (transactionEnum == TransactionEnum.topUp) {
      account!.amount = account!.amount + double.parse(amount.value);
    } else {
      account!.amount = account!.amount - double.parse(amount.value);
    }
    final bool response = await transactionsRepository.pay(
      transaction: TransactionModel(
        id: AppUtils.generateId(),
        itemId: AppUtils.clearAndTrim(amountController.text),
        itemName: amountController.text.trim(),
        price: double.tryParse(amount.value),
        createdAt:
            du.DateUtils.getMillisecondsSinceEpochDateTime(DateTime.now()),
        isRepeated: false,
        type: transactionEnum.getName,
        isSplit: false,
      ),
      account: account!,
    );
    viewState = ViewStateEnum.loaded;
    if (response) {
      popResult = ViewStateEnum.refresh;
      toast(AppStrings.done.tr);
    } else {
      toast(AppStrings.somethingWentWrong.tr);
    }
    onWillPop();
  }

  Future<bool> onWillPop() async {
    Get.back(result: popResult);
    return false;
  }
}
