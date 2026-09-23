import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../themes/app_colors.dart';
import '../../themes/app_text_style.dart';

enum FormFieldType { filled, outlined }

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final int? maxLines;
  final bool enabled;
  final FormFieldType type;

  const CustomFormField({
    super.key,
    this.controller,
    this.label,
    required this.hintText,
    this.prefixIcon,
    this.prefixWidget,
    this.obscureText = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.onChanged,
    this.onTap,
    this.inputFormatters,
    this.maxLength,
    this.maxLines,
    this.enabled = true,
    this.type = FormFieldType.filled,
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool _isObscure = true;
  bool _hasFocus = false;
  String? _errorText;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _isObscure = widget.obscureText;

    _focusNode.addListener(() {
      if (mounted) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
        });
      }
    });
  }

  Color get _borderColor {
    if (_errorText != null) {
      return AppColors.errorFieldColor;
    }

    if (_hasFocus) {
      return AppColors.primaryColor;
    }

    if (widget.type == FormFieldType.outlined) {
      return Colors.grey.shade300;
    }

    return Colors.transparent;
  }

  Color get _backgroundColor {
    return widget.type == FormFieldType.filled
        ? AppColors.backgroundField
        : Colors.white;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTextStyle.caption.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        Container(
          decoration: BoxDecoration(
            color: _backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _borderColor, width: 1.5.w),
          ),
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            obscureText: widget.obscureText && _isObscure,
            readOnly: widget.readOnly,
            enabled: widget.enabled,
            maxLines: widget.maxLines ?? 1,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: AppTextStyle.body.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),

            validator: (value) {
              final error = widget.validator?.call(value);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _errorText = error;
                  });
                }
              });

              return null;
            },

            onTap: widget.onTap,

            onChanged: (value) {
              final error = widget.validator?.call(value);

              setState(() {
                _errorText = error;
              });

              widget.onChanged?.call(value);
            },

            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },

            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTextStyle.hint,

              prefixIcon:
                  widget.prefixWidget ??
                  (widget.prefixIcon != null
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: Icon(
                            widget.prefixIcon,
                            size: 20.sp,
                            color: AppColors.textSecondary,
                          ),
                        )
                      : null),

              suffixIcon: widget.obscureText
                  ? IconButton(
                      constraints: BoxConstraints(
                        minWidth: 40.w,
                        minHeight: 40.h,
                      ),
                      padding: EdgeInsets.only(right: 12.w),
                      icon: Icon(
                        _isObscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        size: 20.sp,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    )
                  : null,

              border: InputBorder.none,
              counterText: '',

              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),

        if (_errorText != null) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: Text(
              _errorText!,
              style: AppTextStyle.caption.copyWith(
                color: AppColors.errorFieldColor,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
