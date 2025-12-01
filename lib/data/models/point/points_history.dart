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
      historyId: json['historyId'],
      type: json['type'],
      amount: json['amount'],
      balance: json['balance'],
      description: json['description'],
      orderId: json['orderId'],
      fromUserId: json['fromUserId'],
      createdAt: json['createdAt'],
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
    var historyList = json['history'] as List;
    List<PointHistoryItem> history = historyList
        .map((i) => PointHistoryItem.fromJson(i))
        .toList();
    return PointsHistory(
      currentPoints: json['currentPoints'],
      totalCharged: json['totalCharged'],
      totalUsed: json['totalUsed'],
      totalCommission: json['totalCommission'],
      history: history,
    );
  }
}
