import 'package:flutter/material.dart';

class AppColors {
  // ===== Colors =====
  static const Color primary = Color(0xFFAA2224);
  static const Color secondary = Color(0xFFDB2D2C);
  static const Color background = Color(0xFFF3F3F3);
  static const Color gray = Color(0xFFDBDBDB);
  static const Color darkGrey = Color(0xFF9CA3AF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFEFEFE);
  static const Color red = Color(0xFFFF383C);
  static const Color orange = Color(0xFFFF8D28);
  static const Color green = Color(0xFF34C759);

  // ===== Gradients =====
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  // ===== Shadows =====
  /// Card / section shadow (soft)
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: black.withValues(alpha: 0.05),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
  ];

  /// Elevated / floating element
  static final List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: black.withValues(alpha: 0.1),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];
}
