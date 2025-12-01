class ApiResponse<T> {
  final String status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  /// Generic fromJson
  /// [fromJsonT]는 T를 변환하는 함수
  factory ApiResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    final dataJson = (json['data'] as Map<String, dynamic>?) ?? {};
    return ApiResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: fromJsonT(dataJson),
    );
  }
}