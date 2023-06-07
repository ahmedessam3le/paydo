import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_strings.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.scaffoldBackgroundColor,
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: AppColors.primary,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Text(
                AppStrings.appName,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
