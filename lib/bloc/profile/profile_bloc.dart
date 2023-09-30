import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../authenticator/auth/form_submission_status.dart';
import '../../authenticator/models/user/user_models.dart';
import '../../model/profile.dart';
import '../../repo/profile/base_profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // final SessionBloc _sessionBloc;
  late StreamSubscription? profileSubscription;
  final _picker = ImagePicker();
  ProfileBloc({required User user, required ProfileRepository profileRepo})
      : super(ProfileLoading()) {
    profileSubscription =
        profileRepo.getProfile(userId: user.id).listen((profile) {
      add(ProfileChanged(profile: profile));
    });
    on<ProfileChanged>((event, emit) {
      emit(
        ProfileLoaded(
            profile: Profile(
          id: user.id,
          email: event.profile.email,
          name: event.profile.name,
          notes: event.profile.notes,
          phone: event.profile.phone,
          photo: event.profile.photo,
        )),
      );
    });
    on<ChangeAvatarRequest>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(state.copyWith(imageSourceActionSheetisVisible: true));
      }
    });
    on<OpenImagePiker>((event, emit) async {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(state.copyWith(imageSourceActionSheetisVisible: false));
        final pickImage = await _picker.pickImage(source: event.imageSource);
        if (pickImage == null) return;
        String img = await profileRepo.uploadFile(File(pickImage.path));
        profileRepo.updateProfilePhoto(img, state.profile.id!);
        if (state.profile.photo != "") {
          profileRepo.removePhoto(state.profile.photo!);
        }
      }
    });
    on<ProvideImagePath>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(state.copyWith(photo: event.avatarpath));
      }
    });
    on<ProfileDscriptionChanged>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(state.copyWith(notes: event.description));
      }
    });
    on<ProfileNameChanged>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        print(event.userName);
        emit(state.copyWith(name: event.userName));
      }
    });

    on<ProfilePhoneChanged>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        emit(state.copyWith(phone: event.phone));
      }
    });
    on<SaveProfileChanges>((event, emit) {
      if (state is ProfileLoaded) {
        var state = this.state as ProfileLoaded;
        switch (event.fieldToUpdate) {
          case FieldToUpdate.name:
            profileRepo.updateProfileName(
                userId: state.profile.id!, userName: state.profile.name!);
            break;
          default:
        }
      }
    });
  }
}
