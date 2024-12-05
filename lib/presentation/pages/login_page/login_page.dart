import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_field_suffix_icon.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool isObscurePasswordText = false;

  @override
  void initState() {
    super.initState();
    
    emailFocusNode.addListener(() {
      setState(() {});
    });

    passwordFocusNode.addListener(() {
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
          FormInputField(
            controller: emailTextController,
            hintText: 'Enter your email',
            labelText: 'Email',
            focusNode: emailFocusNode,
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
            isPasswordField: true,
            isObscureText: isObscurePasswordText,
            suffixIcon: FormFieldSuffixIcon(
              icon: isObscurePasswordText ? Icons.visibility_off : Icons.visibility_sharp,
              onPressed: togglePassword,
              tooltip: 'Toggle Password',
            ),
          ),

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
}
