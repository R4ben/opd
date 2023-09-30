import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user/user_models.dart';
import '../session/session_bloc.dart';


enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionBloc sessionBloc;

  AuthCubit({required this.sessionBloc}) : super(AuthState.login);

  late User user;

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    user = User(
      name: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmSignUp);
  }

  void launchSession(User user) => sessionBloc.add(SessionUserChange(user));
}
