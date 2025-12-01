import 'package:flutter/material.dart';

class AppShadow {
  // Card Shadow: x-2, y-2, spread-10
  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      offset: const Offset(2, 2),
      blurRadius: 10,
      spreadRadius: 0,
    ),
  ];

  // static List<BoxShadow> {name} = [
  //   BoxShadow(
  //     color: Colors.black.withOpacity(0.15),
  //     offset: const Offset(4, 4),
  //     blurRadius: 15,
  //     spreadRadius: 0,
  //   ),
  // ];
}

// decoration: BoxDecoration(
//   color: Colors.white,
//   borderRadius: BorderRadius.circular(12),
//   boxShadow: AppShadow.card,  // ← 이렇게 사용
// ),
