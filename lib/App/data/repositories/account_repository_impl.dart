import 'package:paydo/App/data/data_sources/local_data_source.dart';

import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final LocalDataSource localDataSource;

  AccountRepositoryImpl({required this.localDataSource});
}
