import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/onboarding/intro_screen.dart';
import 'package:evently/features/onboarding/widgets/switch_theme_widget.dart';
import 'package:evently/features/onboarding/widgets/swittch_lang_widget.dart';
import 'package:evently/generated/l10n.dart';
import 'package:flutter/material.dart';

class LetsStart extends StatelessWidget {
  const LetsStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(AppImage.horizontalLogo, height: 50)),
              const SizedBox(height: 20),
              Image.asset(AppImage.config),
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).personalizeYourExperience,
                      style: TextStylesHelper.font20PurpleBold,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      S.of(context).personalizeYourExperienceMessage,
                      style: TextStylesHelper.font16semiBold,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SwitchLangWidget(),
              SizedBox(height: 15),
              const SwitchThemeWidget(),
              Spacer(),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => IntroScreen()),
                  );
                },
                child: Text(
                  S.of(context).letsGo,
                  style: TextStylesHelper.font20WhiteMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
