import 'package:flutter/material.dart';
import 'package:lets_chat/utils/colors.dart';

class AppTheme {
  static TextTheme customTextThemeSF = const TextTheme(
    displayLarge: TextStyle(
        fontSize: 22,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.bold,
        color: AppColors.primaryTextColor),
    displayMedium: TextStyle(
        fontSize: 22,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.w600,
        color: AppColors.primaryTextColor),
    displaySmall: TextStyle(
        fontSize: 20,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.w500,
        color: AppColors.primaryTextColor),
    titleLarge: TextStyle(
        fontSize: 18,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.w500,
        color: AppColors.primaryTextColor),
    titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.w400,
        color: AppColors.primaryTextColor),
    titleSmall: TextStyle(
        fontSize: 15,
        fontFamily: 'SF_PRO_DISPLAY_MEDIUM',
        fontWeight: FontWeight.w400,
        color: AppColors.primaryTextColor),
    bodyLarge: TextStyle(
        fontSize: 14,
        fontFamily: 'SF_PRO_DISPLAY_REGULAR',
        fontWeight: FontWeight.w400,
        color: AppColors.primaryTextColor),
    bodyMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'SF_PRO_DISPLAY_REGULAR',
        fontWeight: FontWeight.w500,
        color: AppColors.primaryTextColor),
    bodySmall: TextStyle(
        fontSize: 10,
        fontFamily: 'SF_PRO_DISPLAY_REGULAR',
        fontWeight: FontWeight.w300,
        color: AppColors.primaryTextColor),
  );
}
