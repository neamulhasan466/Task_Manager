class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? profilePic; // optional profile picture URL

  String get fullName => '$firstName $lastName';

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.profilePic,
  });

  /// Create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobile: json['mobile'] ?? '',
      profilePic: json['profilePic'], // optional
    );
  }

  /// Convert UserModel to JSON (for saving locally)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'profilePic': profilePic,
    };
  }
}
