import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/home/home_screen.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignWithGoogle extends StatelessWidget {
  const SignWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return OutlinedButton(
          style: ButtonStyle(
            minimumSize: const WidgetStatePropertyAll(
              Size(double.infinity, 50),
            ),
            side: WidgetStatePropertyAll(
              BorderSide(
                  color: Theme.of(context).colorScheme.primary, width: 1.5),
            ),
            shape: const WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          onPressed: auth.isLoading
              ? null
              : () async {
                  await auth.signInWithGoogle(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
          child: auth.isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppImage.google, width: 24, height: 24),
                    const SizedBox(width: 10),
                    Text(
                      "Login with Google",
                      style: TextStylesHelper.font20PurpleMedium,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
