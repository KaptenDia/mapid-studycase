import 'package:intl/intl.dart';

class StringDisplayHelper {
  static String getInitialName(String name) {
    name = name.trim();
    if (name.isEmpty) return '-';
    List<String> nameParts = name
        .split(' ')
        .where((s) => s.isNotEmpty)
        .toList();
    if (nameParts.isEmpty) return '-';
    if (nameParts.length == 1) return nameParts[0][0].toUpperCase();
    String firstInitial = nameParts[0][0].toUpperCase();
    String secondInitial = nameParts[1][0].toUpperCase();
    return '$firstInitial$secondInitial';
  }
}

String formatToRupiah(num amount) {
  try {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    String result = formatter.format(amount);
    if (result.endsWith(',00')) {
      result = result.substring(0, result.length - 3);
    }
    return result;
  } catch (e) {
    return 'invalid-format-amount';
  }
}
