import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/domain/validate_form_usecase.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_field_suffix_icon.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_input_field.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/splash_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isObscurePasswordText = false;

  String? emailErrorText;
  String? passwordErrorText;


  @override
  void initState() {
    super.initState();
    
    emailFocusNode.addListener(() {

      emailErrorText = validateEmail(emailTextController.text);
      setState(() {});

    });

    passwordFocusNode.addListener(() {

      passwordErrorText = validatePassword(passwordTextController.text);
      setState(() {});

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [

          const SizedBox(
            height: 180,
          ),

          Text(
            'Sign in',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.w400,
              fontSize: 32,
              height: 40 / 32
            ),
          ),

          const SizedBox(height: 72,),

          //email field
          Form(
            key: _formKey,
            child: Column(
              children: [

                FormInputField(
                  controller: emailTextController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  focusNode: emailFocusNode,
                  errorText: emailErrorText,
                  onChanged: (value) {
                    setState(() {
                      emailErrorText = null;
                    });
                  },
                ),

                const SizedBox(
                  height: 36,
                ),

                //password field
                FormInputField(
                  controller: passwordTextController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  focusNode: passwordFocusNode,
                  errorText: passwordErrorText,
                  isPasswordField: true,
                  isObscureText: isObscurePasswordText,
                  maxLength: 10,
                  suffixIcon: FormFieldSuffixIcon(
                    icon: isObscurePasswordText ? Icons.visibility_off : Icons.visibility_sharp,
                    onPressed: togglePassword,
                    tooltip: 'Toggle Password',
                  ),
                  onChanged: (value) {
                    setState(() {
                      passwordErrorText = null;
                    });
                  },
                ),

              ],
            ),
          ),

          const SizedBox(
            height: 36,
          ),

          //log in button
          SplashButton(text: 'Log in', onPressed: () {}),

        ],
      ),
    );
  }

  @override
  void dispose() {

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  void togglePassword() {
    setState(() => isObscurePasswordText = !isObscurePasswordText);
  }

  void onSubmit() {

    final email = emailTextController.text;
    final password = passwordTextController.text;

    //revalidate inputs
    emailErrorText = validateEmail(email);
    passwordErrorText = validatePassword(password);

    if (emailErrorText != null && passwordErrorText != null) {
      setState(() {});
    }

    //the form is valid

    //change UI to loading;
    //send a request
    //put response to the global variables


  }
}
