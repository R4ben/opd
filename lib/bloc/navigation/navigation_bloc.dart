import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/models.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(ShowSplashScreen()) {
    on<NavigateToMainPage>((event, emit) {
      emit(ShowHomePage());
    });
    on<NavigateToProductDetailsPage>((event, emit) {
      emit(ShowProductDetailsPage(product: event.product));
    });
    on<NavigateToCartPage>((event, emit) {
      emit(ShowCartPage());
    });
    on<NavigateToAddressPage>((event, emit) {
      emit(ShowAddressPage());
    });
    on<NavigateToCategoryPage>((event, emit) {
      emit(ShowCategoryPage(category: event.category));
    });
  }
}
