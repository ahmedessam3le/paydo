import 'package:get/get.dart';

import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class TransactionsController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  TransactionsController({
    required this.accountRepository,
    required this.transactionsRepository,
  });
}
