import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:paydo/core/bindings/global_binding.dart';
import 'package:paydo/core/const/app_strings.dart';
import 'package:paydo/core/const/app_values.dart';
import 'package:paydo/core/localization/app_translations.dart';
import 'package:paydo/core/style/app_themes.dart';
import 'package:paydo/core/utils/app_router.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (kIsWeb) {
    setPathUrlStrategy();
  }
  runApp(const PaydoApp());
}

class PaydoApp extends StatelessWidget {
  const PaydoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        getPages: AppRouter.routes,
        initialRoute: AppRoutes.splashRoute,
        initialBinding: GlobalBinding(),
        translations: AppTranslations(),
        locale: const Locale(AppValues.langCodeEN),
        theme: AppThemes.getTheme(),
      ),
    );
  }
}
