import 'package:evently/core/consts/app_image.dart';
import 'package:evently/features/auth/login/widget/dont_have_account.dart';
import 'package:evently/features/auth/login/widget/login_form_widget.dart';
import 'package:evently/features/auth/login/widget/or_connect_with.dart';
import 'package:evently/features/auth/login/widget/sign_with_google.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Center Logo
                Center(
                    child: Image.asset(AppImage.logo,
                        fit: BoxFit.contain, width: 150, height: 150)),
                SizedBox(height: 24),
                LoginFormWidget(),

                SizedBox(height: 24),
                DontHaveAccount(),
                SizedBox(height: 24),
                OrConnectWith(),
                SizedBox(height: 24),
                SignWithGoogle()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
