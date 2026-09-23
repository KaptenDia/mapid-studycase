import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/helper/validator_helper.dart';
import 'package:baseproject_flutter/module/auth/presentation/otp_screen.dart';
import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';
import 'package:baseproject_flutter/shared/widget/form/custom_form_field.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';
import '../domain/register_state.dart';
import 'register_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref.read(registerProvider.notifier).setEmail(_emailController.text, true);
    ref
        .read(registerProvider.notifier)
        .setPassword(_passwordController.text, true);
    ref.read(registerProvider.notifier).onPressedRegister();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      registerProvider.select((value) => value.isLoading),
    );
    final errorMessage = ref.watch(
      registerProvider.select((value) => value.errorMessage),
    );
    final l10n = context.translation;

    ref.listen<RegisterState>(registerProvider, (previous, next) {
      if (next.isRegisterSuccess) {
        navigator.push(const OtpScreen());
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
                            l10n.t('register.welcome'),
                            style: AppTextStyle.body.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),
                        CustomFormField(
                          controller: _fullNameController,
                          label: l10n.t('register.fullName'),
                          hintText: l10n.t('register.fullNameHint'),
                          prefixIcon: Icons.person_outline,
                          validator: fullNameValidator,
                        ),
                        SizedBox(height: 18.h),
                        CustomFormField(
                          controller: _emailController,
                          label: l10n.t('register.email'),
                          hintText: l10n.t('register.emailHint'),
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                        ),
                        SizedBox(height: 18.h),
                        CustomFormField(
                          controller: _phoneController,
                          label: l10n.t('register.phoneNumber'),
                          hintText: l10n.t('register.phoneHint'),
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: phoneValidator,
                        ),
                        SizedBox(height: 18.h),
                        CustomFormField(
                          controller: _passwordController,
                          label: l10n.t('register.password'),
                          hintText: l10n.t('register.passwordHint'),
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          validator: passwordValidator,
                        ),
                        SizedBox(height: 18.h),
                        CustomFormField(
                          controller: _confirmPasswordController,
                          label: l10n.t('register.confirmPassword'),
                          hintText: l10n.t('register.confirmPasswordHint'),
                          prefixIcon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) => passwordConfirmationValidator(
                            value,
                            _passwordController.text,
                          ),
                        ),
                        if (errorMessage.isNotEmpty) ...[
                          SizedBox(height: 20.h),
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
                        CustomButton(
                          text: l10n.t('register.createAccount'),
                          icon: Icons.arrow_forward_rounded,
                          showIcon: true,
                          onPressed: _handleRegister,
                          isLoading: isLoading,
                          isEnabled: true,
                        ),
                        SizedBox(height: 20.h),
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
                                l10n.t('register.orContinueWith'),
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
                          text: l10n.t('register.signUpWithGoogle'),
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
                              l10n.t('register.haveAccount'),
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => navigator.pop(),
                              child: Text(
                                l10n.t('register.signIn'),
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
