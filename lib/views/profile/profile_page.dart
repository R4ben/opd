import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../authenticator/session/session_bloc.dart';
import '../../bloc/bloc.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/perfil_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded && state.imageSourceActionSheetisVisible) {
          _showImageSourceActionSheet(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: Text(
              'Perfil',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: Colors.white),
            )),
        body: Column(
          children: [
            _profileAvatar(context),
            SizedBox(width: 10.h),
            _changeAvatarButton(context),
            SizedBox(height: 30.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Column(
                    children: [
                      // name
                      _profileName(context),
                      SizedBox(height: 20.h),
                      // phone
                      _profilePhone(),
                      SizedBox(height: 20.h),
                      // email
                      _profileEmail(),
                      SizedBox(height: 20.h),
                      // address
                      _profileAddress(),
                      SizedBox(height: 20.h),
                      // bio
                      _profileNote(),
                      SizedBox(height: 20.h),
                      SizedBox(height: 20.h),
                      _profileLogOut(context),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _changeAvatarButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<ProfileBloc>().add(ChangeAvatarRequest());
      },
      child: Text('Mudar Imagem'),
    );
  }

  Widget _profileAvatar(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        return Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 20.h),
            child: Center(
              child: CircleAvatar(
                  radius: 75.r,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  backgroundImage:
                      CachedNetworkImageProvider(state.profile.photo ?? '')),
            ));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  GestureDetector _profileLogOut(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SessionBloc>().add(SessionLogOutRequest());
      },
      child: AccountWidget(
        appIcons: AppIcons(
          icon: Icons.logout_outlined,
          backgroundColor: Colors.red,
          iconColor: Colors.white,
          iconSize: 25.r,
          size: 50.r,
        ),
        text: 'Sair',
        color: Colors.red,
      ),
    );
  }

  _profileNote() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return AccountWidget(
            appIcons: AppIcons(
              icon: Icons.message_outlined,
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconColor: Colors.white,
              iconSize: 25.r,
              size: 50.r,
            ),
            text: state.profile.notes ?? 'Bio',
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _profileAddress() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () =>
              context.read<NavigationBloc>().add(NavigateToAddressPage()),
          child: AccountWidget(
            appIcons: AppIcons(
              icon: Icons.location_on_outlined,
              backgroundColor: Theme.of(context).colorScheme.primary,
              iconColor: Colors.white,
              iconSize: 25.r,
              size: 50.r,
            ),
            text: 'Endereços',
          ),
        );
      },
    );
  }

  _profileEmail() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return AccountWidget(
              appIcons: AppIcons(
                icon: Icons.mail_outline,
                backgroundColor: Theme.of(context).colorScheme.primary,
                iconColor: Colors.white,
                iconSize: 25.r,
                size: 50.r,
              ),
              text: state.profile.email ?? 'E-mail');
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  _profileName(BuildContext context) {
    const String title = "Alterar nome de usuario";
    const String label = "Insira um novo nome de usuario";
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          String value = state.profile.name ?? "";
          return GestureDetector(
            onTap: () {
              context.push('/profile/profileEditor/$title/$label/$value/name');
            },
            child: AccountWidget(
              appIcons: AppIcons(
                icon: Icons.person_outline,
                backgroundColor: Theme.of(context).colorScheme.primary,
                iconColor: Colors.white,
                iconSize: 25.r,
                size: 50.r,
              ),
              text: state.profile.name ?? 'Nome',
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _profilePhone() {
    const String title = "Alterar numero de telefone";
    const String label = "Insira um novo numero de telefone";
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          String value = state.profile.phone ?? "Phone";
          return GestureDetector(
            onTap: () => context
                .push('/profile/profileEditor/$title/$label/$value/phone'),
            child: AccountWidget(
              appIcons: AppIcons(
                icon: Icons.phone_outlined,
                backgroundColor: Theme.of(context).colorScheme.primary,
                iconColor: Colors.white,
                iconSize: 25.r,
                size: 50.r,
              ),
              text: value,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    Function(ImageSource) selectImageSource = (imageSouce) {
      context.read<ProfileBloc>().add(OpenImagePiker(imageSource: imageSouce));
    };
    if (Platform.isIOS) {
      showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                      selectImageSource(ImageSource.camera);
                    },
                    child: Text('Camera'),
                  ),
                  CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                        selectImageSource(ImageSource.gallery);
                      },
                      child: Text('Galeria'))
                ],
              ));
    } else {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: Icon(Icons.camera_alt_outlined),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.camera);
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_album_outlined),
            title: Text('Galeria'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }
}
