import 'package:flutter/material.dart';

/// =======================================================
/// KOSSIPO DESIGN SYSTEM
/// DATE FORMATTER
///
/// Centralise tous les formats de dates utilisés
/// dans l'application.
///
/// Senior Architecture:
/// - Single Responsibility
/// - Reusable
/// - Maintainable
/// - No duplicated formatting logic
/// =======================================================

abstract final class AppDateFormatter {
  AppDateFormatter._();

  // =====================================================
// MONTHS
// =====================================================

  static const List<String> _months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static const List<String> _shortMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  // =====================================================
  // BASIC HELPERS
  // =====================================================

  static String twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  // =====================================================
  // 10/06/2026
  // =====================================================

  static String ddMMyyyy(DateTime date) {
    return "${twoDigits(date.day)}/"
        "${twoDigits(date.month)}/"
        "${date.year}";
  }

  // =====================================================
  // 2026-06-10
  // =====================================================

  static String yyyyMMdd(DateTime date) {
    return "${date.year}-"
        "${twoDigits(date.month)}-"
        "${twoDigits(date.day)}";
  }

  // =====================================================
  // 10 Juin 2026
  // =====================================================

  static String fullDate(DateTime date) {
    return "${date.day} "
        "${_months[date.month - 1]} "
        "${date.year}";
  }

  // =====================================================
  // 10 Jun 2026
  // =====================================================

  static String shortDate(DateTime date) {
    return "${date.day} "
        "${_shortMonths[date.month - 1]} "
        "${date.year}";
  }

  // =====================================================
  // Juin 2026
  // =====================================================

  static String monthYear(DateTime date) {
    return "${_months[date.month - 1]} "
        "${date.year}";
  }

  // =====================================================
  // 14:30
  // =====================================================

  static String hourMinute(DateTime date) {
    return "${twoDigits(date.hour)}:"
        "${twoDigits(date.minute)}";
  }

  // =====================================================
  // 10/06/2026 14:30
  // =====================================================

  static String dateTime(DateTime date) {
    return "${ddMMyyyy(date)} "
        "${hourMinute(date)}";
  }

  // =====================================================
  // TODAY / YESTERDAY
  // =====================================================

  static bool isToday(DateTime date) {
    final now = DateTime.now();

    return now.day == date.day &&
        now.month == date.month &&
        now.year == date.year;
  }

  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(
      const Duration(days: 1),
    );

    return yesterday.day == date.day &&
        yesterday.month == date.month &&
        yesterday.year == date.year;
  }

  // =====================================================
  // SMART DISPLAY
  //
  // Aujourd'hui
  // Hier
  // 10 Juin 2026
  // =====================================================

  static String smart(DateTime date) {
    if (isToday(date)) {
      return "Today";
    }

    if (isYesterday(date)) {
      return "Yesterday";
    }

    return fullDate(date);
  }

  // =====================================================
  // AGE
  //
  // Useful for profile pages
  // =====================================================

  static int age(DateTime birthDate) {
    final now = DateTime.now();

    int age = now.year - birthDate.year;

    if (now.month < birthDate.month ||
        (now.month == birthDate.month &&
            now.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  // =====================================================
  // SAME DAY
  // =====================================================

  static bool isSameDay(
      DateTime first,
      DateTime second,
      ) {
    return first.day == second.day &&
        first.month == second.month &&
        first.year == second.year;
  }

  // =====================================================
  // REMOVE TIME
  // =====================================================

  static DateTime dateOnly(DateTime date) {
    return DateTime(
      date.year,
      date.month,
      date.day,
    );
  }

  // =====================================================
  // MATERIAL DATE PICKER
  // =====================================================

  static DatePickerThemeData theme(BuildContext context) {
    return const DatePickerThemeData();
  }
}