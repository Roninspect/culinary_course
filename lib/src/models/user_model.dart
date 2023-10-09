// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String number;
  final String password;
  final bool isPaid;
  final String token;
  final List<dynamic> cart;
  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.number,
      required this.password,
      required this.isPaid,
      required this.token,
      required this.cart});

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? password,
    bool? isPaid,
    String? token,
    List<dynamic>? cart,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        number: number ?? this.number,
        password: password ?? this.password,
        isPaid: isPaid ?? this.isPaid,
        token: token ?? this.token,
        cart: cart ?? this.cart);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'password': password,
      'isPaid': isPaid,
      "cart": cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      number: map['number'] ?? "",
      password: map['password'] ?? "",
      isPaid: map['isPaid'] ?? false,
      token: map['token'] ?? "",
      cart: List<Map<String, dynamic>>.from(
        map['cart']?.map(
          (x) => Map<String, dynamic>.from(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}

// class Cart {
//   final String id;
//   final int quantity;
//   Cart({
//     required this.id,
//     required this.quantity,
//   });

//   Cart copyWith({
//     String? id,
//     int? quantity,
//   }) {
//     return Cart(
//       id: id ?? this.id,
//       quantity: quantity ?? this.quantity,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'quantity': quantity,
//     };
//   }

//   factory Cart.fromMap(Map<String, dynamic> map) {
//     return Cart(
//       id: map['_id'] as String,
//       quantity: map['quantity'] as int,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Cart.fromJson(String source) =>
//       Cart.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Cart(id: $id, quantity: $quantity)';

//   @override
//   bool operator ==(covariant Cart other) {
//     if (identical(this, other)) return true;

//     return other.id == id && other.quantity == quantity;
//   }

//   @override
//   int get hashCode => id.hashCode ^ quantity.hashCode;
// }
