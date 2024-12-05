import 'package:flutter/material.dart';

class SplashButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const SplashButton({
    required this.text,
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100,),
          ),
          minimumSize: const Size.fromHeight(40.0),
        ),
        onPressed: !isLoading ? onPressed : () {},
        child: !isLoading ? Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
            color: Colors.white,
          ),
        ) : const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(color: Colors.white,),
        ),
      ),
    );
  }
}
