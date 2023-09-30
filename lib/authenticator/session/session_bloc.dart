import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/user/user_models.dart' as user_model;

import '../auth/auth_repository.dart';
part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthRepository _authRepo;
  late StreamSubscription<user_model.User> _userSubscription;
  user_model.User get user => (state as Authenticated).user;
  SessionBloc({required AuthRepository authRepo})
      : _authRepo = authRepo,
        super(
          authRepo.currentUser.isNotEmpty
              ? Authenticated(user: authRepo.currentUser)
              : Unauthenticated(),
        ) {
    on<SessionLogOutRequest>(_onLogOutRequest);

    on<SessionUserChange>(_onUserChanged);
    on<UpdateUserName>(_onUserNameUpadate);
    on<UpdateUserPhone>(_onUserPhoneUpadate);

    _userSubscription = _authRepo.user.listen(
      (user) => add(SessionUserChange(user)),
    );
  }
  Future<void> _onUserNameUpadate(
      UpdateUserName event, Emitter<SessionState> emit) async {
    if (state is Authenticated) {
      try {
        await _authRepo.updateUserName(event.userName);
      } catch (_) {}
    }
  }

  void _onUserChanged(SessionUserChange event, Emitter<SessionState> emit) {
    emit(event.user.isNotEmpty
        ? Authenticated(user: event.user)
        : Unauthenticated());
  }

  void _onLogOutRequest(
      SessionLogOutRequest event, Emitter<SessionState> emit) {
    unawaited(_authRepo.signOut());
  }

  @override
  Future<void> close() async {
    super.close();
    _userSubscription.cancel();
  }

  _onUserPhoneUpadate(UpdateUserPhone event, Emitter<SessionState> emit) async {
    if (state is Authenticated) {
      try {
        await _authRepo.updateUserName(event.phone);
      } catch (_) {}
    }
  }
}
