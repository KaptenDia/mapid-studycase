import 'package:flutter_test/flutter_test.dart';
import 'package:mapid/const/env_config.dart';
import 'package:mapid/module/map/data/model/geo_layer_model.dart';
import 'package:mapid/module/map/domain/map_state.dart';

void main() {
  group('GeoLayerModel Tests', () {
    test('GeoLayerResp parses GeoJSON FeatureCollection correctly', () {
      final sampleJson = {
        'type': 'FeatureCollection',
        'layer_name': 'Pariwisata Jogja',
        'features': [
          {
            'type': 'Feature',
            'id': 'feat_1',
            'geometry': {
              'type': 'Point',
              'coordinates': [110.368369, -7.799231],
            },
            'properties': {
              'NAMA': 'Malioboro',
              'ALAMAT': 'Jl. Malioboro No. 56',
              'PROVINSI': 'D.I. Yogyakarta',
              'KABKOT': 'Kota Yogyakarta',
              'KECAMATAN': 'Danurejan',
              'DESA': 'Suryatmajan',
              'WAKTU': '2024',
            },
          },
          {
            'type': 'Feature',
            'id': 'feat_2',
            'geometry': {
              'type': 'Point',
              'coordinates': [110.3644, -7.8053],
            },
            'properties': {
              'NAMA': 'Kraton Ngayogyakarta',
              'ALAMAT': 'Jl. Rotowijayan Blok No. 1',
              'PROVINSI': 'D.I. Yogyakarta',
              'KABKOT': 'Kota Yogyakarta',
              'KECAMATAN': 'Kraton',
              'DESA': 'Kadipaten',
              'WAKTU': '2024',
            },
          },
        ],
      };

      final resp = GeoLayerResp.fromJson(sampleJson);

      expect(resp.type, 'FeatureCollection');
      expect(resp.layerName, 'Pariwisata Jogja');
      expect(resp.features.length, 2);

      final feat1 = resp.features[0];
      expect(feat1.id, 'feat_1');
      expect(feat1.nama, 'Malioboro');
      expect(feat1.alamat, 'Jl. Malioboro No. 56');
      expect(feat1.provinsi, 'D.I. Yogyakarta');
      expect(feat1.kabkot, 'Kota Yogyakarta');
      expect(feat1.kecamatan, 'Danurejan');
      expect(feat1.desa, 'Suryatmajan');
      expect(feat1.waktu, '2024');
      expect(feat1.longitude, 110.368369);
      expect(feat1.latitude, -7.799231);

      // Verify toJson() roundtrip
      final jsonOutput = feat1.toJson();
      final roundtrip = GeoFeature.fromJson(jsonOutput);
      expect(roundtrip.nama, feat1.nama);
      expect(roundtrip.latitude, feat1.latitude);
      expect(roundtrip.longitude, feat1.longitude);
    });

    test('GeoFeature handles null and empty fields gracefully', () {
      final minimalJson = {
        'type': 'Feature',
        'geometry': null,
        'properties': null,
      };

      final feat = GeoFeature.fromJson(minimalJson);

      expect(feat.nama, 'Unnamed Location');
      expect(feat.alamat, '-');
      expect(feat.provinsi, '');
      expect(feat.latitude, 0.0);
      expect(feat.longitude, 0.0);
    });

    test('GeoFeature sanitizes corrupted server characters and mojibake', () {
      final corruptedJson = {
        'type': 'Feature',
        'geometry': {
          'type': 'Point',
          'coordinates': [110.38825, -7.80976],
        },
        'properties': {
          'NAMA': 'TAMAN WARUNGBOTO (ʦ\uFFFDʦ\uFFFDʦ\uFFFDʧ\uFFFDʦ\uFFFD)',
        },
      };

      final feat = GeoFeature.fromJson(corruptedJson);
      expect(feat.nama, 'TAMAN WARUNGBOTO');
    });
  });

  group('MapState Tests', () {
    test('Default MapState is properly initialized', () {
      const state = MapState();
      expect(state.isLoading, false);
      expect(state.errorMessage, '');
      expect(state.layerData, isNull);
      expect(state.selectedFeature, isNull);
      expect(state.userLocation, isNull);
      expect(state.isLayerVisible, true);
      expect(state.features, isEmpty);
      expect(state.hasFeatures, false);
    });

    test('MapState copyWith updates fields correctly', () {
      const state = MapState();
      final updated = state.copyWith(
        isLoading: true,
        errorMessage: 'Connection error',
        isLayerVisible: false,
      );

      expect(updated.isLoading, true);
      expect(updated.errorMessage, 'Connection error');
      expect(updated.isLayerVisible, false);
    });

    test('MapState clearSelectedFeature clears selected item', () {
      const feature = GeoFeature(
        id: '1',
        type: 'Feature',
        geometry: GeoGeometry(type: 'Point', coordinates: [110.0, -7.0]),
        properties: {'NAMA': 'Test POI'},
      );

      var state = const MapState().copyWith(selectedFeature: feature);
      expect(state.selectedFeature, isNotNull);
      expect(state.selectedFeature?.nama, 'Test POI');

      state = state.copyWith(clearSelectedFeature: true);
      expect(state.selectedFeature, isNull);
    });

    test('MapState correctly reports hasFeatures when layerData is loaded', () {
      const feature = GeoFeature(
        id: '1',
        type: 'Feature',
        geometry: GeoGeometry(type: 'Point', coordinates: [110.368, -7.799]),
        properties: {'NAMA': 'Malioboro'},
      );
      const layer = GeoLayerResp(
        layerId: 'layer_1',
        type: 'FeatureCollection',
        layerName: 'Pariwisata Jogja',
        fields: [],
        features: [feature],
      );

      final state = const MapState().copyWith(layerData: layer);
      expect(state.hasFeatures, true);
      expect(state.features.length, 1);
      expect(state.features.first.nama, 'Malioboro');
    });
  });

  group('EnvConfig Tests', () {
    test('OpenFreeMap Liberty URL is configured', () {
      expect(
        EnvConfig.openFreeMapStyleUrl,
        'https://tiles.openfreemap.org/styles/liberty',
      );
    });

    test('GeoServer URL is configured', () {
      expect(
        EnvConfig.mapidGeoServerUrl,
        'https://geoserver.mapid.io/layers_new/get_layer',
      );
    });
  });
}
