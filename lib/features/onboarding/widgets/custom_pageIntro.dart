import 'package:flutter/material.dart';

class CustomPageIntro extends StatelessWidget {
  final String centerImage;
  final Widget title;
  final Widget titleMassage;

  const CustomPageIntro({
    super.key,
    required this.centerImage,
    required this.title,
    required this.titleMassage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: SizedBox()),
        Center(child: Image.asset(centerImage, fit: BoxFit.contain)),
        SizedBox(height: 50),
        title,
        SizedBox(height: 20),
        titleMassage,
        SizedBox(height: 50),
      ],
    );
  }
}
