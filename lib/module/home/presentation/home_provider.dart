import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_provider.g.dart';

@riverpod
class HomeNavIndex extends _$HomeNavIndex {
  @override
  int build() => 0;

  void setIndex(int index) => state = index;
}
