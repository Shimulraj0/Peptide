import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String fullName;
  final String phoneNumber;
  final String? dob;
  final String gender;
  final double height;
  final double weight;

  UserProfile({
    required this.fullName,
    required this.phoneNumber,
    this.dob,
    required this.gender,
    required this.height,
    required this.weight,
  });

  UserProfile copyWith({
    String? fullName,
    String? phoneNumber,
    String? dob,
    String? gender,
    double? height,
    double? weight,
  }) {
    return UserProfile(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
    );
  }
}

class ProfileNotifier extends StateNotifier<UserProfile> {
  ProfileNotifier() : super(UserProfile(
    fullName: 'Dr. Julian Pierce',
    phoneNumber: '+1 (555) 000-0000',
    gender: 'Male',
    height: 180,
    weight: 78.5,
  ));

  void updateFullName(String name) => state = state.copyWith(fullName: name);
  void updatePhoneNumber(String phone) => state = state.copyWith(phoneNumber: phone);
  void updateGender(String gender) => state = state.copyWith(gender: gender);
  void updateHeight(double height) => state = state.copyWith(height: height);
  void updateWeight(double weight) => state = state.copyWith(weight: weight);
  void updateDOB(String dob) => state = state.copyWith(dob: dob);
}

final profileProvider = StateNotifierProvider<ProfileNotifier, UserProfile>((ref) {
  return ProfileNotifier();
});
