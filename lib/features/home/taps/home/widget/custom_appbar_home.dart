import 'package:evently/features/home/taps/home/widget/custom_tabs_bottom.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:evently/provider/local_provider.dart';
import 'package:evently/provider/theme_provider.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localProvider = Provider.of<LocaleProvider>(context);
    final eventListProvider = Provider.of<EventListProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    bool isEnglish = localProvider.locale.languageCode == 'en';

    String userName = authProvider.user?.displayName ??
        authProvider.user?.email?.split('@')[0] ??
        'Guest';

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode
              ? AppColors.darkPurple
              : AppColors.purple,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back ✨",
                        style: const TextStyle(color: AppColors.offWhite),
                      ),
                      Text(
                        userName,
                        style: TextStylesHelper.font20WhiteBold,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.offWhite,
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Cairo, Egypt",
                            style: TextStyle(color: AppColors.offWhite),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => themeProvider.toggleTheme(),
                  icon: themeProvider.isDarkMode
                      ? const Icon(Icons.dark_mode_rounded, color: Colors.white)
                      : const Icon(Icons.light_mode_outlined,
                          color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => localProvider.toggleLocale(),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        isEnglish ? "En" : "AR",
                        style: TextStylesHelper.font16PurpleBold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: DefaultTabController(
                initialIndex: 0,
                length: 10,
                child: CustomTabsBottom(
                  showAllTab: true,
                  unselectedBorder: AppColors.offWhite,
                  selectedBackgroundColor: AppColors.offWhite,
                  unselectedBackgroundColor: Colors.transparent,
                  selectedTextColor: AppColors.purple,
                  unselectedTextColor: AppColors.offWhite,
                  onTap: (index) {
                    eventListProvider.changeSelectedIndex(index);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight * 3);
}
