import 'dart:async';
import 'package:budget_tracker/transaction/Transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> retrieveTransactions();

  Future<Transaction> retrieveTransactionDetails(int transactionId);
}