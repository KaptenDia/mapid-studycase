// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mapid/shared/widget/button/custom_button.dart';

import '../../../config/di/di.dart';
import '../../../helper/navigator.dart';
import '../../themes/themes.dart';
import '../logo/app_logo.dart';
import 'container_bottom_sheet.dart';

void showDefaultModal({String? message}) =>
    showModalBottomSheet(
      context: getIt<AppNavigator>().context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DefaultModal(message: message),
      ),
    ).then((value) {
      // if (value == 'toLogin') {
      //   getIt<AppNavigator>().showModalBottom(content: const LoginScreen());
      // } else if (value == 'toRegister') {
      //   getIt<AppNavigator>()
      //       .showModalBottom(content: const RegisterVerifyModal());
      // }
    });

class DefaultModal extends StatelessWidget {
  final String? message;
  final String? illustration;

  const DefaultModal({super.key, this.message, this.illustration});

  @override
  Widget build(BuildContext context) {
    return ContainerModalView(
      padding: EdgeInsets.only(left: 16.w, top: 32.h, bottom: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Oops!', style: AppTextStyle.title2),
                    SizedBox(height: 16.h),
                    Text(
                      message ??
                          'Koneksi bermasalah, silahkan ulangi atau coba beberapa saat lagi.',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 1.h),
                child: illustration != null
                    ? Image.asset(illustration!, height: 147.h)
                    : const AppLogo(size: LogoSize.large),
              ),
            ],
          ),
          CustomButton(
            text: 'Tutup',
            onPressed: () => Navigator.pop(context, 'close'),
            margin: EdgeInsets.only(bottom: 8.h, top: 32.h, right: 16.w),
          ),
        ],
      ),
    );
  }
}
