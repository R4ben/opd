import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String ref;
  final String shortDescription;

  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final int price;
  // final int? index;

  const Product({
    required this.ref,
    required this.shortDescription,
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.price,
    // this.index,
  });

  Product copyWith({
    String? ref,
    String? shortDescription,
    String? id,
    String? name,
    String? category,
    String? description,
    String? imageUrl,
    int? price,
    // int? index,
  }) {
    return Product(
      id: id ?? this.id,
      ref: ref ?? this.ref,
      shortDescription: shortDescription ?? this.shortDescription,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      // index: index ?? this.index,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory Product.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snap) {
    return Product(
      id: snap.id,
      name: snap['Name'],
      category: snap['category'],
      description: snap['description'],
      imageUrl: snap['images'],
      price: snap['price'] ?? 0,
      ref: snap['ref'],
      shortDescription: snap['short_description'],
      // index: snap['index'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        ref,
        shortDescription,
        name,
        category,
        description,
        price,
        imageUrl,
        // index,
      ];
}
