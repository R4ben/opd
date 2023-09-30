import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user/user_models.dart';
import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepo;
  final AuthCubit _authCubit;

  LoginBloc({
    required AuthRepository authRepo,
    required AuthCubit authCubit,
  })  : _authRepo = authRepo,
        _authCubit = authCubit,
        super(LoginState()) {
// Username updated
    on<LoginUsernameChanged>(
      (event, emit) {
        emit(state.copyWith(username: event.username));
      },
    );

    // Password updated
    on<LoginPasswordChanged>(
      (event, emit) {
        emit(state.copyWith(password: event.password));
      },
    );

    // Form submitted

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await _authRepo.login(
          email: state.username,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        _authCubit.launchSession(User(
          name: state.username,
          id: userId,
        ));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
