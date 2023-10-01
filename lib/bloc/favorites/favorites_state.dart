part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesState extends Equatable{

@override
List<Object> get props =>[];
}

class FavoritesLoading extends FavoritesState {
  @override
  List<Object> get props =>[];
}

class FavoreitesLoaded extends FavoritesState {
  final List<Product> products;
  FavoreitesLoaded({required this.products});
  @override
  List<Object> get props => [products];
}
