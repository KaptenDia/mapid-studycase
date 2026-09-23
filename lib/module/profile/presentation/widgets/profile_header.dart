import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mapid/shared/themes/app_colors.dart';
import 'package:mapid/shared/themes/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String levelLabel;
  final String? photoUrl;
  final VoidCallback? onChangePhoto;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.levelLabel,
    this.photoUrl,
    this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 110.w,
              height: 110.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundField,
                border: Border.all(color: Colors.white, width: 4.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
                image: photoUrl != null
                    ? DecorationImage(
                        image: NetworkImage(photoUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: photoUrl == null
                  ? Icon(
                      Icons.person,
                      size: 56.sp,
                      color: AppColors.textSecondary,
                    )
                  : null,
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          name,
          style: AppTextStyle.title1.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.textSecondary.withAlpha(40),
              width: 1.5.w,
            ),
            color: AppColors.primaryColor.withAlpha(20),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.stars_rounded,
                size: 14.sp,
                color: const Color(0xffF5A623),
              ),
              SizedBox(width: 4.w),
              Text(
                levelLabel,
                style: AppTextStyle.caption.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
