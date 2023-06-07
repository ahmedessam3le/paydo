import 'package:paydo/App/domain/entities/account.dart';
import 'package:paydo/App/domain/entities/transaction.dart';

import '../../domain/repositories/transactions_repository.dart';
import '../data_sources/local_data_source.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final LocalDataSource localDataSource;

  TransactionsRepositoryImpl({required this.localDataSource});

  @override
  Future<Transaction> getTransactionById(String transactionId) {
    // TODO: implement getTransactionById
    throw UnimplementedError();
  }

  @override
  Future<List<Transaction>> getTransactions() {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }

  @override
  Future<bool> pay(
      {required Account account, required Transaction transaction}) {
    // TODO: implement pay
    throw UnimplementedError();
  }

  @override
  Future<bool> repeatPayment(
      {required Account account,
      required Transaction firstTransaction,
      required Transaction secondTransaction}) {
    // TODO: implement repeatPayment
    throw UnimplementedError();
  }

  @override
  Future<bool> splitPay(
      {required Account account,
      required Transaction firstTransaction,
      required Transaction secondTransaction}) {
    // TODO: implement splitPay
    throw UnimplementedError();
  }

  @override
  Future<void> clearTransactions() {
    // TODO: implement clearTransactions
    throw UnimplementedError();
  }

  @override
  Future<void> clearAppData() {
    // TODO: implement clearAppData
    throw UnimplementedError();
  }
}
