import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat("dd/MM/yyyy").format(dateTime);
    } catch (e) {
      return "invalid-date";
    }
  }

  static String formatDateTime(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString).toLocal();
      return DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
    } catch (e) {
      return "invalid-date-time";
    }
  }

  static String timeAgo(String dateString) {
    try {
      final now = DateTime.now();
      final difference = now.difference(DateTime.parse(dateString).toLocal());

      if (difference.inDays > 365) {
        final years = (difference.inDays / 365).floor();
        return '$years tahun';
      } else if (difference.inDays > 30) {
        final months = (difference.inDays / 30).floor();
        return '$months bulan';
      } else if (difference.inDays > 0) {
        return '${difference.inDays} hari';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} jam';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} menit';
      } else if (difference.inSeconds > 0) {
        return '${difference.inSeconds} detik';
      } else {
        return 'Baru saja';
      }
    } catch (e) {
      return "invalid-date-time";
    }
  }
}
