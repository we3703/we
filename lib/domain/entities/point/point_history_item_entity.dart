class PointHistoryItemEntity {
  final String historyId;
  final String type;
  final int amount;
  final int balance;
  final String description;
  final String? orderId;
  final String? fromUserId;
  final String createdAt;

  PointHistoryItemEntity({
    required this.historyId,
    required this.type,
    required this.amount,
    required this.balance,
    required this.description,
    this.orderId,
    this.fromUserId,
    required this.createdAt,
  });
}
