import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/product_model.dart';

class FavoritesRepository {
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('users');
  Stream<List<Product>> getFavorites(String userId) {
    return favorites.doc(userId).collection('likes').snapshots().map(
        (snapShot) => snapShot.docs
            .map((product) => Product.fromSnapshot(product))
            .toList());
  }

  Future<void> likeProduct({required Product product, required String userId}) {
    return favorites
        .doc(userId)
        .collection('likes')
        .doc(product.id)
        .set(product.toDocument()).then((value) => print("oggooogKKKK")).catchError((e)=>print(e.toString()));
  }
  Future<void> dislikeProduct({required Product product, required String userId}){
  return favorites
        .doc(userId)
        .collection('likes')
        .doc(product.id).delete().then((value) => print("Okkk")).catchError((e)=>print('Noooooooooooooo'));
  }




}
