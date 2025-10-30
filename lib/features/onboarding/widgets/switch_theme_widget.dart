import 'package:evently/generated/l10n.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:evently/shared/lang_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDark = themeProvider.isDarkMode;
    return CustomSwitchWidget<bool>(
      currentValue: isDark,
      values: const [true, false],
      icons: const [
        Icon(Icons.dark_mode),
        Icon(Icons.light_mode),
      ],
      onChanged: (value) {
        themeProvider.toggleTheme();
      },
      label: S.of(context).theme,
    );
  }
}
