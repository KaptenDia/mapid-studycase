import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseproject_flutter/const/image.dart';
import 'package:baseproject_flutter/shared/themes/app_colors.dart';
import 'package:baseproject_flutter/shared/themes/app_text_style.dart';
import 'package:baseproject_flutter/module/auth/presentation/auth_landing_screen.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/modal/language_modal.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.translation;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final l10nService = context.translation;
                      final selectedCode = await navigator.showModalBottom(
                        content: LanguageModal(
                          selectedCode: l10nService.currentLanguageCode,
                        ),
                      );
                      if (selectedCode != null && selectedCode is String) {
                        await l10nService.setLanguage(selectedCode);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundField,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.primaryColor.withAlpha(50),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.language_rounded,
                            size: 18.sp,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            l10n.currentLanguageCode == 'en' ? 'EN' : 'ID',
                            style: AppTextStyle.caption.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Image.asset(AppImage.onboarding1.value),
              SizedBox(height: 40.h),
              Text(
                l10n.t('onboarding.title'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                l10n.t('onboarding.description'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    navigator.pushReplacement(const AuthLandingScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    l10n.t('onboarding.nextStep'),
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
