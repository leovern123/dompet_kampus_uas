import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -0.5,
  );
  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 25,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -0.4,
  );
  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -0.3,
  );
  static TextStyle h4 = GoogleFonts.inter(
    fontSize: 19,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
  );
  static TextStyle titleLg = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -0.2,
  );
  static TextStyle titleMd = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static TextStyle titleSm = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.ink,
  );
  static TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 15.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );
  static TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
    color: AppColors.ink,
  );
  static TextStyle bodySm = GoogleFonts.inter(
    fontSize: 13.5,
    fontWeight: FontWeight.w500,
    color: AppColors.slate500,
  );
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: AppColors.slate400,
  );
  static TextStyle label = GoogleFonts.inter(
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    color: AppColors.slate600,
  );
  static TextStyle balanceLg = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -0.5,
  );
  static TextStyle amountXL = GoogleFonts.inter(
    fontSize: 42,
    fontWeight: FontWeight.w800,
    color: AppColors.ink,
    letterSpacing: -1,
  );
}