class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String role; // 'admin', 'student', 'parent'
  final String? studentId; // Only for students
  final String? phone;
  final DateTime? createdAt;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    this.studentId,
    this.phone,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      studentId: json['studentId'],
      phone: json['phone'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'role': role,
      'studentId': studentId,
      'phone': phone,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Helper methods for role checking
  bool get isAdmin => role == 'admin';
  bool get isStudent => role == 'student';
  bool get isParent => role == 'parent';
}