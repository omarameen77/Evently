import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              AppImage.resetPassword,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {},
              child: Text(
                'Reset Password',
                style: TextStylesHelper.font20WhiteMedium,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
