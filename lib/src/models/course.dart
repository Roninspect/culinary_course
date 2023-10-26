// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:culinary_course/src/core/enums/watch_enum.dart';
import 'package:culinary_course/src/models/instructor.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final num price;
  final String intro;
  final String category;
  final bool isPaid;
  final Instructor instructor;
  final List<Curriculum> curriculum;
  final bool isFeatured;
  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.intro,
    required this.category,
    required this.isPaid,
    required this.instructor,
    required this.curriculum,
    required this.isFeatured,
  });

  Course copyWith({
    String? id,
    String? title,
    String? description,
    num? price,
    String? thumbnail,
    String? intro,
    String? category,
    bool? isPaid,
    Instructor? instructor,
    List<Curriculum>? curriculum,
    bool? isFeatured,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      intro: intro ?? this.intro,
      category: category ?? this.category,
      isPaid: isPaid ?? this.isPaid,
      instructor: instructor ?? this.instructor,
      curriculum: curriculum ?? this.curriculum,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'description': description,
      'price': price,
      'thumbnail': thumbnail,
      'intro': intro,
      'category': category,
      'isPaid': isPaid,
      'instructor': instructor.toMap(),
      'curriculum': curriculum.map((x) => x.toMap()).toList(),
      'isFeatured': isFeatured,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['_id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      thumbnail: map['thumbnail'] as String,
      intro: map['intro'] as String,
      category: map['category'] as String,
      isPaid: map['isPaid'] as bool,
      instructor: Instructor.fromMap(map['instructor'] as Map<String, dynamic>),
      curriculum: List<Curriculum>.from(
        (map['curriculum'] as List<dynamic>).map<Curriculum>(
          (x) => Curriculum.fromMap(x as Map<String, dynamic>),
        ),
      ),
      isFeatured: map['isFeatured'] as bool,
    );
  }

  int get totalContentCount {
    // Use fold to iterate through all curriculums and sum up the content count
    return curriculum.fold(
        0, (total, curriculum) => total + curriculum.content.length);
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) =>
      Course.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Course(id: $id, title: $title, description: $description, thumbnail: $thumbnail, intro: $intro, category: $category, isPaid: $isPaid, instructor: $instructor, curriculum: $curriculum, isFeatured: $isFeatured)';
  }

  @override
  bool operator ==(covariant Course other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.thumbnail == thumbnail &&
        other.intro == intro &&
        other.category == category &&
        other.isPaid == isPaid &&
        other.instructor == instructor &&
        listEquals(other.curriculum, curriculum) &&
        other.isFeatured == isFeatured;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        thumbnail.hashCode ^
        intro.hashCode ^
        category.hashCode ^
        isPaid.hashCode ^
        instructor.hashCode ^
        curriculum.hashCode ^
        isFeatured.hashCode;
  }
}

class Curriculum {
  final String title;
  final List<Content> content;
  final String id;
  Curriculum({
    required this.title,
    required this.content,
    required this.id,
  });

  Curriculum copyWith({
    String? title,
    List<Content>? content,
    String? id,
  }) {
    return Curriculum(
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content.map((x) => x.toMap()).toList(),
    };
  }

  factory Curriculum.fromMap(Map<String, dynamic> map) {
    return Curriculum(
      title: map['title'] as String,
      content: List<Content>.from(
        (map['content'] as List<dynamic>).map<Content>(
          (x) => Content.fromMap(x as Map<String, dynamic>),
        ),
      ),
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Curriculum.fromJson(String source) =>
      Curriculum.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Curriculum(title: $title, content: $content, id: $id)';

  @override
  bool operator ==(covariant Curriculum other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        listEquals(other.content, content) &&
        other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ id.hashCode;
}

class Content {
  final String title;
  final String link;
  final bool isFreePreview;
  final String isWatched;
  final String id;
  Content({
    required this.title,
    required this.link,
    required this.isFreePreview,
    required this.isWatched,
    required this.id,
  });

  Content copyWith({
    String? title,
    String? link,
    bool? isFreePreview,
    String? isWatched,
    String? id,
  }) {
    return Content(
      title: title ?? this.title,
      link: link ?? this.link,
      isFreePreview: isFreePreview ?? this.isFreePreview,
      isWatched: isWatched ?? this.isWatched,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'link': link,
      'isFreePreview': isFreePreview,
      'isWatched': isWatched,
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      title: map['title'] as String,
      link: map['link'] as String,
      isFreePreview: map['isFreePreview'] as bool,
      isWatched: map['isWatched'] as String,
      id: map['_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Content(title: $title, link: $link, isFreePreview: $isFreePreview, isWatched: $isWatched, id: $id)';
  }

  @override
  bool operator ==(covariant Content other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.link == link &&
        other.isFreePreview == isFreePreview &&
        other.isWatched == isWatched &&
        other.id == id;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        link.hashCode ^
        isFreePreview.hashCode ^
        isWatched.hashCode ^
        id.hashCode;
  }
}
