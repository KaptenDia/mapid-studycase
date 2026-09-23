enum AppIcon {
  icPerson,
  icPassword,
  icAlertRed,
  icEmail,
  icPhone;

  String get value {
    switch (this) {
      case AppIcon.icPerson:
        return 'assets/image/ic_person.png';
      case AppIcon.icPassword:
        return 'assets/image/ic_password.png';
      case AppIcon.icAlertRed:
        return 'assets/image/ic_alert_red.png';
      case AppIcon.icEmail:
        return 'assets/image/ic_email.png';
      case AppIcon.icPhone:
        return 'assets/image/ic_phone.png';
    }
  }
}
