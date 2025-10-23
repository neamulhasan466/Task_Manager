// {
// "_id": "65b4a19c279fb0f60f610bb0",
// "title": "A",
// "description": "v",
// "status": "New",
// "email": "softenghasan25@gmail.com",
// "createdDate": "2024-01-27T06:24:25.316Z"
// },
class TaskModel {
  final String id;
  final String title;
  final String description;
  final String status;
  final String email;
  final String? createdDate; // optional profile picture URL

  TaskModel({
    required this.id,
    required this.email,
    required this.title,
    required this.description,
    required this.status,
    this.createdDate,
  });

  /// Create a UserModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['_id'] ?? '',
      email: jsonData['email'] ?? '',
      title: jsonData['title'] ?? '',
      description: jsonData['description'] ?? '',
      status: jsonData['status'] ?? '',
      createdDate: jsonData['createdDate'], // optional
    );
  }

  /// Convert UserModel to JSON (for saving locally)
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'title': title,
      'description': description,
      'status': status,
      'createdDate': createdDate,
    };
  }
}
