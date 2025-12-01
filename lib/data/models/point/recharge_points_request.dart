class RechargePointsRequest {
  final int amount;

  RechargePointsRequest({required this.amount});

  Map<String, dynamic> toJson() {
    return {'amount': amount};
  }
}
