import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapid/shared/themes/app_colors.dart';
import 'package:mapid/shared/themes/app_text_style.dart';

enum LogoSize {
  small,
  medium,
  large,
  xlarge,
}

/// A flexible logo widget that renders either a custom asset image
/// or a clean, modern vector brand badge for any application theme.
class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final LogoSize size;
  final String? assetPath;
  final String? title;
  final bool showText;

  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.size = LogoSize.medium,
    this.assetPath = 'assets/image/app_icon.png',
    this.title = 'MAPID',
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath != null && assetPath!.isNotEmpty) {
      return Image.asset(
        assetPath!,
        width: width ?? _getWidth(),
        height: height ?? _getHeight(),
        fit: BoxFit.contain,
      );
    }

    final double w = width ?? _getWidth();
    final double h = height ?? _getHeight();
    final double iconBoxSize = (h * 0.85).clamp(24.0, 72.0);

    return SizedBox(
      width: w,
      height: h,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.secondaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(iconBoxSize * 0.28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.layers_rounded,
                  color: Colors.white,
                  size: iconBoxSize * 0.55,
                ),
              ),
            ),
            if (showText && title != null && title!.isNotEmpty) ...[
              SizedBox(width: iconBoxSize * 0.3),
              Text(
                title!,
                style: AppTextStyle.title2.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: AppColors.textPrimary,
                  fontSize: (iconBoxSize * 0.42).sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  double _getWidth() {
    switch (size) {
      case LogoSize.small:
        return 90.w;
      case LogoSize.medium:
        return 140.w;
      case LogoSize.large:
        return 200.w;
      case LogoSize.xlarge:
        return 260.w;
    }
  }

  double _getHeight() {
    switch (size) {
      case LogoSize.small:
        return 32.h;
      case LogoSize.medium:
        return 48.h;
      case LogoSize.large:
        return 72.h;
      case LogoSize.xlarge:
        return 96.h;
    }
  }
}
