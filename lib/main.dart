import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'authenticator/auth/auth_repository.dart';
import 'authenticator/session/session_bloc.dart';
import 'bloc/bloc.dart';
import 'config/config.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'repo/profile/base_profile_repo.dart';
import 'repo/repo.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppProviders());
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
        RepositoryProvider(create: (context) => CategoryRepository()),
        RepositoryProvider(create: (context) => ProductRepository()),
        RepositoryProvider(create: (context) => ProfileRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                SessionBloc(authRepo: context.read<AuthRepository>()),
          ),
          BlocProvider(
              create: (context) => CategoryBloc(
                  categoryRepository: context.read<CategoryRepository>())),
          BlocProvider(
              create: (context) => ProductBloc(
                  categoryBloc: context.read<CategoryBloc>(),
                  productRepository: context.read<ProductRepository>())),
          BlocProvider(create: (context) => CartBloc()..add(CartStarted())),
          BlocProvider(create: (context) => NavigationBloc()),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'One Point Delivery',
          theme: theme(),
          routerDelegate: routes.routerDelegate,
          routeInformationParser: routes.routeInformationParser,
          routeInformationProvider: routes.routeInformationProvider,
        );
      },
    );
  }
}
