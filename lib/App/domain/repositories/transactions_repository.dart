import '../../data/models/account_model.dart';
import '../../data/models/transaction_model.dart';

abstract class TransactionsRepository {
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel> getTransactionById(String transactionId);
  Future<bool> pay({
    required AccountModel account,
    required TransactionModel transaction,
  });
  Future<bool> repeatPayment({
    required AccountModel account,
    required TransactionModel firstTransaction,
    required TransactionModel secondTransaction,
  });
  Future<bool> splitPayment({
    required AccountModel account,
    required TransactionModel firstTransaction,
    required TransactionModel secondTransaction,
  });
  Future<void> clearTransactions();
  Future<void> clearAppData();
}
