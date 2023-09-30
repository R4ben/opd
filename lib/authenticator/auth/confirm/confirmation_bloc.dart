import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';

part 'confirmation_event.dart';
part 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(ConfirmationState()) {
    // Confirmation code updated
    on<ConfirmationCodeChanged>((event, emit) {
      emit(state.copyWith(code: event.code));
    });

// Form submitted
    on<ConfirmationCodeChanged>((event, emit) {
      emit(state.copyWith(code: event.code));
    });

    on<ConfirmationSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await authRepo.confirmSignUp(
          username: authCubit.user.name!,
          confirmationCode: state.code,
        );
        print(userId);
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        final credentials = authCubit.user;
        credentials.copyWith(id: userId);
        print(credentials);
        authCubit.launchSession(credentials);
      } on Exception catch (e) {
        print(e);
        emit(state.copyWith(formStatus: SubmissionFailed(e)));
      }
    });
  }
}
