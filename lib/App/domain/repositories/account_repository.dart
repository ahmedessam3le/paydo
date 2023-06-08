import '../../data/models/account_model.dart';

abstract class AccountRepository {
  Future<AccountModel> createAccount();
  Future<AccountModel> getAccountData();
  Future<void> clearAccountData();
}
