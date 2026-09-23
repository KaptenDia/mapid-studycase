import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:samseer/samseer.dart';

class SamseerNotificationBridge {
  SamseerNotificationBridge({required this.samseer, required this.plugin});
  final Samseer samseer;
  final FlutterLocalNotificationsPlugin plugin;

  static const int _id = 9999;
  final Set<int> _seen = {};
  StreamSubscription<List<SamseerHttpCall>>? _sub;

  void start() {
    for (final c in samseer.calls) {
      if (!c.loading) _seen.add(c.id);
    }
    _sub = samseer.callsStream.listen((calls) {
      for (final c in calls) {
        if (!c.loading && _seen.add(c.id)) _emit(c);
      }
      _seen.retainAll(calls.map((c) => c.id).toSet());
    });
  }

  bool handleTap(NotificationResponse r) {
    if (r.id != _id) return false;
    samseer.showInspector();
    return true;
  }

  void _emit(SamseerHttpCall c) {
    final status = c.status?.toString() ?? (c.hasError ? 'ERR' : '-');
    plugin.show(
      id: _id,
      title: '[${c.method}] $status ${c.endpoint.isEmpty ? c.uri : c.endpoint}',
      body: c.error?.message ?? c.uri,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'samseer',
          'Samseer HTTP calls',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(presentAlert: true, presentBanner: true),
      ),
    );
  }

  Future<void> dispose() async => _sub?.cancel();
}
