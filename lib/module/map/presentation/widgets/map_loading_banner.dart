import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_style.dart';

class MapLoadingBanner extends StatelessWidget {
  final String message;

  const MapLoadingBanner({
    super.key,
    this.message = 'Memuat data layer GEO MAPID...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 16.w,
              height: 16.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(
                  AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              message,
              style: AppTextStyle.caption.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
