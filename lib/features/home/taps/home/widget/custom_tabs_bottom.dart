import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:evently/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTabsBottom extends StatelessWidget {
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedBackgroundColor;
  final Color? unselectedBackgroundColor;
  final Color? unselectedBorder;
  final void Function(int)? onTap;
  final bool showAllTab;

  const CustomTabsBottom({
    super.key,
    this.onTap,
    this.selectedTextColor,
    this.unselectedTextColor,
    this.selectedBackgroundColor,
    this.unselectedBackgroundColor,
    this.unselectedBorder,
    this.showAllTab = true,
  });

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      if (showAllTab)
        const Tab(
          icon: Icon(Icons.align_horizontal_left_rounded, size: 18),
          text: "All",
        ),
      const Tab(icon: Icon(Icons.sports, size: 18), text: "Sport"),
      const Tab(icon: Icon(Icons.cake_outlined, size: 18), text: "Birthday"),
      const Tab(icon: Icon(Icons.restaurant_menu, size: 18), text: "Eating"),
      const Tab(icon: Icon(Icons.lightbulb_outline, size: 18), text: "Exhibitor"),
      const Tab(icon: Icon(Icons.sports_esports_outlined, size: 18), text: "Gaming"),
      const Tab(icon: Icon(Icons.beach_access_outlined, size: 18), text: "Holiday"),
      const Tab(icon: Icon(Icons.people_outline, size: 18), text: "Meeting"),
      const Tab(icon: Icon(Icons.work_outline, size: 18), text: "Workshop"),
      const Tab(icon: Icon(Icons.book_outlined, size: 18), text: "Book Club"),
    ];

    return ButtonsTabBar(
      onTap: onTap,
      backgroundColor: selectedBackgroundColor,
      unselectedBackgroundColor:
          unselectedBackgroundColor ?? Colors.transparent,
      borderWidth: 1,
      borderColor: AppColors.lightBlue,
      unselectedBorderColor: unselectedBorder ?? Colors.transparent,
      radius: 25,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      labelStyle: TextStyle(
        color: selectedTextColor,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: unselectedTextColor,
      ),
      tabs: tabs,
    );
  }
}
