import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/personal_info_model.dart';

part 'personal_info_provider.g.dart';

@riverpod
class PersonalInfoNotifier extends _$PersonalInfoNotifier {
  @override
  PersonalInfo build() => dummyPersonalInfo;

  void updateFullName(String fullName) {
    state = state.copyWith(fullName: fullName);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void updateProfilePhoto(String photoUrl) {
    state = state.copyWith(profilePhotoUrl: photoUrl);
  }

  void saveChanges(PersonalInfo updatedInfo) {
    state = updatedInfo;
  }

  void resetToInitial() {
    state = dummyPersonalInfo;
  }
}
