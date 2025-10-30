import 'package:evently/core/theme/app_colors.dart';
import 'package:evently/core/theme/app_text_style/font_weight.dart';
import 'package:flutter/material.dart';

class TextStylesHelper {
  static TextStyle font20PurpleBold = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    color: AppColors.purple,
  );
    static TextStyle font20BlackBold = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black,
  );
    static TextStyle font16PurpleBold = TextStyle(
    fontSize: 16,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    color: AppColors.purple,
  );
      static TextStyle font20WhiteBold = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    color: AppColors.lightBlue,
  );

    static TextStyle font18WhiteBold = TextStyle(
    fontSize: 18,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.bold,
    color: AppColors.lightBlue,
  );

  static TextStyle font16semiBold = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.semiBold,
  );
    static TextStyle font16semiBoldWhite = TextStyle(
    fontSize: 14,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.semiBold,
    color: AppColors.lightBlue
  );

  static TextStyle font20PurpleMedium = TextStyle(
    fontSize: 20,
    fontFamily: 'Inter',
    fontWeight: FontWeightHelper.medium,
    color: AppColors.purple,
  );

    static TextStyle font20WhiteMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeightHelper.light,
    color: AppColors.offWhite,
  );

      static TextStyle font16White = TextStyle(
    fontSize: 16,
    fontWeight: FontWeightHelper.light,
     fontFamily: 'Inter',
    color: AppColors.offWhite,
  );
}
