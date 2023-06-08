class Transaction {
  String? id, type, itemId, itemName;
  double? price;
  int? createdAt;
  bool? isRepeated, isSplit;

  Transaction({
    this.id,
    this.type,
    this.itemId,
    this.itemName,
    this.price,
    this.createdAt,
    this.isRepeated,
    this.isSplit,
  });
}
