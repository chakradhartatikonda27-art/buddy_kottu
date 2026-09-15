import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String uid;
  final String name;
  final String phone;
  final String selectedAddressTitle;
  final bool isAuthenticated;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.phone,
    required this.selectedAddressTitle,
    this.isAuthenticated = false,
  });

  UserProfile copyWith({
    String? uid,
    String? name,
    String? phone,
    String? selectedAddressTitle,
    bool? isAuthenticated,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      selectedAddressTitle: selectedAddressTitle ?? this.selectedAddressTitle,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

class AuthNotifier extends StateNotifier<UserProfile> {
  AuthNotifier()
      : super(const UserProfile(
          uid: 'usr_rahul_99',
          name: 'Rahul V',
          phone: '+91 98765 43210',
          selectedAddressTitle: 'Hostel Block B, Room 304',
          isAuthenticated: true,
        ));

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  bool verifyOtp(String otp) {
    if (otp.length == 6) {
      state = state.copyWith(isAuthenticated: true);
      return true;
    }
    return false;
  }

  void updateLocation(String addressTitle) {
    state = state.copyWith(selectedAddressTitle: addressTitle);
  }

  void logout() {
    state = state.copyWith(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, UserProfile>((ref) {
  return AuthNotifier();
});
