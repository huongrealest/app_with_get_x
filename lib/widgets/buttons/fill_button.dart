import 'package:flutter/material.dart';

class FillButton extends StatelessWidget {
  const FillButton({super.key, this.onPressed, required this.title});

  final Function()? onPressed;

  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
