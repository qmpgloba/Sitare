class UserModel {
  final String name;
  final String email;
  final String phoneNumber;
  final String? gender;
  final String? dateofBirth;
  final String? placeofBirth;
  final String? timeofBirth;
  final String? maritalStatus;
  final String? problem;
  final List<String?>? partnerDetails;

  UserModel({
    this.gender,
    this.dateofBirth,
    this.placeofBirth,
    this.timeofBirth,
    this.maritalStatus,
    this.problem,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.partnerDetails,
  });

  toJson() {
    return {
      'full name': name,
      'email': email,
      'phone number': phoneNumber,
      'gender': gender,
      'dateofBirth': dateofBirth,
      'placeofBirth': placeofBirth,
      'timeofBirth': timeofBirth,
      'maritalStatus': maritalStatus,
      'problem': problem,
      'PartnerDetails': partnerDetails,
    };
  }
}