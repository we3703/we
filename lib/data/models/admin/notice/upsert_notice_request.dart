class UpsertNoticeRequest {
  final String title;
  final String content;

  UpsertNoticeRequest({required this.title, required this.content});

  Map<String, dynamic> toJson() {
    return {'title': title, 'content': content};
  }
}
