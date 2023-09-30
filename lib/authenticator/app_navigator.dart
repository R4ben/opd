import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../repo/profile/base_profile_repo.dart';
import '../views/profile/profile_page.dart';
import 'auth/auth_cubit.dart';
import 'auth/auth_navigator.dart';
import 'session/session_bloc.dart';
//import 'loading_view.dart';

class SessionNavigator extends StatelessWidget {
  const SessionNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          //Show loading screen
          // if (state is Unauthenticated) const MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionBloc: context.read<SessionBloc>()),
                child: const AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated)
            MaterialPage(
                child: BlocProvider(
              create: (context) => ProfileBloc(
                  profileRepo: context.read<ProfileRepository>(),
                  user: context.read<SessionBloc>().user),
              child: const ProfilePage(),
            ))
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
