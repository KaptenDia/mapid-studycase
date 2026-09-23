import 'package:baseproject_flutter/module/notification/presentation/notification_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_provider.g.dart';

@riverpod
class NotificationNotifier extends _$NotificationNotifier {
  @override
  NotificationState build() {
    return NotificationState(notifications: _dummyNotifications);
  }

  void setFilter(NotificationFilter filter) {
    state = state.copyWith(activeFilter: filter);
  }

  void markAllAsRead() {
    final updated = state.notifications
        .map((n) => n.copyWith(isRead: true))
        .toList();
    state = state.copyWith(notifications: updated);
  }

  void markAsRead(String id) {
    final updated = state.notifications.map((n) {
      return n.id == id ? n.copyWith(isRead: true) : n;
    }).toList();
    state = state.copyWith(notifications: updated);
  }
}

const _dummyNotifications = [
  NotificationItem(
    id: '1',
    title: 'Welcome to Base Project',
    message: 'Explore all the customizable components and architectural setup.',
    timeAgo: '5m ago',
    type: NotificationType.system,
    isRead: false,
  ),
  NotificationItem(
    id: '2',
    title: 'New Announcement',
    message: 'New features and components are ready for your project.',
    timeAgo: '30m ago',
    type: NotificationType.promo,
    isRead: true,
  ),
  NotificationItem(
    id: '3',
    title: 'Security Alert',
    message: 'Your account was accessed from a verified session.',
    timeAgo: '2h ago',
    type: NotificationType.security,
    isRead: true,
  ),
  NotificationItem(
    id: '4',
    title: 'Template Update',
    message: 'Clean architecture patterns and Riverpod generators updated.',
    timeAgo: '1d ago',
    type: NotificationType.update,
    isRead: true,
  ),
];
