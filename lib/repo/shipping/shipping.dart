import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_point_delivery/model/shipping.dart';

class ShippingRepository {
  final String userId;
  CollectionReference fireShipping =
      FirebaseFirestore.instance.collection('user');
  ShippingRepository({required this.userId});
  Stream<CustomerShipping> getShipping() {
    return fireShipping
        .doc(userId)
        .collection('shipping')
        .doc()
        .snapshots()
        .map((shipping) => CustomerShipping.fromDocument(shipping));
  }
}
