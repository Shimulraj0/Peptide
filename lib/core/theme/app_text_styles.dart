import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Splash Screen Styles
  static TextStyle splashTitle({Color? color}) => GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textPrimary,
        letterSpacing: 0.5,
      );

  static TextStyle splashTitleBold({Color? color}) => GoogleFonts.montserrat(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.primary,
        letterSpacing: 0.5,
      );

  static TextStyle splashSubtitle = GoogleFonts.montserrat(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 4.0,
  );

  static TextStyle splashBiometricLabel = GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 2.0,
  );

  static TextStyle onboardingHeading = GoogleFonts.montserrat(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.2,
  );

  static TextStyle onboardingBody = GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );
}
