import 'package:flutter/material.dart';

class AppColors {
  // Primary — Indigo
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primarySurface = Color(0xFFEEF2FF);
  static const Color primaryBorder = Color(0xFFC7D2FE);

  // Deep Indigo (for headers, gradients)
  static const Color navy = Color(0xFF312E81);
  static const Color navyLight = Color(0xFF3730A3);

  // Semantic
  static const Color green = Color(0xFF10B981);
  static const Color greenSurface = Color(0xFFECFDF5);
  static const Color amber = Color(0xFFF59E0B);
  static const Color amberSurface = Color(0xFFFFFBEB);
  static const Color red = Color(0xFFEF4444);
  static const Color redSurface = Color(0xFFFEF2F2);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color violetSurface = Color(0xFFF5F3FF);

  // Neutral
  static const Color ink = Color(0xFF0F172A);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color line = Color(0xFFE2E8F0);
  static const Color line2 = Color(0xFFF1F5F9);
  static const Color bg = Color(0xFFF8FAFC);
  static const Color white = Color(0xFFFFFFFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
    colors: [Color(0xFF4F46E5), Color(0xFF6366F1), Color(0xFF7C3AED)],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0],
    colors: [Color(0xFF312E81), Color(0xFF3730A3)],
  );

  // Shadows
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x10000000),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 12,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];
  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x506366F1),
      blurRadius: 28,
      spreadRadius: 0,
      offset: Offset(0, 12),
    ),
  ];

  // Tone map for FeatureIcon
  static Map<String, List<Color>> tones = {
    'blue': [primarySurface, primary],
    'green': [greenSurface, green],
    'amber': [amberSurface, amber],
    'red': [redSurface, red],
    'violet': [violetSurface, violet],
    'slate': [bg, slate600],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;
}
