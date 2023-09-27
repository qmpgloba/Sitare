class UserModel {
  final String name;
  final String email;
  final String phoneNumber;

  UserModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  toJson() {
    return {
      'full name': name,
      'email': email,
      'phone number': phoneNumber,
    };
  }
}
