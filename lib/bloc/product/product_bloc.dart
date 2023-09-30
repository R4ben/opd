import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/category_model.dart';
import '../../model/product_model.dart';
import '../../repo/repo.dart';
import '../category/category_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CategoryBloc _categoryBloc;
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;
  StreamSubscription? _categorySubscription;

  ProductBloc(
      {required CategoryBloc categoryBloc,
      required ProductRepository productRepository})
      : _categoryBloc = categoryBloc,
        _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<FilterProducts>(_onFilterProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategories);
    // on<SortProducts>(_onSortProducts);

    _categorySubscription = _categoryBloc.stream.listen((state) {
      if (state is CategoryLoaded) {
        if (state.selectedCategory != null) {
          add(
            FilterProducts(category: (state.selectedCategory!)),
          );
        }
      } else {}
    });

    // _productSubscription = _productRepository.getProducts().listen(
    //       (product) => add(LoadProducts(products: product)),
    //     );
  }

  void _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) {
    emit(ProductLoaded(products: event.products));
  }

  void _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) {
    if (state is ProductLoaded) {
      List<Product> newProducts = List.from((state as ProductLoaded).products)
        ..add(event.product);

      emit(ProductLoaded(products: newProducts));
    }
  }

  void _onFilterProducts(
    FilterProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    try {
      List<Product> filteredProduts = _productRepository.products
          .where(
              (product) => product.category.compareTo(event.category.name) == 0)
          .toList();
      print(filteredProduts);

      add(LoadProducts(products: filteredProduts));
    } catch (_) {}
  }

  // void _onSortProducts(
  //   SortProducts event,
  //   Emitter<ProductState> emit,
  // ) async {
  //   final state = this.state as ProductLoaded;
  //   emit(ProductLoading());
  //   await Future<void>.delayed(const Duration(seconds: 1));

  //   int newIndex =
  //       (event.newIndex > event.oldIndex) ? event.newIndex - 1 : event.newIndex;

  //   try {
  //     Product selectedProduct = state.products[event.oldIndex];

  //     List<Product> sortedProducts = List.from(state.products)
  //       ..remove(selectedProduct)
  //       ..insert(newIndex, selectedProduct);

  //     emit(
  //       ProductLoaded(products: sortedProducts),
  //     );
  //   } catch (_) {}
  // }

  @override
  Future<void> close() async {
    _categorySubscription?.cancel();
    _productSubscription?.cancel();
    super.close();
  }

  _onLoadProductsByCategories(
      LoadProductsByCategory event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      _productRepository
          .getCategoriesProducts(event.categoryName)
          .listen((product) {
        add(LoadProducts(products: product));
      });
    } catch (_) {}
  }
}
