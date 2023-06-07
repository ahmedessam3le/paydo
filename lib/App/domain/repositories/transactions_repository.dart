import '../entities/account.dart';
import '../entities/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> getTransactions();
  Future<Transaction> getTransactionById(String transactionId);
  Future<bool> pay({
    required Account account,
    required Transaction transaction,
  });
  Future<bool> repeatPayment({
    required Account account,
    required Transaction firstTransaction,
    required Transaction secondTransaction,
  });
  Future<bool> splitPayment({
    required Account account,
    required Transaction firstTransaction,
    required Transaction secondTransaction,
  });
  Future<void> clearTransactions();
  Future<void> clearAppData();
}
