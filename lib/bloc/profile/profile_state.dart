part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final FormSubmissionStatus formStatus;
  final bool imageSourceActionSheetisVisible;
  const ProfileLoaded({
    required this.profile,
    this.formStatus = const InitialFormStatus(),
    this.imageSourceActionSheetisVisible = false,
  });
  ProfileLoaded copyWith({
    String? id,
    String? email,
    String? name,
    String? photo,
    String? phone,
    String? address,
    String? notes,
    FormSubmissionStatus? formStatus = const InitialFormStatus(),
    bool? imageSourceActionSheetisVisible = false,
  }) =>
      ProfileLoaded(
        profile: Profile(
          id: id ?? profile.id,
          email: email ?? profile.email,
          name: name ?? profile.name,
          photo: photo ?? profile.photo,
          phone: phone ?? profile.phone,
          notes: notes ?? profile.notes,
        ),
        formStatus: formStatus ?? this.formStatus,
        imageSourceActionSheetisVisible: imageSourceActionSheetisVisible ??
            this.imageSourceActionSheetisVisible,
      );

  @override
  List<Object?> get props => [
        profile,
        formStatus,
        imageSourceActionSheetisVisible,
      ];
}
