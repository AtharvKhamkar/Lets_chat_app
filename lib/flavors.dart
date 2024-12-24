enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static Future<void> setAppFlavor(Flavor flavor) async {
    appFlavor = flavor;
  }

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Lets Chat Dev';
      case Flavor.prod:
        return 'Lets Chat';
      default:
        return 'title';
    }
  }
}
