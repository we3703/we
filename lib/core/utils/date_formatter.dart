/// Format date string to yyyy.MM.dd format
String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return '';
  }

  try {
    // Parse ISO 8601 date string (e.g., "2024-01-15T10:30:00Z" or "2024-01-15")
    final date = DateTime.parse(dateString);

    // Format as yyyy.MM.dd
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year.$month.$day';
  } catch (e) {
    // If parsing fails, return the original string
    return dateString;
  }
}

/// Format date string to yyyy.MM.dd HH:mm format
String formatDateTime(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return '';
  }

  try {
    final date = DateTime.parse(dateString);

    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return '$year.$month.$day $hour:$minute';
  } catch (e) {
    return dateString;
  }
}
