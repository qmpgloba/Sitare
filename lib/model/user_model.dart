class UserModel {
  final String fcmToken;
  final String uid;
  final String name;
  final String? email;
  final String userProfileImage;
  final String phoneNumber;
  final String? gender;
  final String? dateofBirth;
  final String? placeofBirth;
  final String? timeofBirth;
  final String? maritalStatus;
  final String? problem;
  final String? wallet;
  final List<String?>? partnerDetails;

  UserModel({
    this.gender,
    this.dateofBirth,
    this.placeofBirth,
    this.timeofBirth,
    this.maritalStatus,
    this.problem,
    this.wallet,
    required this.userProfileImage,
    required this.fcmToken,
    required this.uid,
    required this.name,
    this.email,
    required this.phoneNumber,
    this.partnerDetails,
  });

  toJson() {
    return {
      'fcmToken': fcmToken,
      'uid': uid,
      'full name': name,
      'email': email,
      'profile image': userProfileImage,
      'phone number': phoneNumber,
      'gender': gender,
      'dateofBirth': dateofBirth,
      'placeofBirth': placeofBirth,
      'timeofBirth': timeofBirth,
      'maritalStatus': maritalStatus,
      'problem': problem,
      'PartnerDetails': partnerDetails,
      'wallet': wallet,
    };
  }
}
