import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_info_provider.g.dart';

@riverpod
Future<PackageInfo> packageInfo(Ref ref) {
  return PackageInfo.fromPlatform();
}

@riverpod
Future<String> appVersionLabel(Ref ref) async {
  final info = await ref.watch(packageInfoProvider.future);
  final name = info.appName.isNotEmpty ? info.appName : 'MAPID';
  return '$name v${info.version}';
}

@riverpod
Future<String> appVersionWithBuild(Ref ref) async {
  final info = await ref.watch(packageInfoProvider.future);
  return 'v${info.version} (${info.buildNumber})';
}
