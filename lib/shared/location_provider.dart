import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

part 'location_provider.g.dart';

@Riverpod(keepAlive: true)
class LocationNotifier extends _$LocationNotifier {
  @override
  FutureOr<String> build() async {
    return _determinePosition();
  }

  Future<String> fetchLocation() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _determinePosition());
    return state.value ?? 'Unknown location';
  }

  Future<String> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Location services disabled';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Location permissions denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Location permissions permanently denied';
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '';
        if (place.street != null && place.street!.isNotEmpty) {
          address += place.street!;
        }
        if (place.subAdministrativeArea != null && place.subAdministrativeArea!.isNotEmpty) {
          address += (address.isNotEmpty ? ', ' : '') + place.subAdministrativeArea!;
        } else if (place.locality != null && place.locality!.isNotEmpty) {
          address += (address.isNotEmpty ? ', ' : '') + place.locality!;
        }
        return address.isNotEmpty ? address : 'Unknown location';
      }
    } catch (e) {
      return 'Failed to get location';
    }

    return 'Unknown location';
  }
}
