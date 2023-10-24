// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:culinary_course/src/models/course.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String number;
  final String password;
  final bool isPaid;
  final String token;
  final List<Course> cart;
  final List<Course> wishlist;
  final List<Course> enrolled;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.number,
    required this.password,
    required this.isPaid,
    required this.token,
    required this.cart,
    required this.wishlist,
    required this.enrolled,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? password,
    bool? isPaid,
    String? token,
    List<Course>? cart,
    List<Course>? wishlist,
    List<Course>? enrolled,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      password: password ?? this.password,
      isPaid: isPaid ?? this.isPaid,
      token: token ?? this.token,
      cart: cart ?? this.cart,
      wishlist: wishlist ?? this.wishlist,
      enrolled: enrolled ?? this.enrolled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'isPaid': isPaid,
      'token': token,
      'cart': cart.map((x) => x.toMap()).toList(),
      'wishlist': wishlist.map((x) => x.toMap()).toList(),
      'enrolled': enrolled.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      number: map['number'] as String,
      password: map['password'] as String,
      isPaid: map['isPaid'] as bool,
      token: map['token'] as String,
      cart: List<Course>.from(
        (map['cart'] as List<dynamic>).map<Course>(
          (x) => Course.fromMap(x as Map<String, dynamic>),
        ),
      ),
      wishlist: List<Course>.from(
        (map['wishlist'] as List<dynamic>).map<Course>(
          (x) => Course.fromMap(x as Map<String, dynamic>),
        ),
      ),
      enrolled: List<Course>.from(
        (map['enrolled'] as List<dynamic>).map<Course>(
          (x) => Course.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, number: $number, password: $password, isPaid: $isPaid, token: $token, cart: $cart, wishlist: $wishlist, enorolled: $enrolled)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.number == number &&
        other.password == password &&
        other.isPaid == isPaid &&
        other.token == token &&
        listEquals(other.cart, cart) &&
        listEquals(other.wishlist, wishlist) &&
        listEquals(other.enrolled, enrolled);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        number.hashCode ^
        password.hashCode ^
        isPaid.hashCode ^
        token.hashCode ^
        cart.hashCode ^
        wishlist.hashCode ^
        enrolled.hashCode;
  }
}
