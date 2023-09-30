import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photo;
  final String? password;
  final String? storeId;
  final String? phone;
  final String? address;
  final String? notes;
  const User(
      {this.phone,
      this.address,
      this.notes,
      this.id,
      this.email,
      this.name,
      this.photo,
      this.password,
      this.storeId});
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? photo,
    String? password,
    String? storeId,
    String? phone,
    String? address,
    String? notes,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photo: photo ?? this.photo,
      password: password ?? this.password,
      storeId: storeId ?? this.storeId,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
    );
  }

  static const empty = User(
    id: "",
  );
  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;
  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photo,
        storeId,
        phone,
        address,
        notes,
      ];
}
