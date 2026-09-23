import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  EnvConfig._();

  static String _getEnv(String key, String fallback) {
    if (!dotenv.isInitialized) return fallback;
    return dotenv.env[key] ?? fallback;
  }

  static String get mapidApiKey => _getEnv(
        'MAPID_API_KEY',
        '8a41b8d031864ba9ae82ccff447460f3',
      );

  static String get mapidLayerId => _getEnv(
        'MAPID_LAYER_ID',
        '6aaa479abf51a2f0185a601b',
      );

  static String get mapidProjectId => _getEnv(
        'MAPID_PROJECT_ID',
        '6aa3b36388f2c84b0c10cb58',
      );

  static String get mapidGeoServerUrl => _getEnv(
        'MAPID_GEOSERVER_URL',
        'https://geoserver.mapid.io/layers_new/get_layer',
      );

  static String get openFreeMapStyleUrl => _getEnv(
        'OPENFREEMAP_STYLE_URL',
        'https://tiles.openfreemap.org/styles/liberty',
      );
}
