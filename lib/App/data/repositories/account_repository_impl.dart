import 'package:paydo/App/data/data_sources/local_data_source.dart';
import 'package:paydo/App/domain/entities/account.dart';

import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final LocalDataSource localDataSource;

  AccountRepositoryImpl({required this.localDataSource});

  @override
  Future<void> clearAccountData() {
    // TODO: implement clearAccountData
    throw UnimplementedError();
  }

  @override
  Future<Account> createAccount() {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<Account> getAccountData() {
    // TODO: implement getAccountData
    throw UnimplementedError();
  }
}
