import '../../domain/entities/account.dart';

class AccountModel extends Account {
  AccountModel({required super.amount});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(amount: json['amount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }
}
