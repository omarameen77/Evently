import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/app_text_style.dart';
import 'package:flutter/material.dart';

class OrConnectWith extends StatefulWidget {
  const OrConnectWith({super.key});

  @override
  State<OrConnectWith> createState() => _OrConnectWithState();
}

class _OrConnectWithState extends State<OrConnectWith> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
            color: AppColors.purple,
          ),
        ),
        Text(
          'Or',
          style: TextStylesHelper.font16PurpleBold,
        ),
        const Expanded(
          child: Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: AppColors.purple,
          ),
        ),
      ],
    );
  }
}
