import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle baseTextStyle = const TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.0,
    height: 1.3,
    fontFamily: 'BeVietnamPro',
  );

  static TextStyle superTiny = baseTextStyle.copyWith(fontSize: 9.sp);
  static TextStyle tiny = baseTextStyle.copyWith(fontSize: 10.sp);
  static TextStyle caption = baseTextStyle.copyWith(fontSize: 12.sp);
  static TextStyle body = baseTextStyle.copyWith(fontSize: 14.sp);
  static TextStyle body2 = baseTextStyle.copyWith(fontSize: 16.sp);
  static TextStyle subtitle = baseTextStyle.copyWith(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle title1 = baseTextStyle.copyWith(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle title2 = baseTextStyle.copyWith(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle title3 = baseTextStyle.copyWith(
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle otp = baseTextStyle.copyWith(
    fontSize: 56.sp,
    fontWeight: FontWeight.w600,
  );
  static TextStyle button = baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
  static TextStyle field = baseTextStyle.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle hint = baseTextStyle.copyWith(
    fontSize: 14.sp,
    color: AppColors.hintTextColor,
  );
  static TextStyle appBar = baseTextStyle.copyWith(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );

  // navigation bar
  static TextStyle navBottom = baseTextStyle.copyWith(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
  );
}
