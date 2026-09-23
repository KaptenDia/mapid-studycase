import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseproject_flutter/shared/themes/app_colors.dart';
import 'package:baseproject_flutter/shared/themes/app_text_style.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';

class LanguageOption {
  final String code;
  final String label;
  final String nativeLabel;
  final String flagEmoji;

  const LanguageOption({
    required this.code,
    required this.label,
    required this.nativeLabel,
    required this.flagEmoji,
  });
}

const _languageOptions = [
  LanguageOption(
    code: 'en',
    label: 'English',
    nativeLabel: 'English (US)',
    flagEmoji: '🇺🇸',
  ),
  LanguageOption(
    code: 'id',
    label: 'Bahasa Indonesia',
    nativeLabel: 'Bahasa Indonesia',
    flagEmoji: '🇮🇩',
  ),
];

class LanguageModal extends StatefulWidget {
  final String selectedCode;

  const LanguageModal({super.key, this.selectedCode = 'en'});

  @override
  State<LanguageModal> createState() => _LanguageModalState();
}

class _LanguageModalState extends State<LanguageModal> {
  late String _selected = widget.selectedCode;

  @override
  Widget build(BuildContext context) {
    final translation = context.translation;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.textSecondary.withAlpha(60),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.language_rounded,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translation.t('profile.selectLanguage'),
                      style: AppTextStyle.title2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      translation.t('profile.chooseLanguage'),
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          ..._languageOptions.map((option) {
            final isSelected = option.code == _selected;
            return Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: _LanguageOptionTile(
                option: option,
                isSelected: isSelected,
                onTap: () => setState(() => _selected = option.code),
              ),
            );
          }),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: CustomButton(
              text: translation.t('common.apply'),
              onPressed: () => Navigator.pop(context, _selected),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final LanguageOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOptionTile({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor.withAlpha(15) : Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.textSecondary.withAlpha(30),
          width: isSelected ? 1.6.w : 1.w,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            child: Row(
              children: [
                Text(option.flagEmoji, style: TextStyle(fontSize: 26.sp)),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.label,
                        style: AppTextStyle.body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        option.nativeLabel,
                        style: AppTextStyle.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 22.w,
                  height: 22.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textSecondary.withAlpha(80),
                      width: 1.8.w,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check_rounded,
                          size: 14.sp,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
