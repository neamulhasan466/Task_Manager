class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
  });

  /// ✅ Create a UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  /// ✅ Convert UserModel to JSON (optional, useful for saving locally)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
    };
  }
}

// BODY: {"status":"success","data":
// {"_id":"68f7dc25880cc5d30a2fb9a1","email":"d@gmail.com",
// "firstName":"abc","lastName":"d","mobile":"0015458412","createdDate":"2025-10-02T06:21:41.011Z"},
// "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NjExNjA2MzAsImRhdGEiOiJkQGdtYWlsLmNvbSIsImlhdCI6MTc2MTA3NDIzMH0.8vpaGBk6zlyTh4SVpI0MMDzmsSr3cpc1Lw3X5md6nRU"}
