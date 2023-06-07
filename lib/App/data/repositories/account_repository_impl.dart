import 'dart:convert';
import 'dart:developer';

import 'package:paydo/App/data/data_sources/local_data_source.dart';

import '../../domain/repositories/account_repository.dart';
import '../models/account_model.dart';

class AccountRepositoryImpl implements AccountRepository {
  final LocalDataSource localDataSource;

  AccountRepositoryImpl({required this.localDataSource});

  @override
  Future<void> clearAccountData() async {
    try {
      return await localDataSource.clearAccount();
    } catch (error) {
      log('---------------------------- clearAccountData ERROR ----------------------------\n${error.toString()}');
    }
  }

  @override
  Future<AccountModel> createAccount() async {
    late final AccountModel account;
    try {
      account = AccountModel(amount: 0.0);
      await localDataSource.setAccount(jsonEncode(account.toJson()));
    } catch (error) {
      log('---------------------------- createAccount ERROR ----------------------------\n${error.toString()}');
    }
    return account;
  }

  @override
  Future<AccountModel> getAccountData() async {
    late final AccountModel account;
    try {
      final String? storedAccount = await localDataSource.getAccount();
      if (storedAccount == null) {
        account = await createAccount();
      } else {
        account = AccountModel.fromJson(jsonDecode(storedAccount));
      }
    } catch (error) {
      log('---------------------------- getAccountData ERROR ----------------------------\n${error.toString()}');
    }
    return account;
  }
}
