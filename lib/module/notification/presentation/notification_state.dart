import 'package:flutter/material.dart';

enum NotificationFilter { all, system, promos, updates }

enum NotificationType { system, promo, security, update }

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timeAgo;
  final NotificationType type;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.type,
    this.isRead = false,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      id: id,
      title: title,
      message: message,
      timeAgo: timeAgo,
      type: type,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationState {
  final NotificationFilter activeFilter;
  final List<NotificationItem> notifications;

  const NotificationState({
    this.activeFilter = NotificationFilter.all,
    this.notifications = const [],
  });

  NotificationState copyWith({
    NotificationFilter? activeFilter,
    List<NotificationItem>? notifications,
  }) {
    return NotificationState(
      activeFilter: activeFilter ?? this.activeFilter,
      notifications: notifications ?? this.notifications,
    );
  }

  List<NotificationItem> get filtered {
    switch (activeFilter) {
      case NotificationFilter.all:
        return notifications;
      case NotificationFilter.system:
        return notifications
            .where((n) => n.type == NotificationType.system)
            .toList();
      case NotificationFilter.promos:
        return notifications
            .where((n) => n.type == NotificationType.promo)
            .toList();
      case NotificationFilter.updates:
        return notifications
            .where(
              (n) =>
                  n.type == NotificationType.security ||
                  n.type == NotificationType.update,
            )
            .toList();
    }
  }

  bool get hasUnread => notifications.any((n) => !n.isRead);

  // Icon & color per type
  static IconData iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return Icons.info_outline_rounded;
      case NotificationType.promo:
        return Icons.local_offer_rounded;
      case NotificationType.security:
        return Icons.shield_outlined;
      case NotificationType.update:
        return Icons.system_update_rounded;
    }
  }

  static Color bgColorFor(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return const Color(0xFFEEF2FF);
      case NotificationType.promo:
        return const Color(0xFFFFEEEE);
      case NotificationType.security:
        return const Color(0xFFE8F5E9);
      case NotificationType.update:
        return const Color(0xFFF3E5F5);
    }
  }

  static Color iconColorFor(NotificationType type) {
    switch (type) {
      case NotificationType.system:
        return const Color(0xFF4A6CF7);
      case NotificationType.promo:
        return const Color(0xFFE84040);
      case NotificationType.security:
        return const Color(0xFF2E7D32);
      case NotificationType.update:
        return const Color(0xFF7B1FA2);
    }
  }
}
