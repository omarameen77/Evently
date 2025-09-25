import 'package:evently/core/consts/app_image.dart';
import 'package:evently/generated/l10n.dart';
import 'package:evently/provider/local_provider.dart';
import 'package:evently/shared/lang_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchLangWidget extends StatelessWidget {
  const SwitchLangWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return CustomSwitchWidget<String>(
      currentValue: localeProvider.locale.languageCode,
      values: const ["en", "ar"],
      icons: [
        Image.asset(AppImage.lr, width: 30),
        Image.asset(AppImage.eg, width: 30),
      ],
      onChanged: (value) => localeProvider.setLocale(Locale(value)),
      label: S.of(context).language,
    );
  }
}
