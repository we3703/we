import 'point_history_item_entity.dart';

class PointsHistoryEntity {
  final int currentPoints;
  final int totalCharged;
  final int totalUsed;
  final int totalCommission;
  final List<PointHistoryItemEntity> history;

  PointsHistoryEntity({
    required this.currentPoints,
    required this.totalCharged,
    required this.totalUsed,
    required this.totalCommission,
    required this.history,
  });
}
