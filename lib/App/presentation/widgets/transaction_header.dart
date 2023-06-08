import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/date_utils.dart' as du;
import '../../../core/utils/transaction_utils.dart';
import '../../domain/entities/transaction.dart';

class TransactionHeader extends StatelessWidget {
  final Transaction transaction;

  const TransactionHeader({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                TransactionUtils.getTransactionIcon(transaction.type),
                width: 66,
                height: 66,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              '${TransactionUtils.isTopUp(transaction.type) ? '+' : ''}${AppUtils.priceParser(transaction.price).split('.')[0]}.',
                          style: TransactionUtils.isTopUp(transaction.type)
                              ? Get.textTheme.headlineMedium?.copyWith(
                                  fontSize: 37,
                                  color: Get.theme.primaryColor,
                                )
                              : Get.textTheme.headlineMedium?.copyWith(
                                  fontSize: 37,
                                ),
                        ),
                        TextSpan(
                          text: AppUtils.priceParser(transaction.price)
                              .split('.')[1],
                          style: TransactionUtils.isTopUp(transaction.type)
                              ? Get.textTheme.headlineMedium?.copyWith(
                                  color: Get.theme.primaryColor,
                                )
                              : Get.textTheme.headlineMedium?.copyWith(
                                  fontSize: 26,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            TransactionUtils.getTransactionTitle(
              type: transaction.type,
              merchantTitle: transaction.itemName,
            ),
            style: Get.textTheme.titleMedium,
          ),
          Text(
            du.DateUtils.getDateFormat(
              transaction.createdAt,
              fullDate: true,
            ).toUpperCase(),
            style: Get.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
