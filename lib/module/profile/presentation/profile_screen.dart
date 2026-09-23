import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapid/module/notification/presentation/notification_screen.dart';
import 'package:mapid/shared/app_info_provider.dart';
import 'package:mapid/shared/themes/app_colors.dart';
import 'package:mapid/shared/themes/app_text_style.dart';
import 'package:mapid/module/login/presentation/login_screen.dart';
import 'package:mapid/helper/navigator.dart';
import 'package:mapid/shared/translation/translation_provider.dart';
import 'package:mapid/shared/widget/custom_appbar.dart';
import 'package:mapid/shared/widget/modal/language_modal.dart';
import 'personal_information_screen.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_tile.dart' show ProfileMenuTile, ProfileMenuGroup;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.translation;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              showBottomDivider: true,
              action: GestureDetector(
                onTap: () => navigator.push(const NotificationScreen()),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 24.sp,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    const Center(
                      child: ProfileHeader(
                        name: 'John Doe',
                        levelLabel: 'Standard Member',
                      ),
                    ),

                    SizedBox(height: 28.h),

                    Text(
                      'ACCOUNT',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ProfileMenuGroup(
                      children: [
                        ProfileMenuTile(
                          icon: Icons.person_outline_rounded,
                          title: l10n.t('profile.account'),
                          onTap: () =>
                              navigator.push(const PersonalInformationScreen()),
                        ),
                        ProfileMenuTile(
                          icon: Icons.notifications_none_rounded,
                          title: 'Notifications',
                          onTap: () =>
                              navigator.push(const NotificationScreen()),
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    Text(
                      'PREFERENCES & SECURITY',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ProfileMenuGroup(
                      children: [
                        ProfileMenuTile(
                          icon: Icons.language_outlined,
                          title: l10n.t('profile.language'),
                          trailingText: l10n.currentLanguageCode == 'en'
                              ? 'English'
                              : 'Bahasa Indonesia',
                          onTap: () async {
                            final l10nService = context.translation;
                            final selectedCode = await navigator
                                .showModalBottom(
                                  content: LanguageModal(
                                    selectedCode:
                                        l10nService.currentLanguageCode,
                                  ),
                                );
                            if (selectedCode != null &&
                                selectedCode is String) {
                              await l10nService.setLanguage(selectedCode);
                            }
                          },
                        ),
                        ProfileMenuTile(
                          icon: Icons.lock_outline_rounded,
                          title: l10n.t('profile.security'),
                          onTap: () {},
                        ),
                        ProfileMenuTile(
                          icon: Icons.help_outline_rounded,
                          title: l10n.t('profile.helpCenter'),
                          onTap: () {},
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    ProfileMenuGroup(
                      children: [
                        ProfileMenuTile(
                          icon: Icons.logout_rounded,
                          title: l10n.t('profile.logout'),
                          iconColor: Colors.red,
                          iconBackgroundColor: Colors.red.withAlpha(26),
                          titleColor: Colors.red,
                          showChevron: false,
                          onTap: () => navigator.showDialog(
                            content: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              title: Text(
                                l10n.t('profile.logout'),
                                style: AppTextStyle.title2.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                l10n.t('profile.logoutConfirm'),
                                style: AppTextStyle.body.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    l10n.t('common.cancel'),
                                    style: AppTextStyle.body.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    navigator.pushAndRemoveUntil(
                                      const LoginScreen(),
                                    );
                                  },
                                  child: Text(
                                    l10n.t('profile.logout'),
                                    style: AppTextStyle.body.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Center(
                      child: Consumer(
                        builder: (context, ref, child) {
                          final appVersion = ref.watch(appVersionLabelProvider);
                          return appVersion.when(
                            data: (version) => Text(
                              version,
                              style: AppTextStyle.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            loading: () => const SizedBox.shrink(),
                            error: (error, stack) => Text(error.toString()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
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
