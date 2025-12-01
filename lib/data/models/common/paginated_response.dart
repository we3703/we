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
    var itemList = json[itemsKey] as List;
    List<T> items = itemList.map((i) => fromJsonT(i)).toList();

    return PaginatedResponse<T>(
      totalCount: json['totalCount'],
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      items: items,
      totalAmount: json['totalAmount'],
    );
  }
}
