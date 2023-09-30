part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object> get props => [];
}

class SessionLogOutRequest extends SessionEvent {}

class UpdateUserName extends SessionEvent {
  final String userName;
  const UpdateUserName({required this.userName});

  @override
  List<Object> get props => [userName];
}

class UpdateUserPhone extends SessionEvent {
  final String phone;
  const UpdateUserPhone({required this.phone});

  @override
  List<Object> get props => [phone];
}

class SessionUserChange extends SessionEvent {
  final user_model.User user;
  const SessionUserChange(this.user);

  @override
  List<Object> get props => [user];
}
