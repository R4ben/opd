import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:on_point_delivery/bloc/bloc.dart';
import 'package:on_point_delivery/repo/produtos/produtos.dart';
import 'package:on_point_delivery/repo/repo.dart';
import '../../model/product_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository _favoritesRepository;
  StreamSubscription? _favoriteSubscription;
  final String userId;
  FavoritesBloc({
  required this.userId,
  required FavoritesRepository favoritesRepository,
  })
      : _favoritesRepository=favoritesRepository,
        super(FavoritesLoading()) {
    _favoriteSubscription =
        _favoritesRepository.getFavorites(userId).listen((product) {
        add(LoadFavorites(product: product));
      }
    );
    on<LikeProduct>((event, emit) {
    _favoritesRepository.likeProduct(product: event.product, userId: userId);
    });
    on<DislikeProduct>((event, emit) {
      _favoritesRepository.dislikeProduct(
          product: event.product, userId: userId);
    });
    on<LoadFavorites>((event, emit) async {
      emit(FavoreitesLoaded(products: event.product));
    });
  }
}
