import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/features/auth/login/login_screen.dart';
import 'package:evently/features/home/taps/profile/widget/custom_appbar_profile.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/provider/local_provider.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTabScreen extends StatelessWidget {
  const ProfileTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBarProfile(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Language", style: TextStylesHelper.font20BlackBold),
              buildCustomContainer(
                title: localeProvider.locale.languageCode == 'en'
                    ? "English"
                    : "Arabic",
                onTap: () {
                  _showLanguageBottomSheet(context, localeProvider);
                },
              ),
              Text("Theme", style: TextStylesHelper.font20BlackBold),
              buildCustomContainer(
                title: themeProvider.isDarkMode ? "Dark" : "Light",
                onTap: () {
                  _showThemeBottomSheet(context, themeProvider);
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _showLogoutDialog(context, authProvider);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.exit_to_app,
                          color: AppColors.offWhite, size: 25),
                      const SizedBox(width: 10),
                      Text("Logout", style: TextStylesHelper.font18WhiteBold),
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

  void _showLanguageBottomSheet(
      BuildContext context, LocaleProvider localeProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                localeProvider.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text("العربية"),
              onTap: () {
                localeProvider.setLocale(const Locale('ar'));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showThemeBottomSheet(
      BuildContext context, ThemeProvider themeProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode_outlined,
                  color: AppColors.purple),
              title: const Text("Light Mode"),
              onTap: () {
                themeProvider.setDarkMode(false);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.dark_mode_outlined, color: AppColors.purple),
              title: const Text("Dark Mode"),
              onTap: () {
                themeProvider.setDarkMode(true);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                await authProvider.logout();

                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                }
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}

Widget buildCustomContainer(
    {required String title, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: AppColors.purple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(title, style: TextStylesHelper.font20PurpleBold),
          const Spacer(),
          const Icon(Icons.expand_more_rounded, color: AppColors.purple),
        ],
      ),
    ),
  );
}
