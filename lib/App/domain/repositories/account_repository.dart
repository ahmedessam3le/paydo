import '../entities/account.dart';

abstract class AccountRepository {
  Future<Account> createAccount();
  Future<Account> getAccountData();
  Future<void> clearAccountData();
}
