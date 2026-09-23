class PersonalInfo {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profilePhotoUrl;

  PersonalInfo({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profilePhotoUrl,
  });

  PersonalInfo copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) {
    return PersonalInfo(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }
}

// Dummy data for initial display
final dummyPersonalInfo = PersonalInfo(
  id: '1',
  fullName: 'Siti Aminah',
  email: 'siti.aminah@example.com',
  phoneNumber: '+62 8123456789',
  profilePhotoUrl: null,
);
