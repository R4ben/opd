import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_point_delivery/bloc/bloc.dart';
import 'package:on_point_delivery/views/profile/profile_editor.dart';

class NameEditor extends StatelessWidget {
    NameEditor({super.key});
   late String name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        String initialValue = state.profile.name!;
        return ProfileEditorPage(
          title: 'Nome de usuário',
          onPressed: ()=>context.read<ProfileBloc>().add(ProfileNameChanged(userName: name)),
          widgets: [
            TextFormField(
	      onChanged: (value){name=value;},
              autofocus: true,
              initialValue: initialValue,
              decoration: InputDecoration(icon: Icon(Icons.person_outlined)),
            )
          ],
        );
      } else {
        return ProfileEditorPage(
          title: 'Nome de usuário',
          onPressed: () {},
          widgets: [
            Center(
              child: Text("Algo deu errado"),
            )
          ],
        );
      }
    });
  }
}
