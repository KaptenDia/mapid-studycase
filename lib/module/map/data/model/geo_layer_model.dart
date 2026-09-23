import 'package:maplibre_gl/maplibre_gl.dart';

class GeoLayerResp {
  final String layerId;
  final String layerName;
  final String type;
  final List<GeoField> fields;
  final List<GeoFeature> features;

  const GeoLayerResp({
    required this.layerId,
    required this.layerName,
    required this.type,
    required this.fields,
    required this.features,
  });

  factory GeoLayerResp.fromJson(Map<String, dynamic> json) {
    return GeoLayerResp(
      layerId: json['layer_id']?.toString() ?? '',
      layerName: json['layer_name']?.toString() ?? '',
      type: json['type']?.toString() ?? 'FeatureCollection',
      fields:
          (json['fields'] as List<dynamic>?)
              ?.map((e) => GeoField.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => GeoFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'layer_id': layerId,
    'layer_name': layerName,
    'type': type,
    'fields': fields.map((e) => e.toJson()).toList(),
    'features': features.map((e) => e.toJson()).toList(),
  };
}

class GeoField {
  final String key;
  final String name;
  final String type;

  const GeoField({required this.key, required this.name, required this.type});

  factory GeoField.fromJson(Map<String, dynamic> json) {
    return GeoField(
      key: json['key']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      type: json['type']?.toString() ?? 'text',
    );
  }

  Map<String, dynamic> toJson() => {'key': key, 'name': name, 'type': type};
}

class GeoFeature {
  final String id;
  final String type;
  final GeoGeometry geometry;
  final Map<String, dynamic> properties;

  const GeoFeature({
    required this.id,
    required this.type,
    required this.geometry,
    required this.properties,
  });

  factory GeoFeature.fromJson(Map<String, dynamic> json) {
    return GeoFeature(
      id: json['id']?.toString() ?? '',
      type: json['type']?.toString() ?? 'Feature',
      geometry: GeoGeometry.fromJson(
        json['geometry'] as Map<String, dynamic>? ?? {},
      ),
      properties: json['properties'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'geometry': geometry.toJson(),
    'properties': properties,
  };

  String get nama {
    final raw = properties['NAMA']?.toString() ?? 'Unnamed Location';
    return raw
        .replaceAll(RegExp(r'\([^)]*[\uFFFDʦʧ][^)]*\)'), '')
        .replaceAll('\uFFFD', '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String get alamat => properties['ALAMAT']?.toString() ?? '-';
  String get provinsi => properties['PROVINSI']?.toString() ?? '';
  String get kabkot => properties['KABKOT']?.toString() ?? '';
  String get kecamatan => properties['KECAMATAN']?.toString() ?? '';
  String get desa => properties['DESA']?.toString() ?? '';
  String get waktu => properties['WAKTU']?.toString() ?? '';

  double get longitude => geometry.longitude;
  double get latitude => geometry.latitude;
  LatLng get latLng => LatLng(latitude, longitude);
}

class GeoGeometry {
  final String type;
  final List<double> coordinates;

  const GeoGeometry({required this.type, required this.coordinates});

  factory GeoGeometry.fromJson(Map<String, dynamic> json) {
    final rawCoords = json['coordinates'] as List<dynamic>? ?? [];
    final coords = rawCoords.map((e) => (e as num).toDouble()).toList();
    return GeoGeometry(
      type: json['type']?.toString() ?? 'Point',
      coordinates: coords,
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'coordinates': coordinates};

  double get longitude => coordinates.isNotEmpty ? coordinates[0] : 0.0;
  double get latitude => coordinates.length > 1 ? coordinates[1] : 0.0;
}
