class PaginatedResponse<T> {
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final List<T> items;
  final int? totalAmount; // Optional, for admin orders

  PaginatedResponse({
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.items,
    this.totalAmount,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    String itemsKey,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    var itemList = json[itemsKey] as List? ?? [];
    List<T> items = itemList.map((i) => fromJsonT(i)).toList();

    return PaginatedResponse<T>(
      totalCount: json['total_count'] ?? json['totalCount'] ?? 0,
      currentPage: json['current_page'] ?? json['currentPage'] ?? 1,
      totalPages: json['total_pages'] ?? json['totalPages'] ?? 0,
      items: items,
      totalAmount: json['total_amount'] ?? json['totalAmount'],
    );
  }
}
