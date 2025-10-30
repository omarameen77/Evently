import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/auth/sign_up/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  const DontHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "Don't have account? ",
        style: TextStylesHelper.font16semiBold,
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            text: 'Create Account',
            style: TextStylesHelper.font16PurpleBold,
          ),
        ],
      ),
    );
  }
}
