import 'package:flutter/material.dart';

abstract class AppShadows {
  AppShadows._();

  static List<BoxShadow> get header => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 18,
      offset: const Offset(0, 6),
    ),
  ];

  static List<BoxShadow> get cardSoft => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 14,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get cardStrong => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> bottomNav = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      blurRadius: 25,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> banner = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.12),
      blurRadius: 28,
      spreadRadius: -4,
      offset: Offset(0, 14),
    ),
  ];

}