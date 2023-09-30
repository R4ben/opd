import 'package:equatable/equatable.dart';
import 'models.dart';

class Order extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime datePaid;
  final DateTime dateComplete;
  final AdressModel address;
  Order({
    required this.id,
    required this.createdAt,
    required this.datePaid,
    required this.dateComplete,
    required this.address,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
