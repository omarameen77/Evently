import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomSwitchWidget<T> extends StatelessWidget {
  final T currentValue;
  final List<T> values;
  final List<Widget> icons;
  final ValueChanged<T> onChanged;
  final String? label;

  const CustomSwitchWidget({
    super.key,
    required this.currentValue,
    required this.values,
    required this.icons,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (label != null)
            Text(
              label!,
              style: TextStylesHelper.font20PurpleMedium,
            ),
          AnimatedToggleSwitch<T>.rolling(
            height: 40,
            indicatorSize:Size.fromWidth(40),
            current: currentValue,
            values: values,
            iconBuilder: (value, isSelected) {
              final index = values.indexOf(value);
              return icons[index];
            },
            styleBuilder: (value) => ToggleStyle(
              indicatorColor: Theme.of(context).colorScheme.primary,
              
            ),
            style: ToggleStyle(
              borderColor: Theme.of(context).colorScheme.primary,
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
