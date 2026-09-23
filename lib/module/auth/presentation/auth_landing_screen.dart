import 'package:flutter/material.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/module/login/presentation/login_screen.dart';
import 'package:baseproject_flutter/module/register/presentation/register_screen.dart';
import 'package:baseproject_flutter/shared/themes/themes.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';
import 'package:baseproject_flutter/shared/widget/logo/app_logo.dart';

class AuthLandingScreen extends StatelessWidget {
  const AuthLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.translation;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),
              // Logo
              const Center(
                child: AppLogo(size: LogoSize.large),
              ),
              const Spacer(),
              // Log In Button
              CustomButton(
                text: l10n.t('auth.login'),
                onPressed: () => navigator.push(const LoginScreen()),
              ),
              SizedBox(height: 12.h),
              CustomButton(
                buttonType: ButtonType.outline,
                text: l10n.t('auth.signup'),
                onPressed: () => navigator.push(const RegisterScreen()),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
