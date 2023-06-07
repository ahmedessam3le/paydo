import '../../domain/repositories/transactions_repository.dart';
import '../data_sources/local_data_source.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final LocalDataSource localDataSource;

  TransactionsRepositoryImpl({required this.localDataSource});
}
