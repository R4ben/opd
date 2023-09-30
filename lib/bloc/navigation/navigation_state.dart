part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  @override
  List<Object> get props => [];
}

class ShowSplashScreen extends NavigationState {}

class ShowHomePage extends NavigationState {}

class ShowCartPage extends NavigationState {}

class ShowAddressPage extends NavigationState {}

class ShowProductDetailsPage extends NavigationState {
  final Product product;
  const ShowProductDetailsPage({required this.product});
  @override
  List<Object> get props => [product];
}

class ShowCategoryPage extends NavigationState {
  final CategoryModel category;
  const ShowCategoryPage({required this.category});
  @override
  List<Object> get props => [category];
}
