import 'package:flutter/material.dart';

import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/helper/validator_helper.dart';
import 'package:baseproject_flutter/module/auth/presentation/otp_screen.dart';
import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';
import 'package:baseproject_flutter/shared/widget/form/custom_form_field.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.translation;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 32.h,
                ),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(maxWidth: 500.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(50),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 8.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.r),
                              topRight: Radius.circular(16.r),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0xFF0D5BDA), Color(0xFF001E62)],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(24).w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: AppLogo(height: 45.h, width: 145.w),
                                ),

                                SizedBox(height: 10.h),

                                Center(
                                  child: Text(
                                    "Enter your email address to receive a password reset link.",
                                    textAlign: TextAlign.center,
                                    style: AppTextStyle.body.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 28.h),

                                CustomFormField(
                                  controller: _emailOrPhoneController,
                                  label: l10n.t('login.emailOrPhone'),
                                  hintText: l10n.t('login.emailHint'),
                                  prefixIcon: Icons.person_outline,
                                  validator: emailOrPhoneValidator,
                                ),
                                SizedBox(height: 20.h),
                                CustomButton(
                                  text: 'Send Reset Link',
                                  icon: Icons.arrow_forward_rounded,
                                  showIcon: true,
                                  isSuffixIcon: true,
                                  onPressed: () => navigator.push(OtpScreen()),
                                ),

                                SizedBox(height: 28.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Have another account? ",
                                      style: AppTextStyle.body.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => navigator.pop(),
                                      child: Text(
                                        "Login",
                                        style: AppTextStyle.body.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
