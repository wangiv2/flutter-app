import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_app/res/app_colors.dart';
import 'dimens.dart';

class TextStyles {
  static TextStyle navTitleText = TextStyle(
      fontSize: 20,
      color: AppColors.nav_text,
      fontWeight: FontWeight.w500
  );
  static TextStyle darkNavTitleText = navTitleText.copyWith(
      color: AppColors.dark_nav_text
  );

  static TextStyle titleText = TextStyle(
      fontSize: 18,
      color: AppColors.text,
      fontWeight: FontWeight.w500
  );
  static TextStyle darkTitleText = titleText.copyWith(
      color: AppColors.dark_text
  );

  static TextStyle bodyText = TextStyle(
      fontSize: 14,
      color: AppColors.text,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle darkBodyText = bodyText.copyWith(
      color: AppColors.dark_text
  );

  static TextStyle listTitleText = TextStyle(
      fontSize: 16,
      color: AppColors.text,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle darkListTitleText = listTitleText.copyWith(
      color: AppColors.dark_text
  );

  static TextStyle listSubTitleText = TextStyle(
      fontSize: 12,
      color: AppColors.text_gray,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle darkListSubTitleText = listSubTitleText.copyWith(
      color: AppColors.dark_text_gray
  );

  static TextStyle listBodyText = TextStyle(
      fontSize: 12,
      color: AppColors.text,
      textBaseline: TextBaseline.alphabetic
  );
  static TextStyle darkListBodyText = listTitleText.copyWith(
      color: AppColors.dark_text
  );


  // un used
  static const TextStyle textSize12 = const TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = const TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = const TextStyle(
    fontSize: Dimens.font_sp16,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = const TextStyle(
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = const TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.bold
  );

  static const TextStyle textGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.text_gray,
  );
  static const TextStyle textDarkGray14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.dark_text_gray,
  );

  static const TextStyle textWhite14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.text,
    // https://github.com/flutter/flutter/issues/40248
    textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.dark_text,
    textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: AppColors.text_gray,
    fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = const TextStyle(
    fontSize: Dimens.font_sp12,
    color: AppColors.dark_text_gray,
    fontWeight: FontWeight.normal
  );

  static const TextStyle textHint14 = const TextStyle(
    fontSize: Dimens.font_sp14,
    color: AppColors.dark_unselected_item_color
  );
}
