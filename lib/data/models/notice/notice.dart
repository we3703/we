class Notice {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String updatedAt;

  Notice({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] as int? ?? 0,
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      createdAt: (json['created_at'] ?? json['createdAt'])?.toString() ?? '',
      updatedAt: (json['updated_at'] ?? json['updatedAt'])?.toString() ?? '',
    );
  }
}
