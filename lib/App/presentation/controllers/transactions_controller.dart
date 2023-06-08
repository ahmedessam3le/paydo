import 'package:get/get.dart';

import '../../../core/enums/transaction_enum.dart';
import '../../../core/enums/view_state_enum.dart';
import '../../../core/utils/app_router.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class TransactionsController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  TransactionsController({
    required this.accountRepository,
    required this.transactionsRepository,
  });

  Account? account;

  List<Transaction> transactions = [];

  ViewStateEnum _viewState = ViewStateEnum.loaded;

  ViewStateEnum get viewState => _viewState;

  set viewState(ViewStateEnum value) {
    _viewState = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    viewState = ViewStateEnum.loading;
    await Future.wait([
      getAccountData(),
      getTransactions(),
    ]);
    if (account == null) {
      viewState = ViewStateEnum.error;
    } else {
      viewState = ViewStateEnum.loaded;
    }
  }

  Future<void> getAccountData() async {
    account = await accountRepository.getAccountData();
  }

  Future<void> getTransactions() async {
    transactions = await transactionsRepository.getTransactions();
  }

  void navigateToPay(TransactionEnum type) async {
    final response = await Get.toNamed(AppRoutes.payRoute, arguments: type);
    if (response == ViewStateEnum.refresh) {
      onInit();
    }
  }

  void onPayTap() => navigateToPay(TransactionEnum.pay);

  void onTopUpTap() => navigateToPay(TransactionEnum.topUp);

  void navigateToTransactionDetails(String? id) async {
    final response =
        await Get.toNamed(AppRoutes.transactionDetailsRoute, arguments: id);
    if (response == ViewStateEnum.refresh) {
      onInit();
    }
  }

  void clearTransactions() async {
    await transactionsRepository.clearTransactions();
    // onInit();
  }
}
