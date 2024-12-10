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

  /* todo: the focus is behaving incorrectly. Every time I click on the
  * text field, the keyboard hides (shows and hides) automatically. It's
  * because of the error message. The outline works properly, but the focus is not.
  *
  * I have tried using key for the text field to not rebuild the focus node, but no change.
  *
  * The event loop is as follows:
  * focus_changed -> emailUnfocused -> validate -> InitState(withError:)
  *
  * Somehow, the error clears not onChange, but on focus. Maybe the field gets
  * rebuild on focus
  *
  * Also, when I click on the password toggle, the keyboard just hides,
  * maybe because the event triggers all page to rebuild
  * 
  */



  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;

  late Key emailTextFieldKey;
  late Key passwordTextFieldKey;

  @override
  void initState() {
    super.initState();

    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();

    emailTextFieldKey = const ValueKey('email');
    passwordTextFieldKey = const ValueKey('password');

    emailFocusNode.addListener(() {
      /// if the focus is changed
      /// and the focus now is not here, since we have left
      /// we do not clear error, but validate the view and show error if exists

      /// if the focus is only begun, we do not need to do anything

      if (!emailFocusNode.hasFocus) {

        context.read<LoginBloc>().add(
          EmailUnfocused(email: emailTextController.text,),
        );

        // todo: while it is suggested in the examples, I am still
        // not sure about the effects of this line.
        FocusScope.of(context).requestFocus(passwordFocusNode);
      }

    });

    passwordFocusNode.addListener(() {

      if (!passwordFocusNode.hasFocus) {

        context.read<LoginBloc>().add(
          PasswordUnfocused(password: passwordTextController.text,),
        );
      }

    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    emailTextController.dispose();
    passwordTextController.dispose();

    super.dispose();
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

                Form(
                  key: GlobalKey<FormState>(),
                  child: Column(
                    children: [

                      // email field
                      BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (previous, current) => current is LoginInitial && previous != current,
                        builder: (context, state) {

                          final emailError = state is LoginInitial ? state.emailError : null;

                          return FormInputField(
                            key: emailTextFieldKey,
                            controller: emailTextController,
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            onChanged: (value) {
                              if (emailError != null) {
                                context.read<LoginBloc>().add(ClearEmailErrors());
                              }
                            },
                            focusNode: emailFocusNode,
                            errorText: emailError,
                            isEnabled: state is !LoginLoading,
                          );
                        }
                      ),

                      const SizedBox(height: 36),

                      // password field
                      BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (previous, current) => current is LoginInitial && previous != current,
                        builder: (context, state) {
                          final passwordError = state is LoginInitial ? state.passwordError : null;
                          final isPasswordObscure = state is LoginInitial ? state.isPasswordObscure : true;

                          return FormInputField(
                            key: passwordTextFieldKey,
                            isObscureText: isPasswordObscure,
                            controller: passwordTextController,
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            errorText: passwordError,
                            isPasswordField: true,
                            maxLength: 10,
                            suffixIcon: FormFieldSuffixIcon(
                              icon: isPasswordObscure ? Icons.visibility_off : Icons.visibility,
                              onPressed: () {
                                context
                                    .read<LoginBloc>()
                                    .add(TogglePasswordVisibility());
                              },
                              tooltip: 'Toggle Password',
                            ),
                            onChanged: (value) {
                              if (passwordError != null) {
                                context.read<LoginBloc>().add(ClearPasswordErrors());
                              }
                            },
                            focusNode: passwordFocusNode,
                            isEnabled: state is !LoginLoading,
                          );
                        }
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // login button
                SplashButton(
                  text: 'Log in',
                  onPressed: state is !LoginLoading ? () {
                    final email = emailTextController.text;
                    final password = passwordTextController.text;

                    // Submit the login event
                    context.read<LoginBloc>().add(LoginSubmitted(email: email, password: password));
                  } : () {},
                  isLoading: state is LoginLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
