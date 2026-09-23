import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapid/helper/validator_helper.dart';
import 'package:mapid/module/profile/presentation/personal_info_provider.dart';
import 'package:mapid/shared/themes/themes.dart';
import 'package:mapid/shared/widget/button/custom_button.dart';
import 'package:mapid/shared/widget/custom_appbar.dart';
import 'package:mapid/helper/navigator.dart';
import 'package:mapid/shared/widget/form/custom_form_field.dart';

class PersonalInformationScreen extends ConsumerStatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  ConsumerState<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState
    extends ConsumerState<PersonalInformationScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    final personalInfo = ref.read(personalInfoProvider);
    _fullNameController = TextEditingController(text: personalInfo.fullName);
    _emailController = TextEditingController(text: personalInfo.email);
    _phoneNumberController = TextEditingController(
      text: personalInfo.phoneNumber,
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  bool _isFormValid() {
    return _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty;
  }

  void _saveChanges() {
    if (!_isFormValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
      return;
    }

    final personalInfoNotifier = ref.read(personalInfoProvider.notifier);
    final personalInfo = ref.read(personalInfoProvider);

    final updatedInfo = personalInfo.copyWith(
      fullName: _fullNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneNumberController.text,
    );

    personalInfoNotifier.saveChanges(updatedInfo);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Changes saved successfully')));

    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final personalInfo = ref.watch(personalInfoProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: Text('Personal Information', style: AppTextStyle.appBar),
              mainAxisAlignment: MainAxisAlignment.center,
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Photo Section
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.backgroundMenu,
                              border: Border.all(
                                color: AppColors.primaryColor.withAlpha(51),
                                width: 2.w,
                              ),
                            ),
                            child: personalInfo.profilePhotoUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      personalInfo.profilePhotoUrl!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 48.sp,
                                    color: AppColors.primaryColor,
                                  ),
                          ),
                          SizedBox(height: 12.h),
                          GestureDetector(
                            onTap: () {
                              // TODO: Implement photo picker
                            },
                            child: Text(
                              'Change Photo',
                              style: AppTextStyle.body.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),
                    // Full Name Field
                    Text(
                      'Full Name',
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomFormField(
                      hintText: "Enter your full name",
                      controller: _fullNameController,
                      validator: fullNameValidator,
                      type: FormFieldType.outlined,
                    ),
                    SizedBox(height: 20.h),
                    // Email Address Field
                    Text(
                      'Email Address',
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomFormField(
                      hintText: "Enter your email",
                      controller: _emailController,
                      validator: emailValidator,
                      type: FormFieldType.outlined,
                    ),
                    SizedBox(height: 20.h),
                    // Phone Number Field
                    Text(
                      'Phone Number',
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomFormField(
                      hintText: "Enter your phone number",
                      controller: _phoneNumberController,
                      validator: phoneValidator,
                      keyboardType: TextInputType.phone,
                      type: FormFieldType.outlined,
                    ),

                    // // Reset Password Link
                    // GestureDetector(
                    //   onTap: () {
                    //     // TODO: Implement reset password
                    //   },
                    //   child: Text(
                    //     'Reset Password >>',
                    //     style: AppTextStyle.body.copyWith(
                    //       color: AppColors.primaryColor,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 32.h),
                    // Save Changes Button
                    CustomButton(
                      text: "Save Changes",
                      onPressed: _saveChanges,
                      showIcon: true,
                      isLeadingIcon: true,
                      icon: Icons.save,
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
