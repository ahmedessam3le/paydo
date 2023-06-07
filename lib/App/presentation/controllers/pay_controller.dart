import 'package:get/get.dart';

import '../../domain/repositories/account_repository.dart';
import '../../domain/repositories/transactions_repository.dart';

class PayController extends GetxController {
  final AccountRepository accountRepository;
  final TransactionsRepository transactionsRepository;

  PayController({
    required this.accountRepository,
    required this.transactionsRepository,
  });
}
