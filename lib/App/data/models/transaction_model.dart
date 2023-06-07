import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.type,
    required super.itemId,
    required super.itemName,
    required super.price,
    required super.createdAt,
    required super.isRepeated,
    required super.isSplit,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'],
      itemId: json['item_id'],
      itemName: json['item_name'],
      price: json['price'],
      createdAt: json['created_at'],
      isRepeated: json['is_repeated'],
      isSplit: json['is_split'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'item_id': itemId,
      'item_name': itemName,
      'price': price,
      'created_at': createdAt,
      'is_repeated': isRepeated,
      'is_split': isSplit,
    };
  }
}
