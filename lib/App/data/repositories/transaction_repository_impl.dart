import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:paydo/App/domain/entities/account.dart';
import 'package:paydo/App/domain/entities/transaction.dart';

import '../../domain/repositories/transactions_repository.dart';
import '../data_sources/local_data_source.dart';
import '../models/transaction_model.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final LocalDataSource localDataSource;

  TransactionsRepositoryImpl({required this.localDataSource});

  @override
  Future<TransactionModel> getTransactionById(String transactionId) async {
    late final TransactionModel transaction;
    try {
      final List<TransactionModel> transactions = await getTransactions();
      transaction = transactions
          .firstWhereOrNull(((element) => element.id == transactionId))!;
    } catch (error) {
      log('---------------------------- getTransactionById ERROR ----------------------------\n${error.toString()}');
    }
    return transaction;
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    late final List<TransactionModel> transactions;
    try {
      final String? storedTransactions =
          await localDataSource.getTransactions();
      if (storedTransactions != null) {
        transactions = (jsonDecode(storedTransactions) as List)
            .map((e) => TransactionModel.fromJson(e))
            .toList();
        transactions.sort(
            (first, second) => second.createdAt!.compareTo(first.createdAt!));
      }
    } catch (error) {
      log('---------------------------- getTransactions ERROR ----------------------------\n${error.toString()}');
    }
    return transactions;
  }

  @override
  Future<bool> pay({
    required Account account,
    required Transaction transaction,
  }) async {
    try {
      final List<TransactionModel> transactions = await getTransactions();
      transactions.add(transaction as TransactionModel);
      List<Map<String, dynamic>> storedTransactions = [];
      for (var element in transactions) {
        storedTransactions.add(element.toJson());
      }
      await Future.wait(
        [
          localDataSource.setTransactions(jsonEncode(storedTransactions)),
          // localDataSource.setAccount(jsonEncode(account.toJson())),
        ],
      );
      return true;
    } catch (error) {
      log('---------------------------- pay ERROR ----------------------------\n${error.toString()}');
      return false;
    }
  }

  @override
  Future<bool> repeatPayment({
    required Account account,
    required Transaction firstTransaction,
    required Transaction secondTransaction,
  }) async {
    try {
      final List<TransactionModel> transactions = await getTransactions();
      transactions
          .removeWhere(((element) => element.id == firstTransaction.id));
      transactions.add(firstTransaction as TransactionModel);
      transactions.add(secondTransaction as TransactionModel);
      List<Map<String, dynamic>> storedTransactions = [];
      for (var element in transactions) {
        storedTransactions.add(element.toJson());
        await Future.wait(
          [
            localDataSource.setTransactions(jsonEncode(storedTransactions)),
            // localDataSource.setAccount(jsonEncode(account.toJson())),
          ],
        );
      }
      return true;
    } catch (error) {
      log('---------------------------- repeatPayment ERROR ----------------------------\n${error.toString()}');
      return false;
    }
  }

  @override
  Future<bool> splitPayment({
    required Account account,
    required Transaction firstTransaction,
    required Transaction secondTransaction,
  }) async {
    try {
      final List<TransactionModel> transactions = await getTransactions();
      transactions
          .removeWhere(((element) => element.id == firstTransaction.id));
      transactions.add(firstTransaction as TransactionModel);
      transactions.add(secondTransaction as TransactionModel);
      List<Map<String, dynamic>> storedTransactions = [];
      for (var element in transactions) {
        storedTransactions.add(element.toJson());
        await Future.wait(
          [
            localDataSource.setTransactions(jsonEncode(storedTransactions)),
            // localDataSource.setAccount(jsonEncode(account.toJson())),
          ],
        );
      }
      return true;
    } catch (error) {
      log('---------------------------- splitPayment ERROR ----------------------------\n${error.toString()}');
      return false;
    }
  }

  @override
  Future<void> clearTransactions() async {
    try {
      return await localDataSource.clearTransactions();
    } catch (error) {
      log('---------------------------- clearTransactions ERROR ----------------------------\n${error.toString()}');
    }
  }

  @override
  Future<void> clearAppData() async {
    try {
      return await localDataSource.clearAppData();
    } catch (error) {
      log('---------------------------- clearAppData ERROR ----------------------------\n${error.toString()}');
    }
  }
}
