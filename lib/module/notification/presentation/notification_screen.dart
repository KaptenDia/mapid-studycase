import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mapid/module/notification/presentation/notification_provider.dart';
import 'package:mapid/module/notification/presentation/notification_state.dart';
import 'package:mapid/shared/themes/app_colors.dart';
import 'package:mapid/shared/widget/custom_appbar.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final notifier = ref.read(notificationProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              leading: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: 22.sp,
                  color: AppColors.textPrimary,
                ),
              ),
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              // Mark all as read di action appbar
              action: state.hasUnread
                  ? GestureDetector(
                      onTap: notifier.markAllAsRead,
                      child: Text(
                        'Read all',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : SizedBox(width: 32.w),
              showBottomDivider: true,
            ),
            // Filter chips
            _FilterChips(
              activeFilter: state.activeFilter,
              onFilterChanged: notifier.setFilter,
            ),
            SizedBox(height: 4.h),
            // List
            Expanded(
              child: state.filtered.isEmpty
                  ? _EmptyState(filter: state.activeFilter)
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      itemCount: state.filtered.length,
                      separatorBuilder: (_, __) => Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                        indent: 70.w,
                      ),
                      itemBuilder: (_, i) {
                        final item = state.filtered[i];
                        return _NotificationTile(
                          item: item,
                          onTap: () => notifier.markAsRead(item.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Filter Chips
// ─────────────────────────────────────────────────────────
class _FilterChips extends StatelessWidget {
  final NotificationFilter activeFilter;
  final ValueChanged<NotificationFilter> onFilterChanged;

  const _FilterChips({
    required this.activeFilter,
    required this.onFilterChanged,
  });

  static const _filters = [
    (label: 'All', value: NotificationFilter.all),
    (label: 'System', value: NotificationFilter.system),
    (label: 'Promos', value: NotificationFilter.promos),
    (label: 'Updates', value: NotificationFilter.updates),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundPrimary,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: _filters.map((f) {
          final isActive = f.value == activeFilter;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _FilterChip(
              label: f.label,
              isActive: isActive,
              onTap: () => onFilterChanged(f.value),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
            color: isActive ? Colors.white : Colors.black87,
            fontFamily: DefaultTextStyle.of(context).style.fontFamily,
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Notification Tile
// ─────────────────────────────────────────────────────────
class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback onTap;

  const _NotificationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 46.w,
              height: 46.w,
              decoration: BoxDecoration(
                color: NotificationState.bgColorFor(item.type),
                shape: BoxShape.circle,
              ),
              child: Icon(
                NotificationState.iconFor(item.type),
                color: NotificationState.iconColorFor(item.type),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    item.message,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    item.timeAgo,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            // Unread dot
            if (!item.isRead)
              Container(
                width: 8.w,
                height: 8.w,
                margin: EdgeInsets.only(top: 4.h),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Empty State
// ─────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final NotificationFilter filter;

  const _EmptyState({required this.filter});

  @override
  Widget build(BuildContext context) {
    final label = switch (filter) {
      NotificationFilter.system => 'system notifications',
      NotificationFilter.promos => 'promos',
      NotificationFilter.updates => 'updates',
      _ => 'notifications',
    };

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 52.sp,
            color: Colors.grey[300],
          ),
          SizedBox(height: 12.h),
          Text(
            'No $label yet',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "We'll let you know when something arrives.",
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
