import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'product_model.dart';

class Profile extends Equatable {
  final String? id;
  final String? email;
  final String? name;
  final String? photo;
  final String? phone;
  final String? notes;

  const Profile({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.phone,
    this.notes,
  });
  Profile copyWith(
    String? id,
    String? email,
    String? name,
    String? photo,
    String? phone,
    String? address,
    String? notes,
  final List<Product>? likes
  ) {
    return Profile(
      id: id,
      email: this.email ?? email,
      name: this.name ?? name,
      photo: this.photo ?? photo,
      phone: this.phone ?? phone,
      notes: this.notes ?? notes,
    );
  }

  static const empty = Profile(
    id: '',
  );
  factory Profile.fromSnapshot(DocumentSnapshot snap) {
    return Profile(
      id: snap.id,
      email: snap['email'],
      name: snap['name'],
      photo: snap['photo'],
      notes: snap['notes'],
      phone: snap['phone'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'photo': photo,
      'phone': phone,
      'notes': notes,
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photo,
        phone,
        notes,
      ];
}
