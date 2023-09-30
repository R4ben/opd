import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/widgets.dart';
import '../auth_cubit.dart';
import '../auth_repository.dart';
import '../form_submission_status.dart';
import 'sign_up_bloc.dart';

class SignUpView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Image(
                width: 300.w,
                image: const AssetImage('assets/OnPointDelivery.png'),
              ),
              SizedBox(height: 0.09.sh),
              _signUpForm(),
              SizedBox(height: 0.2.sh),
              _showLoginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // _usernameField(),
                // SizedBox(height: 20.h),
                _emailField(),
                SizedBox(height: 20.h),
                _passwordField(),
                SizedBox(height: 20.h),
                _signUpButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpUsernameChanged(username: value),
            ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      TextEditingController textController = TextEditingController();
      return AppTextField(
        textController: textController,
        hintText: 'E-mail',
        icon: Icons.mail_outlined,
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(email: value),
            ),
        validator: (value) => state.isValidEmail ? null : 'E-mail invalido',
      );
      // TextFormField(
      //   decoration: const InputDecoration(
      //     icon: Icon(Icons.person),
      //     hintText: 'Email',
      //   ),
      //   validator: (value) => state.isValidUsername ? null : 'Invalid email',
      //   onChanged: (value) => context.read<SignUpBloc>().add(
      //         SignUpEmailChanged(email: value),
      //       ),
      // );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      TextEditingController textController = TextEditingController();
      return AppTextField(
        key: const Key('pass'),
        hintText: 'Palavra Passe',
        icon: Icons.key_outlined,
        textController: textController,
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordChanged(password: value),
            ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password muito Curto',
      );
      // return TextFormField(
      //   obscureText: true,
      //   decoration: const InputDecoration(
      //     icon: Icon(Icons.security),
      //     hintText: 'Password',
      //   ),
      //   validator: (value) =>
      //       state.isValidPassword ? null : 'Password is too short',
      //   onChanged: (value) => context.read<SignUpBloc>().add(
      //         SignUpPasswordChanged(password: value),
      //       ),
      // );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: const Text('Registrar'),
            );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text('Já tem uma conta? Faça Login'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
