import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_utils.dart';
import '../../../core/utils/transaction_utils.dart';
import '../../domain/entities/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final void Function(String? i) onTap;

  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Get.theme.cardColor,
      child: InkWell(
        onTap: () => onTap(transaction.id),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                TransactionUtils.getTransactionIcon(transaction.type),
                width: 22,
                height: 22,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    TransactionUtils.getTransactionTitle(
                      type: transaction.type,
                      merchantTitle: transaction.itemName,
                    ),
                    style: Get.textTheme.titleSmall,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          '${TransactionUtils.isTopUp(transaction.type) ? '+' : ''}${AppUtils.priceParser(transaction.price).split('.')[0]}.',
                      style: TransactionUtils.isTopUp(transaction.type)
                          ? Get.textTheme.headlineMedium?.copyWith(
                              color: Get.theme.primaryColor,
                            )
                          : Get.textTheme.headlineMedium,
                    ),
                    TextSpan(
                      text:
                          AppUtils.priceParser(transaction.price).split('.')[1],
                      style: TransactionUtils.isTopUp(transaction.type)
                          ? Get.textTheme.headlineMedium?.copyWith(
                              color: Get.theme.primaryColor,
                            )
                          : Get.textTheme.headlineMedium?.copyWith(
                              fontSize: 16,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
