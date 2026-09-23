import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapid/module/home/presentation/home_provider.dart';
import 'package:mapid/shared/themes/app_colors.dart';

class HomeBottomNavBar extends ConsumerWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeNavIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.map_rounded,
                label: 'Peta',
                index: 0,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(homeNavIndexProvider.notifier).setIndex(i),
              ),
              _NavItem(
                icon: Icons.widgets_rounded,
                label: 'Components',
                index: 1,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(homeNavIndexProvider.notifier).setIndex(i),
              ),
              _NavItem(
                icon: Icons.notifications_rounded,
                label: 'Alerts',
                index: 2,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(homeNavIndexProvider.notifier).setIndex(i),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 3,
                currentIndex: currentIndex,
                onTap: (i) =>
                    ref.read(homeNavIndexProvider.notifier).setIndex(i),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == currentIndex;
    const duration = Duration(milliseconds: 280);
    const curve = Curves.easeInOutCubic;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: double.infinity,
        child: Center(
          child: AnimatedContainer(
            duration: duration,
            curve: curve,
            padding: EdgeInsets.symmetric(
              horizontal: isActive ? 14.w : 10.w,
              vertical: 7.h,
            ),
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon: scale saat switch + color berubah
                AnimatedSwitcher(
                  duration: duration,
                  switchInCurve: curve,
                  switchOutCurve: curve,
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    icon,
                    key: ValueKey('${index}_$isActive'),
                    size: isActive ? 18.sp : 22.sp,
                    color: isActive ? Colors.white : Colors.grey[400],
                  ),
                ),
                // Label: expand/collapse dengan AnimatedSize
                AnimatedSize(
                  duration: duration,
                  curve: curve,
                  child: isActive
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 5.w),
                            AnimatedDefaultTextStyle(
                              duration: duration,
                              curve: curve,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: DefaultTextStyle.of(
                                  context,
                                ).style.fontFamily,
                              ),
                              child: Text(label),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
