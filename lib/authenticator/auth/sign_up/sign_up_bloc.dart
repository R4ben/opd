import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';
part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState()) {
    // Username updated
    on<SignUpUsernameChanged>((event, emit) {
      emit(state.copyWith(username: event.username));
    });
    // Email updated
    on<SignUpEmailChanged>(
      (event, emit) {
        emit(state.copyWith(email: event.email));
      },
    );
    // Password updated
    on<SignUpPasswordChanged>(
      (event, emit) {
        emit(state.copyWith(password: event.password));
      },
    );

    // Form submitted
    on<SignUpSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formStatus: FormSubmitting()));

        try {
          await authRepo.signUp(
            email: state.email,
            password: state.password,
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));

          authCubit.showConfirmSignUp(
            username: state.username,
            email: state.email,
            password: state.password,
          );
        } on Exception catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(e)));
        }
      },
    );
  }
}
