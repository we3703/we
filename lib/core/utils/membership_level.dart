import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';

enum MembershipLevel { bronze, silver, gold, diamond, master, none }

extension MembershipLevelExtension on MembershipLevel {
  Color get color {
    switch (this) {
      case MembershipLevel.bronze:
        return AppColors.bronze;
      case MembershipLevel.silver:
        return AppColors.silver;
      case MembershipLevel.gold:
        return AppColors.gold;
      case MembershipLevel.diamond:
        return AppColors.diamond;
      case MembershipLevel.master:
        return AppColors.master;
      case MembershipLevel.none:
        return AppColors.textDisabled; // Default for no level
    }
  }

  String get displayName {
    switch (this) {
      case MembershipLevel.bronze:
        return 'Bronze';
      case MembershipLevel.silver:
        return 'Silver';
      case MembershipLevel.gold:
        return 'Gold';
      case MembershipLevel.diamond:
        return 'Diamond';
      case MembershipLevel.master:
        return 'Master';
      case MembershipLevel.none:
        return 'Member';
    }
  }
}

class MembershipConvert {
  static MembershipLevel convertLevel(String level) {
    switch (level.toLowerCase()) {
      case 'master':
        return MembershipLevel.master;
      case 'diamond':
        return MembershipLevel.diamond;
      case 'gold':
        return MembershipLevel.gold;
      case 'silver':
        return MembershipLevel.silver;
      default:
        return MembershipLevel.bronze;
    }
  }
}
