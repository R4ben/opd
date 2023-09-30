import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/app_text_field.dart';
import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';
import 'login_bloc.dart';

class LoginView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Image.asset(
                width: 300.w,
                'assets/OnPointDelivery.png',
              ),
              SizedBox(height: 0.09.sh),
              _loginForm(),
              SizedBox(height: 0.2.sh),
              _showSignUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                SizedBox(height: 20.h),
                _passwordField(),
                SizedBox(height: 20.h),
                _loginButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      TextEditingController textController = TextEditingController();
      return AppTextField(
          key: const Key('oi'),
          textController: textController,
          hintText: 'E-mail',
          icon: Icons.mail_outlined,
          onChanged: (value) => context.read<LoginBloc>().add(
                LoginUsernameChanged(username: value),
              ),
          validator: (value) =>
              state.isValidUsername ? null : 'Email muito curto');
      // TextFormField(
      //   decoration: const InputDecoration(
      //     icon: Icon(Icons.person),
      //     hintText: 'Username',
      //   ),
      //   validator: (value) =>
      //       state.isValidUsername ? null : 'Username is too short',
      //   onChanged: (value) => context.read<LoginBloc>().add(
      //         LoginUsernameChanged(username: value),
      //       ),
      // );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      TextEditingController passwordtController = TextEditingController();
      return AppTextField(
        isObscure: true,
        key: const Key('password'),
        textController: passwordtController,
        hintText: 'Palavra Passe',
        icon: Icons.key_outlined,
        onChanged: (value) => context.read<LoginBloc>().add(
              LoginPasswordChanged(password: value),
            ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password muito curto',
      );

      // TextFormField(
      //   obscureText: true,
      //   decoration: const InputDecoration(
      //     icon: Icon(Icons.security),
      //     hintText: 'Password',
      //   ),
      //   validator: (value) =>
      //       state.isValidPassword ? null : 'Password is too short',
      //   onChanged: (value) => context.read<LoginBloc>().add(
      //         LoginPasswordChanged(password: value),
      //       ),
      // );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                }
              },
              child: const Text('Login'),
            );
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text('Ainda não tem uma conta? Cria uma.'),
        onPressed: () => context.read<AuthCubit>().showSignUp(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
