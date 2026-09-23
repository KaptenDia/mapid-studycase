import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../config/di/di.dart';
import '../../helper/navigator.dart';

class AppToast {
  static void showToast({
    required String message,
    IconData? icon,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Duration duration = const Duration(seconds: 2),
  }) {
    try {
      final fToast = FToast();
      fToast.init(getIt<AppNavigator>().context);

      final Widget toast = Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.12),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColors.primaryColor, size: 20.sp),
              SizedBox(width: 8.w),
            ],
            Flexible(
              child: Text(
                message,
                style: AppTextStyle.body.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      );

      fToast.showToast(
        child: toast,
        gravity: gravity,
        toastDuration: duration,
      );
    } catch (_) {}
  }
}

Future showToastLoginSuccess() async {
  AppToast.showToast(
    message: 'Login berhasil',
    icon: Icons.check_circle_rounded,
  );
}
