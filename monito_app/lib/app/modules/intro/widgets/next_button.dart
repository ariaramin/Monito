part of '../views/onboarding_screen.dart';

class NextButton extends GetView<OnboardingController> {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80.h,
          height: 80.h,
          child: Obx(
            () => CircleProgressBar(
              backgroundColor: Colors.white,
              foregroundColor: Get.appColors.primary,
              value: ((controller.currentPage.value + 1) *
                  1.0 /
                  controller.onBoardingList.length),
            ),
          ),
        ),
        Container(
          height: 55.h,
          width: 55.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.appColors.primary,
          ),
          child: IconButton(
            onPressed: () => controller.nextPage(),
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
            ),
            iconSize: 18.r,
          ),
        )
      ],
    );
  }
}
