class ClassModel {
  final String id;
  final String name;
  final String teacherId;

  ClassModel({
    required this.id,
    required this.name,
    required this.teacherId,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
    };
  }
}