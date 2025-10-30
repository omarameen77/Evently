import 'package:evently/core/consts/app_image.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/auth/login/login_screen.dart';
import 'package:evently/features/onboarding/widgets/custom_pageIntro.dart';
import 'package:evently/generated/l10n.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController();
    final ThemeProvider themeProvider = ThemeProvider();

  bool onLastPage = false;
  bool onFirstPage = true;

  // go to next page

  void nextPage() {
    controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  // go to previous page

  void prevPage() {
    controller.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  // list of pages

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> pages = [
      {
        "image": AppImage.trending,
        "title": Text(
          S.of(context).findEventsThatInspireYou,
          style: TextStylesHelper.font20PurpleBold,
        ),
        "titleMassage": Text(
          S.of(context).findEventsThatInspireYouMessage,
          style: TextStylesHelper.font16semiBold,
        ),
      },
        {
        "image": AppImage.trending,
        "title": Text(
          S.of(context).effortlessEventPlanning,
          style: TextStylesHelper.font20PurpleBold,
        ),
        "titleMassage": Text(
          S.of(context).effortlessEventPlanningMessage,
          style: TextStylesHelper.font16semiBold,
        ),
      },
      {
        "image": AppImage.being,
        "title": Text(
          S.of(context).connectWithFriendsAndShareMoments,
          style: TextStylesHelper.font20PurpleBold,
        ),
        "titleMassage": Text(
          S.of(context).connectWithFriendsAndShareMomentsMessage,
          style: TextStylesHelper.font16semiBold,
        ),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(AppImage.horizontalLogo, height: 50),
              ),
              // page view
              Directionality(
                textDirection: TextDirection.ltr,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      onLastPage = (index == pages.length - 1);
                      onFirstPage = (index == 0);
                    });
                  },
                  itemBuilder: (context, index) {
                    return CustomPageIntro(
                      centerImage: pages[index]["image"],
                      title: pages[index]["title"],
                      titleMassage: pages[index]["titleMassage"],
                    );
                  },
                ),
              ),
              /// Indicators + Buttons
              Container(
                alignment: const Alignment(0, 0.99),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      onFirstPage
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () => prevPage(),
                              child: Text(S.of(context).back),
                            ),
                      // dot indicators
                      SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: WormEffect(
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          dotColor:themeProvider.isDarkMode? AppColors.offWhite: AppColors.black,
                          activeDotColor: AppColors.purple
                        ),
                      ),

                      onLastPage
                          ? GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginScreen()));
                              },
                              child: Text(S.of(context).done),
                            )
                          : GestureDetector(
                              onTap: () => nextPage(),
                              child: Text(S.of(context).next),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
