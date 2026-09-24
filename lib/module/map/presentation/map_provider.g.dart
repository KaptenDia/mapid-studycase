// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapNotifier)
const mapProvider = MapNotifierProvider._();

final class MapNotifierProvider
    extends $NotifierProvider<MapNotifier, MapState> {
  const MapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapNotifierHash();

  @$internal
  @override
  MapNotifier create() => MapNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapState>(value),
    );
  }
}

String _$mapNotifierHash() => r'5f36e4e38f83c484c801c741caf379811bf0f0db';

abstract class _$MapNotifier extends $Notifier<MapState> {
  MapState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MapState, MapState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<MapState, MapState>,
              MapState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
