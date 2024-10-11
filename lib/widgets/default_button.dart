import 'package:flutter/material.dart';

class AppDefaultButton extends StatelessWidget {
  const AppDefaultButton(
      {super.key,
      required this.bgColor,
      required this.onPressed,
      required this.content});

  final Color bgColor;
  final VoidCallback onPressed;
  final Widget content;
  //int? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 75,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            elevation: (bgColor == Colors.transparent) ? 0 : 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          child: content),
    );
  }
}
