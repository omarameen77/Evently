import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomBottom({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStylesHelper.font20WhiteMedium,
      ),
    );
  }
}
