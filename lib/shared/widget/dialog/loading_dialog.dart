import 'package:flutter/material.dart';

import '../../themes/themes.dart';

class LoadingDialog extends StatelessWidget {
  final String? keyAction;

  const LoadingDialog({super.key, this.keyAction});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 60.w,
          height: 60.w,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: CircularProgressIndicator(
            strokeWidth: 5.w,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}
