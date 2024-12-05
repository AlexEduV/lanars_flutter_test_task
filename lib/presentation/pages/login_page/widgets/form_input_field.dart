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
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: TextFormField(
        focusNode: focusNode,
        decoration: InputDecoration(
          errorText: errorText,
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
        onChanged: onChanged,
      ),
    );
  }
}
