import 'package:flutter/material.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';
import 'package:baseproject_flutter/shared/widget/custom_appbar.dart';
import 'package:baseproject_flutter/shared/widget/form/custom_form_field.dart';
import 'package:baseproject_flutter/shared/widget/modal/default_modal.dart';
import 'package:baseproject_flutter/shared/widget/modal/language_modal.dart';
import 'package:baseproject_flutter/shared/widget/modal/success_modal.dart';
import 'package:baseproject_flutter/shared/widget/toast.dart';

class ComponentShowcaseScreen extends StatefulWidget {
  const ComponentShowcaseScreen({super.key});

  @override
  State<ComponentShowcaseScreen> createState() =>
      _ComponentShowcaseScreenState();
}

class _ComponentShowcaseScreenState extends State<ComponentShowcaseScreen> {
  final _textController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoadingButton = false;

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.translation;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: Text(
                'Components Showcase',
                style: AppTextStyle.appBar,
              ),
              showBottomDivider: true,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                children: [
                  _buildSectionHeader(
                    title: 'Buttons (CustomButton)',
                    subtitle: 'Reusable buttons with various styles and states',
                  ),
                  SizedBox(height: 12.h),
                  CustomButton(
                    text: 'Primary Button',
                    icon: Icons.check_circle_outline_rounded,
                    showIcon: true,
                    isLeadingIcon: true,
                    onPressed: () {
                      AppToast.showToast(message: 'Primary Button Clicked!');
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Secondary Button',
                    buttonType: ButtonType.secondary,
                    onPressed: () {
                      AppToast.showToast(message: 'Secondary Button Clicked!');
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Outline Button',
                    buttonType: ButtonType.outline,
                    onPressed: () {
                      AppToast.showToast(message: 'Outline Button Clicked!');
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Text Button',
                    buttonType: ButtonType.text,
                    onPressed: () {
                      AppToast.showToast(message: 'Text Button Clicked!');
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Loading Button',
                    isLoading: _isLoadingButton,
                    onPressed: () async {
                      setState(() => _isLoadingButton = true);
                      await Future.delayed(const Duration(seconds: 2));
                      if (mounted) {
                        setState(() => _isLoadingButton = false);
                        AppToast.showToast(message: 'Loading Completed!');
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Disabled Button',
                    isEnabled: false,
                    onPressed: () {},
                  ),

                  SizedBox(height: 28.h),

                  _buildSectionHeader(
                    title: 'Form Inputs (CustomFormField)',
                    subtitle: 'Inputs with icon, validation, and styling',
                  ),
                  SizedBox(height: 12.h),
                  CustomFormField(
                    controller: _textController,
                    hintText: 'Enter your username or email',
                    prefixIcon: Icons.person_outline_rounded,
                  ),
                  SizedBox(height: 12.h),
                  CustomFormField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                    prefixIcon: Icons.lock_outline_rounded,
                  ),

                  SizedBox(height: 28.h),

                  _buildSectionHeader(
                    title: 'Dialogs & Modals',
                    subtitle: 'Native-feel modals, sheets, and toast notifications',
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Success Modal',
                          buttonType: ButtonType.outline,
                          onPressed: () {
                            showSuccessModal(
                              message: 'Operation completed successfully!',
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Error Modal',
                          buttonType: ButtonType.outline,
                          onPressed: () {
                            showDefaultModal(
                              message: 'Something went wrong. Please try again.',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Language Modal',
                          buttonType: ButtonType.secondary,
                          onPressed: () async {
                            final l10nService = context.translation;
                            final selected = await navigator.showModalBottom(
                              content: LanguageModal(
                                selectedCode: l10nService.currentLanguageCode,
                              ),
                            );
                            if (selected != null && selected is String) {
                              await l10nService.setLanguage(selected);
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Loading Dialog',
                          buttonType: ButtonType.secondary,
                          onPressed: () async {
                            navigator.showLoadingDialog();
                            await Future.delayed(const Duration(seconds: 2));
                            navigator.pop();
                            AppToast.showToast(message: 'Finished Loading!');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'Show AppToast',
                    onPressed: () {
                      AppToast.showToast(
                        message: 'This is a clean custom toast message.',
                      );
                    },
                  ),

                  SizedBox(height: 28.h),

                  _buildSectionHeader(
                    title: 'Design System Tokens',
                    subtitle: 'Primary, Secondary, Backgrounds, and Typography',
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.borderCard),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Locale: ${l10n.currentLanguageCode.toUpperCase()}',
                          style: AppTextStyle.subtitle,
                        ),
                        SizedBox(height: 8.h),
                        Text('AppColors.primaryColor: #0052D0',
                            style: AppTextStyle.body),
                        Text('AppColors.secondaryColor: #1E88E5',
                            style: AppTextStyle.body),
                        Text('AppColors.backgroundPrimary: #F8F9FF',
                            style: AppTextStyle.body),
                        SizedBox(height: 8.h),
                        Text(
                          'All text styles use BeVietnamPro font family with ScreenUtil responsive scaling.',
                          style: AppTextStyle.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.title2.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          subtitle,
          style: AppTextStyle.caption.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
