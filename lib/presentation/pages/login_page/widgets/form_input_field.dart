import 'package:flutter/material.dart';

class FormInputField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final FocusNode focusNode;
  final int maxLength;
  final Widget? suffixIcon;
  final bool isPasswordField;
  final bool isObscureText;

  const FormInputField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.focusNode,
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
        focusNode: focusNode,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
          label: Text(
            labelText,
            style: TextStyle(
              color: focusNode.hasFocus
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
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
