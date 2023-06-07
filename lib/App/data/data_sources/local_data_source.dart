import 'package:get_storage/get_storage.dart';

abstract class LocalDataSource {
  Future<void> setAccount(String? account);
  Future<String?> getAccount();
  Future<void> setTransactions(String? transaction);
  Future<String?> getTransactions();
  Future<void> clearAccount();
  Future<void> clearTransactions();
  Future<void> clearData();
}

class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage _box = GetStorage();

  static const String _account = '_account';
  static const String _transactions = '_transactions';

  Future<T> _getValue<T>(final String key) async => await _box.read(key) as T;

  Future<void> _setValue<T>(final String key, final T v) async =>
      await _box.write(key, v);

  @override
  Future<void> setAccount(final String? account) async =>
      await _setValue(_account, account);

  @override
  Future<String?> getAccount() async => await _getValue(_account);

  @override
  Future<void> setTransactions(final String? transaction) async =>
      await _setValue(_transactions, transaction);

  @override
  Future<String?> getTransactions() async => await _getValue(_transactions);

  @override
  Future<void> clearAccount() async {
    await _box.remove(_account);
  }

  @override
  Future<void> clearTransactions() async {
    await _box.remove(_transactions);
  }

  @override
  Future<void> clearData() async {
    await Future.wait([
      _box.remove(_account),
      _box.remove(_transactions),
    ]);
  }
}
