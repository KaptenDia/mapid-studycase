// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:baseproject_flutter/shared/widget/button/custom_button.dart';

import '../../../config/di/di.dart';
import '../../../helper/navigator.dart';
import '../../themes/themes.dart';
import 'container_bottom_sheet.dart';

void showSuccessModal({String? message}) => showModalBottomSheet(
  context: getIt<AppNavigator>().context,
  isScrollControlled: true,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  ),
  builder: (context) => Padding(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: SuccessModal(message: message),
  ),
);

class SuccessModal extends StatelessWidget {
  final String? message;

  const SuccessModal({super.key, this.message});

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
                    Text('Berhasil!', style: AppTextStyle.title2),
                    SizedBox(height: 16.h),
                    Text(
                      message ?? 'Proses berhasil dilakukan.',
                      style: AppTextStyle.body.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 1.h, right: 16.w),
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 52.sp,
                  ),
                ),
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
