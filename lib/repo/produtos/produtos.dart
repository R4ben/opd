import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/models.dart';

class ProductRepository {
  List<Product> _products = [];
  List<Product> get products => _products;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      _products = snapshot.docs
          .map((product) => Product.fromSnapshot(product))
          .toList();
      return _products;
    });
  }

  Stream<List<Product>> getCategoriesProducts(String categoryName) {
    return _firestore
        .collection('products')
        .where('category', isEqualTo: categoryName)
        .where('price', isGreaterThan: 0)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((category) => Product.fromSnapshot(category))
            .toList());
  }
  Future<Product> getProductById(String productId) {
    return  _firestore
        .collection('products')
        .doc(productId).get()
	.then((product)=>Product.fromDocument(product ));
  }
}
