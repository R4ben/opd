import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc.dart';
import 'profile_editor.dart';

class PhoneEditor extends StatelessWidget {
  PhoneEditor({super.key});
  late String name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        String initialValue = state.profile.phone!;
        return ProfileEditorPage(
          title: 'Alterar numero de telefone',
          onPressed: () => context
              .read<ProfileBloc>()
              .add(ProfilePhoneChanged(phone: name)),
          widgets: [
            TextFormField(
              onChanged: (value) {
                name = value;
              },
              autofocus: true,
              initialValue: initialValue,
              decoration: const InputDecoration(icon: Icon(Icons.phone_outlined)),
            )
          ],
        );
      } else {
        return ProfileEditorPage(
          title: 'Alterar numero de telefone',
          onPressed: () {},
          widgets: [
            const Center(
              child: Text("Algo deu errado"),
            )
          ],
        );
      }
    });
  }
}
