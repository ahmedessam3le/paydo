import 'package:flutter/material.dart';
import 'package:paydo/core/style/app_colors.dart';

class AppStyles {
  static InputDecoration inputDecorationUnderline(final Color? color) {
    return InputDecoration(
      border: inputBorderUnderline(color),
      errorBorder: inputBorderUnderline(color),
      focusedBorder: inputBorderUnderline(color),
      enabledBorder: inputBorderUnderline(color),
      disabledBorder: inputBorderUnderline(color),
      focusedErrorBorder: inputBorderUnderline(color),
    );
  }

  static UnderlineInputBorder inputBorderUnderline(final Color? color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.white,
        width: 2,
      ),
    );
  }
}
