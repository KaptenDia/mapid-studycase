import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baseproject_flutter/helper/navigator.dart';
import 'package:baseproject_flutter/module/home/presentation/component_showcase_screen.dart';
import 'package:baseproject_flutter/module/home/presentation/home_bottom_navbar.dart';
import 'package:baseproject_flutter/module/home/presentation/home_provider.dart';
import 'package:baseproject_flutter/module/notification/presentation/notification_provider.dart';
import 'package:baseproject_flutter/module/notification/presentation/notification_screen.dart';
import 'package:baseproject_flutter/module/profile/presentation/profile_screen.dart';
import 'package:baseproject_flutter/shared/themes/app_colors.dart';
import 'package:baseproject_flutter/shared/themes/app_text_style.dart';
import 'package:baseproject_flutter/shared/translation/translation_provider.dart';
import 'package:baseproject_flutter/shared/widget/custom_appbar.dart';
import 'package:baseproject_flutter/shared/widget/toast.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const List<Widget> _pages = [
    _HomeBody(),
    ComponentShowcaseScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavIndexProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Home Body (Dashboard)
// ─────────────────────────────────────────────────────────
class _HomeBody extends ConsumerWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.translation;
    final hasUnreadNotification = ref.watch(
      notificationProvider.select((state) => state.hasUnread),
    );

    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            showBottomDivider: true,
            action: GestureDetector(
              onTap: () => navigator.push(const NotificationScreen()),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 24.sp,
                    color: AppColors.textPrimary,
                  ),
                  if (hasUnreadNotification)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              children: [
                // Welcome Card Banner
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0052D0), Color(0xFF1E88E5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0052D0).withValues(alpha: 0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              'BASE PROJECT',
                              style: AppTextStyle.tiny.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.auto_awesome_rounded,
                            color: Colors.amberAccent,
                            size: 20.sp,
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        l10n.t('home.welcomeTitle'),
                        style: AppTextStyle.title2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        l10n.t('home.welcomeSubtitle'),
                        style: AppTextStyle.caption.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Metrics / Overview Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        title: 'Features',
                        value: '12+',
                        icon: Icons.layers_rounded,
                        color: const Color(0xFF0052D0),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'State Engine',
                        value: 'Riverpod',
                        icon: Icons.bolt_rounded,
                        color: Colors.amber[800]!,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildMetricCard(
                        title: 'DI Engine',
                        value: 'Injectable',
                        icon: Icons.hub_rounded,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Quick Actions
                Text(
                  l10n.t('home.quickActions'),
                  style: AppTextStyle.subtitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildQuickAction(
                      icon: Icons.palette_outlined,
                      label: 'Showcase',
                      onTap: () =>
                          ref.read(homeNavIndexProvider.notifier).setIndex(1),
                    ),
                    _buildQuickAction(
                      icon: Icons.translate_rounded,
                      label: 'Language',
                      onTap: () =>
                          ref.read(homeNavIndexProvider.notifier).setIndex(3),
                    ),
                    _buildQuickAction(
                      icon: Icons.notifications_active_outlined,
                      label: 'Alerts',
                      onTap: () =>
                          ref.read(homeNavIndexProvider.notifier).setIndex(2),
                    ),
                    _buildQuickAction(
                      icon: Icons.person_outline_rounded,
                      label: 'Profile',
                      onTap: () =>
                          ref.read(homeNavIndexProvider.notifier).setIndex(3),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Recent Highlights / Guidelines
                Text(
                  l10n.t('home.starterGuides'),
                  style: AppTextStyle.subtitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildGuideCard(
                  title: 'Clean Architecture Pattern',
                  description:
                      'Organized into Data, Domain, and Presentation layers for maintainable codebases.',
                  icon: Icons.account_tree_outlined,
                  onTap: () => AppToast.showToast(
                    message: 'Follow the feature-first Clean Architecture pattern!',
                  ),
                ),
                SizedBox(height: 10.h),
                _buildGuideCard(
                  title: 'Production-ready Networking',
                  description:
                      'Dio HTTP client pre-configured with token interceptor, logging, and in-app inspector.',
                  icon: Icons.wifi_tethering_rounded,
                  onTap: () => AppToast.showToast(
                    message: 'Dio & Samseer inspector configured.',
                  ),
                ),
                SizedBox(height: 10.h),
                _buildGuideCard(
                  title: 'Internationalization (i18n)',
                  description:
                      'Switch between English and Indonesian with zero rebuild delay via TranslationService.',
                  icon: Icons.language_rounded,
                  onTap: () => AppToast.showToast(
                    message: 'Language provider ready.',
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 16.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(color: AppColors.borderCard),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: AppColors.primaryColor,
              size: 24.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: AppTextStyle.caption.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderCard),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: AppColors.backgroundMenu,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.body.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.hintTextColor,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
