import 'package:get/get.dart';
import 'package:paydo/core/utils/app_utils.dart';

import '../../App/presentation/views/pay_view.dart';
import '../../App/presentation/views/splash_view.dart';
import '../../App/presentation/views/transaction_details_view.dart';
import '../../App/presentation/views/transactions_view.dart';
import '../bindings/pay_binding.dart';
import '../bindings/splash_binding.dart';
import '../bindings/transaction_details_binding.dart';
import '../bindings/transactions_binding.dart';

class AppRoutes {
  static const String splashRoute = '/';
  static const String transactionsRoute = '/transactions';
  static const String payRoute = '/pay';
  static const String transactionDetailsRoute = '/transaction-details';
}

class AppRouter {
  static final List<GetPage> routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.transactionsRoute,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.payRoute,
      page: () => const PayView(),
      binding: PayBinding(),
      transition: _transition(),
    ),
    GetPage(
      name: AppRoutes.transactionDetailsRoute,
      page: () => const TransactionDetailsView(),
      binding: TransactionDetailsBinding(),
      transition: _transition(),
    ),
  ];

  static Transition? _transition() =>
      AppUtils.isMobile() ? null : Transition.fadeIn;
}
