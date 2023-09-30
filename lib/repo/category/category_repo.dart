import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/models.dart';
import 'base_category_repo.dart';

class CategoryRepository extends BaseCategoryRepo {
  final FirebaseFirestore _firestore;
  CategoryRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<CategoryModel>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) =>
        snapshot.docs
            .map((category) => CategoryModel.fromSnapshot(category))
            .toList());
  }

  @override
  Stream<List<Product>> getCategoriesProducts(String categoryId) {
    return _firestore.collection('categories').doc(categoryId).collection('products').snapshots().map((snapshot) =>
        snapshot.docs
            .map((category) => Product.fromSnapshot(category))
            .toList());
  }
}
