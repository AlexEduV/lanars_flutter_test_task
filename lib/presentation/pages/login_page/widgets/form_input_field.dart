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
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool isEnabled;
  final TextInputType? keyboardType;

  const FormInputField({
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.focusNode,
    this.onChanged,
    this.maxLength = 30,
    this.suffixIcon,
    this.isPasswordField = false,
    this.isObscureText = false,
    this.isEnabled = true,
    this.errorText,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          errorText: getErrorText(errorText),
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant
          ),
          label: Text(
            labelText,
            style: TextStyle(
              color: getLabelColor(context),
            ),
          ),
          counterText: "",
          suffixIcon: suffixIcon,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        maxLength: maxLength,
        textInputAction: TextInputAction.next,
        controller: controller,
        obscureText: isObscureText,
        enableSuggestions: !isPasswordField,
        autocorrect: !isPasswordField,
        enableInteractiveSelection: isPasswordField,
        onChanged: onChanged,
        enabled: isEnabled,
        keyboardType: keyboardType,
      ),
    );
  }

  Color getLabelColor(BuildContext context) {

    if (errorText != null && errorText != '') {
      return Theme.of(context).colorScheme.error;
    }

    if (!focusNode.hasFocus) {
      return Theme.of(context).colorScheme.onSurfaceVariant;
    }

    return Theme.of(context).colorScheme.primary;

  }

  String? getErrorText(String? errorText) {

    if (errorText == '') {
      return null;
    }
    else {
      return errorText;
    }
  }
}
