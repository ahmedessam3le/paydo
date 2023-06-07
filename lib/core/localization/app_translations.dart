import 'package:get/get.dart';
import 'package:paydo/core/localization/languages/en.dart';

import '../const/app_values.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        AppValues.langCodeEN: en,
      };
}
