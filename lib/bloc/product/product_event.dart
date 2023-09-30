part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}


class LoadProducts extends ProductEvent {
  final List<Product> products;

  const LoadProducts({
    required this.products,
  });

  @override
  List<Object> get props => [products];
}
class LoadProductsByCategory extends ProductEvent {
  final String categoryName;

  const LoadProductsByCategory({
    required this.categoryName,
  });

  @override
  List<Object> get props => [categoryName];
}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProducts extends ProductEvent {
  final Product product;

  const UpdateProducts({required this.product});

  @override
  List<Object> get props => [product];
}

class FilterProducts extends ProductEvent {
  final CategoryModel category;

  const FilterProducts({required this.category });

  @override
  List<Object> get props => [category];
}

class SortProducts extends ProductEvent {
  final int oldIndex;
  final int newIndex;

  const SortProducts({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object> get props => [oldIndex, newIndex];
}
