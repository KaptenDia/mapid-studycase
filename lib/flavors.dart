enum Flavor {
  dev,
  staging,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Base App Dev';
      case Flavor.staging:
        return 'Base App Stg';
      case Flavor.prod:
        return 'Base App';
    }
  }
}
