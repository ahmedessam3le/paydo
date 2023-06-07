import 'package:get/get.dart';

import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class TransactionDetailsController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  TransactionDetailsController({
    required this.accountRepository,
    required this.transactionsRepository,
  });
}
