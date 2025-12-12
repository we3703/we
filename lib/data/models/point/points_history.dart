class PointHistoryItem {
  final String historyId;
  final String type;
  final int amount;
  final int balance;
  final String description;
  final String? orderId;
  final String? fromUserId;
  final String createdAt;

  PointHistoryItem({
    required this.historyId,
    required this.type,
    required this.amount,
    required this.balance,
    required this.description,
    this.orderId,
    this.fromUserId,
    required this.createdAt,
  });

  factory PointHistoryItem.fromJson(Map<String, dynamic> json) {
    return PointHistoryItem(
      historyId: (json['history_id'] ?? json['historyId'])?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      amount: json['amount'] as int? ?? 0,
      balance: json['balance'] as int? ?? 0,
      description: json['description']?.toString() ?? '',
      orderId: (json['order_id'] ?? json['orderId'])?.toString(),
      fromUserId: (json['from_user_id'] ?? json['fromUserId'])?.toString(),
      createdAt: (json['created_at'] ?? json['createdAt'])?.toString() ?? '',
    );
  }
}

class PointsHistory {
  final int currentPoints;
  final int totalCharged;
  final int totalUsed;
  final int totalCommission;
  final List<PointHistoryItem> history;

  PointsHistory({
    required this.currentPoints,
    required this.totalCharged,
    required this.totalUsed,
    required this.totalCommission,
    required this.history,
  });

  factory PointsHistory.fromJson(Map<String, dynamic> json) {
    var historyList = json['history'] as List? ?? [];
    List<PointHistoryItem> history = historyList
        .map((i) => PointHistoryItem.fromJson(i as Map<String, dynamic>))
        .toList();
    return PointsHistory(
      currentPoints: (json['current_points'] ?? json['currentPoints']) as int? ?? 0,
      totalCharged: (json['total_charged'] ?? json['totalCharged']) as int? ?? 0,
      totalUsed: (json['total_used'] ?? json['totalUsed']) as int? ?? 0,
      totalCommission: (json['total_commission'] ?? json['totalCommission']) as int? ?? 0,
      history: history,
    );
  }
}
