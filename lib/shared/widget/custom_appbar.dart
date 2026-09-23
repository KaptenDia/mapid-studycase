import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/shared/themes/app_colors.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? action;
  final bool? showBackButton;

  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;

  final bool showBottomDivider;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.action,
    this.showBackButton = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.showBottomDivider = false,
    this.backgroundColor = AppColors.backgroundPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: (padding as EdgeInsets).left.w,
              right: (padding as EdgeInsets).right.w,
              top: (padding as EdgeInsets).top.h,
              bottom: (padding as EdgeInsets).bottom.h,
            ),
            child: Row(
              mainAxisAlignment: mainAxisAlignment,
              children: [
                Visibility(
                  visible: showBackButton ?? true,
                  child: GestureDetector(
                    onTap: () {
                      navigator.pop();
                    },
                    child:
                        leading ??
                        Icon(
                          Icons.arrow_back,
                          size: 20.w,
                          color: AppColors.textPrimary,
                        ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: title ?? AppLogo(height: 20.h, width: 125.w),
                  ),
                ),

                action ?? SizedBox(width: 32.w),
              ],
            ),
          ),

          if (showBottomDivider)
            Divider(height: 1, color: AppColors.backgroundField),
        ],
      ),
    );
  }
}
