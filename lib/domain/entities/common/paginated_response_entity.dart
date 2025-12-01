class PaginatedResponseEntity<T> {
  final int totalCount;
  final int currentPage;
  final int totalPages;
  final List<T> items;
  final int? totalAmount;

  PaginatedResponseEntity({
    required this.totalCount,
    required this.currentPage,
    required this.totalPages,
    required this.items,
    this.totalAmount,
  });
}
