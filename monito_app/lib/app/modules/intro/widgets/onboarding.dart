part of '../views/onboarding_screen.dart';

class OnBoarding extends StatelessWidget {


  const OnBoarding({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final SvgGenImage image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 38.horizontal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: 8.horizontal,
            child: AspectRatio(
              aspectRatio: 1,
              child: image.svg(),
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Get.appTextTheme.titleExtraBold2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
            ],
          ),
          12.verticalSpace,
          Text(
            subTitle,
            style: Get.appTextTheme.regular2.copyWith(
              color: Get.appColors.onBackground.withOpacity(.7),
            ),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
