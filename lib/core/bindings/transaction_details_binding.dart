import 'package:get/get.dart';

import '../../App/data/data_sources/local_data_source.dart';
import '../../App/data/repositories/account_repository_impl.dart';
import '../../App/data/repositories/transaction_repository_impl.dart';
import '../../App/domain/repositories/account_repository.dart';
import '../../App/domain/repositories/transactions_repository.dart';
import '../../App/presentation/controllers/transaction_details_controller.dart';

class TransactionDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AccountRepository>(
      () => AccountRepositoryImpl(
        localDataSource: Get.find<LocalDataSource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<TransactionsRepository>(
      () => TransactionsRepositoryImpl(
        localDataSource: Get.find<LocalDataSource>(),
      ),
      fenix: true,
    );
    Get.put(
      TransactionDetailsController(
        accountRepository: Get.find<AccountRepository>(),
        transactionsRepository: Get.find<TransactionsRepository>(),
      ),
    );
  }
}
