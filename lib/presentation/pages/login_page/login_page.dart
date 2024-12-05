import 'package:flutter/material.dart';
import 'package:lanars_flutter_test_task/data/services/dio_client.dart';
import 'package:lanars_flutter_test_task/data/storage/global_mock_storage.dart';
import 'package:lanars_flutter_test_task/domain/models/custom_form_data.dart';
import 'package:lanars_flutter_test_task/domain/usecases/validate_form_usecase.dart';
import 'package:lanars_flutter_test_task/presentation/pages/home_page/home_page.dart';
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

  bool isObscurePasswordText = true;

  String? emailErrorText;
  String? passwordErrorText;

  bool isRequestLoading = false;


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
      body: SingleChildScrollView(
        child: Column(
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
                    isEnabled: !isRequestLoading,
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
                    isEnabled: !isRequestLoading,
                  ),

                ],
              ),
            ),

            const SizedBox(
              height: 36,
            ),

            //log in button
            SplashButton(
              text: 'Log in',
              onPressed: onSubmit,
              isLoading: isRequestLoading,
            ),

          ],
        ),
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

  void onSubmit() async {

    final email = emailTextController.text;
    final password = passwordTextController.text;

    //revalidate inputs
    emailErrorText = validateEmail(email);
    passwordErrorText = validatePassword(password);

    if (emailErrorText != null && passwordErrorText != null) {
      setState(() {});
      return;
    }

    //change UI to loading; disable inputs and a button
    setState(() {
      isRequestLoading = true;
    });

    //send a request
    final result = await DioClient.submitForm(
      CustomFormData(email: email, password: password).toMap(),
    );
    debugPrint(result);

    final userResult = await DioClient.getRandomUser();
    //debugPrint(userResult);

    setState(() {
      isRequestLoading = false;
    });

    if (GlobalMockStorage.user.firstName.isEmpty) {
      //operation is unsuccessful;

      //show message to the user
      final snackBar = SnackBar(content: Text(userResult));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else {
      //operation successful
      //navigate to the next screen
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),),);
    }

  }
}
