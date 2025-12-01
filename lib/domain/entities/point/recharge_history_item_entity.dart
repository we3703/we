class RechargeHistoryItemEntity {
  final String rechargeId;
  final int amount;
  final String status;
  final String paymentMethod;
  final String requestedAt;
  final String? approvedAt;

  RechargeHistoryItemEntity({
    required this.rechargeId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.requestedAt,
    this.approvedAt,
  });
}
