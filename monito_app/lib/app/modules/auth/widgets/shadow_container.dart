part of '../views/profile_screen.dart';

class ShadowContainer extends StatelessWidget {
  const ShadowContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 16.horizontal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Get.appColors.background,
        boxShadow: [
          BoxShadow(
            color: Get.appColors.shadow,
            blurRadius: 25,
            spreadRadius: -12,
            offset: Offset.zero,
          ),
        ],
      ),
      child: child,
    );
  }
}
