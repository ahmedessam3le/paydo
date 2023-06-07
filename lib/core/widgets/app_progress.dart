import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paydo/core/utils/app_utils.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Get.theme.scaffoldBackgroundColor,
      child: Center(
        child: AppUtils.isApple()
            ? const CupertinoActivityIndicator()
            : CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
              ),
      ),
    );
  }
}
