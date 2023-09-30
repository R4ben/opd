part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

enum FieldToUpdate { name, phone, email, bio }

class ProfileChanged extends ProfileEvent {
  final Profile profile;
  const ProfileChanged({required this.profile});
}

class ChangeAvatarRequest extends ProfileEvent {}

class OpenImagePiker extends ProfileEvent {
  final ImageSource imageSource;
  const OpenImagePiker({required this.imageSource});
}

class ProvideImagePath extends ProfileEvent {
  final String avatarpath;
  const ProvideImagePath({required this.avatarpath});
  @override
  List<Object> get props => [avatarpath];
}

class ProfileDscriptionChanged extends ProfileEvent {
  final String description;
  const ProfileDscriptionChanged({required this.description});
  @override
  List<Object> get props => [description];
}

class ProfileNameChanged extends ProfileEvent {
  final String userName;
  const ProfileNameChanged({required this.userName});
  @override
  List<Object> get props => [userName];
}

class ProfilePhoneChanged extends ProfileEvent {
  final String phone;
  const ProfilePhoneChanged({required this.phone});
  @override
  List<Object> get props => [phone];
}

class SaveProfileChanges extends ProfileEvent {
  final FieldToUpdate fieldToUpdate;
  const SaveProfileChanges({required this.fieldToUpdate});
}
