import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_colors.dart';

class ContainerModalView extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final bool showCloseButton;
  final Function()? actionDismiss;

  const ContainerModalView({
    super.key,
    required this.child,
    this.padding,
    this.showCloseButton = true,
    this.actionDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showCloseButton)
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.fromLTRB(0, 24.h, 24.w, 12.h),
              child: CircleAvatar(
                backgroundColor: AppColors.backgroundPrimary,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    actionDismiss?.call();
                  },
                  highlightColor: Colors.white.withAlpha(080),
                  icon: const Icon(Icons.close, color: AppColors.textPrimary),
                ),
              ),
            ),
          Container(
            padding: padding ?? EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
            margin: EdgeInsets.fromLTRB(
              12.w,
              0,
              12.w,
              MediaQuery.of(context).padding.bottom + 12.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
