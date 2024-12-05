import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {

  final String hintText;
  final int maxLength;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final bool isObscureText;

  const FormInputField({
    required this.hintText,
    required this.controller,
    this.maxLength = 20,
    this.suffixIcon,
    this.isPasswordField = false,
    this.isObscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 48, left: 48),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          label: Text(
            hintText,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          counterText: "",
          suffixIcon: suffixIcon,
        ),
        maxLength: maxLength,
        textInputAction: TextInputAction.next,
        controller: controller,
        obscureText: isObscureText,
        enableSuggestions: !isPasswordField,
        autocorrect: !isPasswordField,
        enableInteractiveSelection: isPasswordField,
      ),
    );
  }
}
