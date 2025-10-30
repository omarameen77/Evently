import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/auth/sign_up/widget/sign_form_faild.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(AppImage.logo,
                        fit: BoxFit.contain, width: 150, height: 150)),
                const SizedBox(height: 20),
                // Sign form field
                SignFormField(),

                SizedBox(height: 20),
                // Already have an account? Login
                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStylesHelper.font16semiBold,
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                        text: 'Login',
                        style: TextStylesHelper.font16PurpleBold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
