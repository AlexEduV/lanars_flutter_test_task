import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/presentation/pages/login_page/widgets/form_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

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
            ),
          ),

          //text fields
          FormInputField(
            hintText: 'Enter your email',
            controller: emailTextController,
          )

        ],
      ),
    );
  }
}
