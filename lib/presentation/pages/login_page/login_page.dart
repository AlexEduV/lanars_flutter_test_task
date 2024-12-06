import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/home_page.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_blocs.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_events.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/blocs/login_states.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_field_suffix_icon.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_input_field.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/splash_button.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailFocusNode.addListener(() {

      debugPrint('email focus changed');

      context.read<LoginBloc>().add(
        EmailFocusChanged(
          isFocused: emailFocusNode.hasFocus,
          email: emailTextController.text,
        ),
      );

    });

    passwordFocusNode.addListener(() {

      context.read<LoginBloc>().add(
        PasswordFocusChanged(
          isFocused: passwordFocusNode.hasFocus,
          password: passwordTextController.text,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            // Show failure message
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is LoginSuccess) {
            // Navigate to next screen on success
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 180),
                Text(
                  'Sign in',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w400,
                    fontSize: 32,
                    height: 40 / 32,
                  ),
                ),
                const SizedBox(height: 72),

                // email field
                Form(
                  key: GlobalKey<FormState>(),
                  child: Column(
                    children: [
                      FormInputField(
                        controller: emailTextController,
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        onChanged: (value) {
                          context.read<LoginBloc>().add(ClearErrors());
                        },
                        focusNode: emailFocusNode,
                      ),
                      const SizedBox(height: 36),

                      // password field
                      FormInputField(
                        controller: passwordTextController,
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        isPasswordField: true,
                        maxLength: 10,
                        suffixIcon: FormFieldSuffixIcon(
                          icon: Icons.visibility_off,
                          onPressed: () {
                            context.read<LoginBloc>().add(TogglePasswordVisibility());
                          },
                          tooltip: 'Toggle Password',
                        ),
                        onChanged: (value) {
                          context.read<LoginBloc>().add(ClearErrors());
                        },
                        focusNode: passwordFocusNode,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // login button
                SplashButton(
                  text: 'Log in',
                  onPressed: () {
                    final email = emailTextController.text;
                    final password = passwordTextController.text;

                    // Submit the login event
                    context.read<LoginBloc>().add(LoginSubmitted(email: email, password: password));
                  },
                  isLoading: state is LoginLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }
}
