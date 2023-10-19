// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Instructor {
  final String id;
  final String instructorName;
  final String profile;
  final String description;
  final String worksAt;
  Instructor({
    required this.id,
    required this.instructorName,
    required this.profile,
    required this.description,
    required this.worksAt,
  });

  Instructor copyWith({
    String? id,
    String? instructorName,
    String? profile,
    String? description,
    String? worksAt,
  }) {
    return Instructor(
      id: id ?? this.id,
      instructorName: instructorName ?? this.instructorName,
      profile: profile ?? this.profile,
      description: description ?? this.description,
      worksAt: worksAt ?? this.worksAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'instructorName': instructorName,
      'profile': profile,
      'description': description,
      'worksAt': worksAt,
    };
  }

  factory Instructor.fromMap(Map<String, dynamic> map) {
    return Instructor(
      id: map['_id'] as String,
      instructorName: map['instructorName'] as String,
      profile: map['profile'] as String,
      description: map['description'] as String,
      worksAt: map['worksAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Instructor.fromJson(String source) =>
      Instructor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Instructor(id: $id, instructorName: $instructorName, profile: $profile, description: $description, worksAt: $worksAt)';
  }

  @override
  bool operator ==(covariant Instructor other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.instructorName == instructorName &&
        other.profile == profile &&
        other.description == description &&
        other.worksAt == worksAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        instructorName.hashCode ^
        profile.hashCode ^
        description.hashCode ^
        worksAt.hashCode;
  }
}
