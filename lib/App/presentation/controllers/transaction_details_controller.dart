import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/const/app_values.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/utils/app_utils.dart';
import '../../../core/utils/date_utils.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class TransactionDetailsController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  TransactionDetailsController({
    required this.accountRepository,
    required this.transactionsRepository,
  });

  ViewStateEnum _viewState = ViewStateEnum.loaded;

  ViewStateEnum get viewState => _viewState;

  set viewState(ViewStateEnum value) {
    _viewState = value;
    update();
  }

  ViewStateEnum popResult = ViewStateEnum.none;

  Account? account;

  Transaction? transaction;

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      viewState = ViewStateEnum.loading;
      await Future.wait([
        getAccountData(),
        getTransactionData(),
      ]);
      if (account == null || transaction == null) {
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

  Future<void> getTransactionData() async {
    transaction = await transactionsRepository
        .getTransactionById(Get.arguments as String);
  }

  void repeatingPayment() async {
    if (account!.amount >= transaction!.price!) {
      transaction!.isRepeated = !(transaction!.isRepeated ?? false);
      popResult = ViewStateEnum.refresh;
      account!.amount = account!.amount - transaction!.price!;
      update();
      await transactionsRepository.repeatPayment(
        firstTransaction: transaction!,
        secondTransaction: Transaction(
          id: AppUtils.generateId(),
          itemId: transaction!.itemId,
          itemName: transaction!.itemName,
          price: transaction!.price,
          createdAt:
              DateUtils.getMillisecondsSinceEpochDateTime(DateTime.now())!,
          isRepeated: false,
          type: transaction!.type,
          isSplit: false,
        ),
        account: account!,
      );
    } else {
      toast(AppStrings.somethingWentWrong.tr);
    }
  }

  void splitBill() async {
    if (transaction?.price != null && transaction?.isSplit != null) {
      if (transaction!.isRepeated!) {
        toast(AppStrings.alreadySplitBefore.tr);
      } else {
        final double newPrice = transaction!.price! / 2;
        transaction!.price = newPrice;
        account!.amount = account!.amount + newPrice;
        transaction?.isSplit = true;
        popResult = ViewStateEnum.refresh;
        update();
        await transactionsRepository.splitPayment(
          firstTransaction: transaction!,
          secondTransaction: Transaction(
            id: AppUtils.generateId(),
            price: newPrice,
            createdAt:
                DateUtils.getMillisecondsSinceEpochDateTime(DateTime.now())!,
            type: AppValues.transactionTopUp,
          ),
          account: account!,
        );
        toast(AppStrings.done.tr);
      }
    } else {
      toast(AppStrings.somethingWentWrong.tr);
    }
  }

  void addReceipt() {}

  void getHelp() => toast(AppStrings.helpIsOnTheWayStayPut.tr);

  Future<bool> onWillPop() async {
    Get.back(result: popResult);
    return false;
  }
}
