part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToMainPage extends NavigationEvent {}

class NavigateToCartPage extends NavigationEvent {}

class NavigateToAddressPage extends NavigationEvent {}

class NavigateToCategoryPage extends NavigationEvent {
  final CategoryModel category;
  const NavigateToCategoryPage({required this.category});
  @override
  List<Object> get props => [category];
}

class NavigateToProductDetailsPage extends NavigationEvent {
  final Product product;
  const NavigateToProductDetailsPage({required this.product});
  @override
  List<Object> get props => [product];
}
