import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_point_delivery/model/billing.dart';

class BillingRepo {
  final String userId;
  CollectionReference firebilling =
      FirebaseFirestore.instance.collection('user');
  BillingRepo({required this.userId});

  Future<CustomerBilling> getBilling() {
    return firebilling
        .doc(userId)
        .collection('address')
        .doc('billing')
        .get()
        .then((value) => CustomerBilling.fromDocument(value));
  }
}
