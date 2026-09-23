// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PersonalInfoNotifier)
const personalInfoProvider = PersonalInfoNotifierProvider._();

final class PersonalInfoNotifierProvider
    extends $NotifierProvider<PersonalInfoNotifier, PersonalInfo> {
  const PersonalInfoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'personalInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$personalInfoNotifierHash();

  @$internal
  @override
  PersonalInfoNotifier create() => PersonalInfoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PersonalInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PersonalInfo>(value),
    );
  }
}

String _$personalInfoNotifierHash() =>
    r'7a2381986053596e98f068edbe2061173b655b05';

abstract class _$PersonalInfoNotifier extends $Notifier<PersonalInfo> {
  PersonalInfo build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PersonalInfo, PersonalInfo>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PersonalInfo, PersonalInfo>,
              PersonalInfo,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
