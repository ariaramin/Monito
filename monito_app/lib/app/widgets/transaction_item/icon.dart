part of 'transaction_item.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({
    super.key,
    required this.categoryIconUrl,
    this.bankIconUrl,
  });

  final String categoryIconUrl;
  final String? bankIconUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SquareIcon(iconUrl: categoryIconUrl),
        Positioned(
          bottom: -8,
          left: -8,
          child: Container(
            width: 22.h,
            height: 22.h,
            padding: 3.all,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                width: 1.r,
                color: Get.appColors.secondary,
              ),
              color: Get.appColors.background,
            ),
            child: Center(
              child: bankIconUrl != null && bankIconUrl!.isNotEmpty
                  ? CachedImage(
                      url: bankIconUrl!,
                      color: Get.isDarkMode
                          ? Get.appColors.onBackground
                          : Get.appColors.primary,
                    )
                  : Assets.svgs.undrawCreditCardReBlml.svg(
                      colorFilter: ColorFilter.mode(
                        Get.isDarkMode
                            ? Get.appColors.onBackground
                            : Get.appColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
