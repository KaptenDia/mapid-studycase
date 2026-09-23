enum AppImage {
  onboarding1,
  appIcon;

  String get value {
    switch (this) {
      case AppImage.onboarding1:
        return 'assets/image/onboarding-1.png';
      case AppImage.appIcon:
        return 'assets/image/app_icon.png';
    }
  }
}
