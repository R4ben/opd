part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class Authenticated extends SessionState {
  final user_model.User user;
  const Authenticated({required this.user});
  @override
  List<Object> get props => [user];
}

class Unauthenticated extends SessionState {
  final user_model.User user = user_model.User.empty;
  @override
  List<Object> get props => [user];
}
