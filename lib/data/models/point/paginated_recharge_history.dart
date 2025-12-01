import 'package:we/data/models/common/paginated_response.dart';

class RechargeHistoryItem {
  final String rechargeId;
  final int amount;
  final String status;
  final String paymentMethod;
  final String requestedAt;
  final String? approvedAt;

  RechargeHistoryItem({
    required this.rechargeId,
    required this.amount,
    required this.status,
    required this.paymentMethod,
    required this.requestedAt,
    this.approvedAt,
  });

  factory RechargeHistoryItem.fromJson(Map<String, dynamic> json) {
    return RechargeHistoryItem(
      rechargeId: json['rechargeId'],
      amount: json['amount'],
      status: json['status'],
      paymentMethod: json['paymentMethod'],
      requestedAt: json['requestedAt'],
      approvedAt: json['approvedAt'],
    );
  }
}

typedef PaginatedRechargeHistory = PaginatedResponse<RechargeHistoryItem>;

extension PaginatedRechargeHistoryExtension on PaginatedRechargeHistory {
  static PaginatedRechargeHistory fromJson(Map<String, dynamic> json) {
    return PaginatedResponse.fromJson(
      json,
      'items',
      RechargeHistoryItem.fromJson,
    );
  }
}
