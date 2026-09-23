import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../const/icon.dart';
import '../../const/validation_type.dart';
import '../../helper/validator_helper.dart';
import 'app_colors.dart';
import 'app_text_style.dart';

class FieldDefault extends StatefulWidget {
  final TextEditingController? controller;
  final String? title;
  final String hint;
  final AppIcon icon;
  final bool isPassword;
  final bool isDropdown;
  final ValidationType? validationType;
  final Function(String value, bool isValid) onChanged;
  final Function(int index, String value, dynamic data)? selectedItem;
  final bool readOnly;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextCapitalization? textCapitalization;
  final List<String>? dropdownItems;
  final bool isLoading;
  final Function? onTap;

  const FieldDefault({
    super.key,
    this.controller,
    required this.icon,
    this.title,
    required this.hint,
    required this.onChanged,
    this.selectedItem,
    this.isPassword = false,
    this.isDropdown = false,
    this.validationType,
    this.readOnly = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.dropdownItems,
    this.isLoading = false,
    this.onTap,
  });

  @override
  State<FieldDefault> createState() => _FieldDefaultState();
}

class _FieldDefaultState extends State<FieldDefault> {
  final _controller = TextEditingController();

  String? _errorText;
  bool _isObscure = true;

  bool _isDropdownActive = false;
  List<String> _dropdownItemsFiltered = [];

  void _validate(String value) {
    final validationType = widget.validationType;
    if (validationType != null) {
      setState(() {
        _errorText = validator(value, validationType);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isDropdown) {
      if (widget.controller != null) {
        widget.controller?.addListener(() {
          final formattedValue = widget.controller!.text;
          _validate(formattedValue);
          widget.onChanged(formattedValue, _errorText == null);
        });
      } else {
        _controller.addListener(() {
          final formattedValue = _controller.text;
          _validate(formattedValue);
          widget.onChanged(formattedValue, _errorText == null);
        });
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                widget.title ?? '',
                style: AppTextStyle.caption.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(14.r),
              border: _isDropdownActive
                  ? Border.all(color: AppColors.fieldBorderColor, width: 1.w)
                  : null,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  child: TextField(
                    controller: widget.controller ?? _controller,
                    obscureText: widget.isPassword && _isObscure,
                    style: AppTextStyle.field,
                    autocorrect: false,
                    readOnly: widget.readOnly || widget.isDropdown,
                    textInputAction: widget.textInputAction,
                    keyboardType: widget.textInputType,
                    textCapitalization:
                        widget.textCapitalization ??
                        TextCapitalization.sentences,
                    onChanged: (value) {
                      // when dropdown using listener on init
                      if (!widget.isDropdown) {
                        final formattedValue = value;
                        _validate(formattedValue);
                        widget.onChanged(formattedValue, _errorText == null);
                      }
                    },
                    onTap: () {
                      if (!widget.isLoading) {
                        if (widget.isDropdown) {
                          setState(() {
                            _isDropdownActive = !_isDropdownActive;
                            _dropdownItemsFiltered = widget.dropdownItems ?? [];
                          });
                        } else {
                          widget.onTap?.call();
                        }
                      }
                    },
                    inputFormatters: [
                      if (widget.textInputType == TextInputType.number ||
                          widget.textInputType == TextInputType.phone)
                        FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: AppTextStyle.hint,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 11.h),
                        child: Image.asset(widget.icon.value),
                      ),
                      suffixIcon: widget.isLoading
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                height: 16.w,
                                width: 16.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        AppColors.textPrimary,
                                      ),
                                ),
                              ),
                            )
                          : widget.isPassword
                          ? IconButton(
                              icon: Icon(
                                size: 18.w,
                                _isObscure
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility_rounded,
                                color: AppColors.textPrimary,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )
                          : widget.isDropdown
                          ? Icon(
                              _isDropdownActive
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color: AppColors.textPrimary,
                              size: 18.w,
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.backgroundPrimary,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: _isDropdownActive
                            ? BorderRadius.only(
                                topLeft: Radius.circular(14.r),
                                topRight: Radius.circular(14.r),
                              )
                            : BorderRadius.circular(14.r),
                        borderSide: _isDropdownActive
                            ? const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            : BorderSide(
                                color: _errorText != null
                                    ? AppColors.errorFieldColor
                                    : AppColors.fieldBorderColor,
                                width: 1.w,
                              ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: _isDropdownActive
                            ? BorderRadius.only(
                                topLeft: Radius.circular(14.r),
                                topRight: Radius.circular(14.r),
                              )
                            : BorderRadius.circular(14.r),
                        borderSide: _isDropdownActive
                            ? const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              )
                            : BorderSide(
                                color: _errorText != null
                                    ? AppColors.errorFieldColor
                                    : AppColors.fieldBorderColor,
                                width: 1.w,
                              ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.r),
                        borderSide: BorderSide(
                          color: AppColors.errorFieldColor,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.isDropdown && _isDropdownActive) ...[
                  SizedBox(
                    height: 40.h,
                    child: TextField(
                      style: AppTextStyle.field.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          _dropdownItemsFiltered =
                              widget.dropdownItems
                                  ?.where(
                                    (element) => element.toLowerCase().contains(
                                      value.toLowerCase(),
                                    ),
                                  )
                                  .toList() ??
                              [];
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: AppTextStyle.hint,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(14.r),
                      bottomRight: Radius.circular(14.r),
                    ),
                    child: Container(
                      color: AppColors.backgroundPrimary,
                      height: (_dropdownItemsFiltered.length) > 4
                          ? 160.h
                          : ((_dropdownItemsFiltered.length) * 40).h,
                      child: ListView.separated(
                        itemCount: _dropdownItemsFiltered.length,
                        separatorBuilder: (context, index) => const Divider(
                          height: 0.5,
                          color: AppColors.hintTextColor,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (widget.controller != null) {
                                widget.controller?.text =
                                    _dropdownItemsFiltered[index];
                              } else {
                                _controller.text =
                                    _dropdownItemsFiltered[index];
                              }
                              widget.selectedItem?.call(
                                index,
                                _dropdownItemsFiltered[index],
                                _dropdownItemsFiltered,
                              );
                              _isDropdownActive = false;
                            });
                          },
                          child: Container(
                            color: AppColors.backgroundPrimary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _dropdownItemsFiltered[index],
                              style: AppTextStyle.body,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 10.w),
              child: Text(
                _errorText ?? '',
                style: AppTextStyle.tiny.copyWith(
                  color: AppColors.errorFieldColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

String? validator(String? value, ValidationType validationType) {
  switch (validationType) {
    case ValidationType.required:
      return requiredValidator(value);
    case ValidationType.email:
      return emailValidator(value);
    case ValidationType.password:
      return passwordValidator(value);
    case ValidationType.passwordConfirm:
      return passwordConfirmationValidator(value, 'widget.valuePassword2');
    case ValidationType.phone:
      return phoneValidator(value);
    case ValidationType.lengthMin9Digits:
      return lengthMin9DigitsValidator(value);
    case ValidationType.accountNumber:
      return accountNumberValidator(value);
    case ValidationType.idCard:
      return minimalLengthValidator(value, 16);
    case ValidationType.npwp:
      return minimalLengthValidator(value, 15);
    case ValidationType.linkValidator:
      return linkValidator(value);
    case ValidationType.none:
      return null;
  }
}
