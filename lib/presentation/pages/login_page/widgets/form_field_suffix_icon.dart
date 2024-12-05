import 'package:flutter/material.dart';

class FormFieldSuffixIcon extends StatelessWidget {

  final IconData icon;
  final VoidCallback onPressed;
  final String tooltip;

  const FormFieldSuffixIcon({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        icon,
      ),
      iconSize: 24,
      color: Theme.of(context).colorScheme.primary,
      onPressed: onPressed,
      tooltip: tooltip,
    );
  }
}
