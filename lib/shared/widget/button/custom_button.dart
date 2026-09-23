import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final bool showIcon;
  final double? width;
  final double height;
  final EdgeInsets margin;
  final bool isLeadingIcon;
  final bool isSuffixIcon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonType = ButtonType.primary,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.showIcon = false,
    this.width,
    this.height = 48,
    this.margin = EdgeInsets.zero,
    this.isLeadingIcon = false,
    this.isSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height.h,
      margin: margin,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    switch (buttonType) {
      case ButtonType.primary:
        return _PrimaryButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          showIcon: showIcon,
          isLeadingIcon: isLeadingIcon,
          isSuffixIcon: isSuffixIcon,
        );
      case ButtonType.secondary:
        return _SecondaryButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          showIcon: showIcon,
          isLeadingIcon: isLeadingIcon,
          isSuffixIcon: isSuffixIcon,
        );
      case ButtonType.outline:
        return _OutlineButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          isLoading: isLoading,
          icon: icon,
          showIcon: showIcon,
          isLeadingIcon: isLeadingIcon,
          isSuffixIcon: isSuffixIcon,
        );
      case ButtonType.text:
        return _TextButton(
          text: text,
          onPressed: isEnabled ? onPressed : null,
          isLoading: isLoading,
        );
    }
  }
}

class _PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool showIcon;
  final bool? isLeadingIcon;
  final bool? isSuffixIcon;

  const _PrimaryButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.showIcon = false,
    this.isLeadingIcon = false,
    this.isSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        disabledBackgroundColor: AppColors.buttonDisableColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: 20.w,
        width: 20.w,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
          strokeWidth: 2.w,
        ),
      );
    }

    if (showIcon && icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLeadingIcon == true) ...[
            Icon(icon, size: 20.sp, color: AppColors.white),
            SizedBox(width: 8.w),
          ],
          Text(
            text,
            style: AppTextStyle.button.copyWith(fontWeight: FontWeight.w600),
          ),
          if (isSuffixIcon == true) ...[
            SizedBox(width: 8.w),
            Icon(icon, size: 20.sp, color: AppColors.white),
          ],
        ],
      );
    }

    return Text(
      text,
      style: AppTextStyle.button.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool showIcon;
  final bool? isLeadingIcon;
  final bool? isSuffixIcon;

  const _SecondaryButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.showIcon = false,
    this.isLeadingIcon = false,
    this.isSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        disabledBackgroundColor: AppColors.buttonDisableColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: 20.w,
        width: 20.w,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.white),
          strokeWidth: 2.w,
        ),
      );
    }
    return Text(
      text,
      style: AppTextStyle.button.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool showIcon;
  final bool? isLeadingIcon;
  final bool? isSuffixIcon;

  const _OutlineButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.showIcon = false,
    this.isLeadingIcon = false,
    this.isSuffixIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: 20.w,
        width: 20.w,
        child: CircularProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.primaryColor,
          ),
          strokeWidth: 2.w,
        ),
      );
    }

    return Text(
      text,
      style: AppTextStyle.button.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _TextButton({
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: Text(
        text,
        style: AppTextStyle.body.copyWith(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
