class DeleteResponse {
  final String? id;
  final String deletedAt;

  DeleteResponse({this.id, required this.deletedAt});

  factory DeleteResponse.fromJson(Map<String, dynamic> json) {
    return DeleteResponse(
      id: json['productId'] ?? json['noticeId'] ?? json['orderId'],
      deletedAt: json['deletedAt'],
    );
  }
}

class TimestampResponse {
  final int value;
  final String? unit;

  TimestampResponse({required this.value, this.unit});

  factory TimestampResponse.fromJson(Map<String, dynamic> json, String key) {
    return TimestampResponse(value: json[key], unit: json['unit']);
  }
}
