import 'package:flutter_test/flutter_test.dart';
import 'package:mapid/helper/string_display_helper.dart';
import 'package:mapid/helper/validator_helper.dart';
import 'package:mapid/shared/widget/logo/app_logo.dart';

void main() {
  group('Helper Unit Tests', () {
    test('StringDisplayHelper extracts initials correctly', () {
      expect(StringDisplayHelper.getInitialName('John Doe'), 'JD');
      expect(StringDisplayHelper.getInitialName('Single'), 'S');
      expect(StringDisplayHelper.getInitialName(''), '-');
    });

    test('ValidatorHelper validates email correctly', () {
      expect(emailValidator('test@example.com'), isNull);
      expect(emailValidator('invalid-email'), 'Email tidak valid');
      expect(emailValidator(''), 'Kolom tidak boleh kosong');
    });

    test('ValidatorHelper validates required fields', () {
      expect(requiredValidator('hello'), isNull);
      expect(requiredValidator(''), 'Kolom tidak boleh kosong');
      expect(requiredValidator(null), 'Kolom tidak boleh kosong');
    });
  });

  group('AppLogo Tests', () {
    test('AppLogo default assetPath is assets/image/app_icon.png', () {
      const logo = AppLogo();
      expect(logo.assetPath, 'assets/image/app_icon.png');
    });
  });
}

