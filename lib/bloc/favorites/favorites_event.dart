part of 'favorites_bloc.dart';

@immutable
abstract class FavoritesEvent extends Equatable {}

class LikeProduct extends FavoritesEvent{
final Product product;
  LikeProduct({required this.product});

  @override
  List<Object?> get props =>[product];
}
class DislikeProduct extends FavoritesEvent{
final Product product;
  DislikeProduct({required this.product});

  @override
  List<Object?> get props =>[product];
}

class LoadFavorites extends FavoritesEvent {
  final List<Product> product;

  LoadFavorites({required this.product});

  @override
  List<Object?> get props =>[product];
}
