import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/helper/validator_helper.dart';
import 'package:baseproject_flutter/module/auth/presentation/forgot_password_screen.dart';
import 'package:baseproject_flutter/module/home/presentation/home_screen.dart';
import 'package:baseproject_flutter/module/login/domain/login_state.dart';
import 'package:baseproject_flutter/module/login/presentation/login_provider.dart';
import 'package:baseproject_flutter/module/register/presentation/register_screen.dart';
import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';
import 'package:baseproject_flutter/shared/widget/form/custom_form_field.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _referralController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      loginProvider.select((value) => value.isLoading),
    );
    final errorMessage = ref.watch(
      loginProvider.select((value) => value.errorMessage),
    );
    final l10n = context.translation;

    ref.listen<LoginState>(loginProvider, (previous, next) {
      if (next.isLoginSuccess) {
        navigator.pushAndRemoveUntil(const HomeScreen());
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Container(
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
                            l10n.t('login.welcome'),
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),
                        CustomFormField(
                          controller: _emailController,
                          label: l10n.t('login.emailOrPhone'),
                          hintText: l10n.t('login.emailHint'),
                          prefixIcon: Icons.person_outline,
                          validator: emailOrPhoneValidator,
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.t('login.password'),
                              style: AppTextStyle.caption.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  navigator.push(const ForgotPasswordScreen()),
                              child: Text(
                                l10n.t('login.forgotPassword'),
                                style: AppTextStyle.caption.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomFormField(
                          controller: _passwordController,
                          hintText: l10n.t('login.passwordHint'),
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          validator: requiredValidator,
                        ),
                        if (errorMessage.isNotEmpty) ...[
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFF0F0),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: const Color(0xffFFB4B4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.error_outline_rounded,
                                  color: AppColors.errorFieldColor,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    errorMessage,
                                    style: AppTextStyle.body.copyWith(
                                      color: AppColors.errorFieldColor,
                                      fontSize: 13.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        SizedBox(height: 20.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withAlpha(20),
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.primaryColor.withAlpha(50),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.card_giftcard_rounded,
                                    size: 18.sp,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    l10n.t('login.referralCode'),
                                    style: AppTextStyle.caption.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: AppColors.primaryColor.withAlpha(50),
                                  ),
                                ),
                                child: TextField(
                                  controller: _referralController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: l10n.t('login.referralHint'),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                l10n.t('login.referralTagline'),
                                style: AppTextStyle.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 28.h),
                        CustomButton(
                          text: l10n.t('login.signIn'),
                          icon: Icons.arrow_forward_rounded,
                          showIcon: true,
                          isSuffixIcon: true,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              navigator.push(const HomeScreen());
                            }
                          },
                          isLoading: isLoading,
                          isEnabled: true,
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.textSecondary.withAlpha(50),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Text(
                                l10n.t('login.orContinueWith'),
                                style: AppTextStyle.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.textSecondary.withAlpha(50),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        CustomButton(
                          text: 'Google',
                          icon: Icons.g_mobiledata,
                          showIcon: true,
                          isLeadingIcon: true,
                          buttonType: ButtonType.outline,
                          onPressed: () {},
                        ),
                        SizedBox(height: 28.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.t('login.noAccount'),
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  navigator.push(const RegisterScreen()),
                              child: Text(
                                l10n.t('login.signUpNow'),
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
  }
}
