import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  //final int index;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    //required this.index,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    //int? index,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      //index: index ?? this.index,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      //'index': index,
    };
  }

  factory CategoryModel.fromSnapshot(QueryDocumentSnapshot snap) {
    return CategoryModel(
      id: snap.id,
      name: snap['name'],
      description: '', //snap['description'] ?? '',
      imageUrl: snap['imageUrl'] ?? '',
      //index: snap['index'],
    );
  }

  @override
  List<Object> get props => [
        id,
        name,
        description,
        imageUrl,
        //index,
      ];

  static List<CategoryModel> categories = const [
    CategoryModel(
      id: '1',
      name: 'Salads',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/avocado.png',
      //index: 0,
    ),
    CategoryModel(
      id: '2',
      name: 'Desserts',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/pancake.png',
      // index: 1,
    ),
    CategoryModel(
      id: '3',
      name: 'Drinks',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/juice.png',
      // index: 2,
    ),
    CategoryModel(
      id: '4',
      name: 'Pizza',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/pizza.png',
      // index: 3,
    ),
    CategoryModel(
      id: '5',
      name: 'Burgers',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      imageUrl: 'images/burger.png',
      // index: 4,
    ),
  ];
}
