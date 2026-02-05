part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final XFile? selectedImage;
  final String? username;
  final String? countryName;
  final String? countryCode;

  const ProfileState({this.selectedImage, this.username, this.countryName, this.countryCode});

  ProfileState copyWith({
    XFile? selectedImage,
    String? username,
    String? countryName,
    String? countryCode,
  }) {
    return ProfileState(
      selectedImage: selectedImage ?? this.selectedImage,
      username: username ?? this.username,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [selectedImage, username, countryName, countryCode];
}
