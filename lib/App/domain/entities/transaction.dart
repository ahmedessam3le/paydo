class Transaction {
  final String id, type, itemId, itemName;
  final double price;
  final int createdAt;
  final bool isRepeated, isSplit;

  Transaction({
    required this.id,
    required this.type,
    required this.itemId,
    required this.itemName,
    required this.price,
    required this.createdAt,
    required this.isRepeated,
    required this.isSplit,
  });
}
