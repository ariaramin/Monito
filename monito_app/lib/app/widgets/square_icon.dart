import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/widgets/cached_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SquareIcon extends StatelessWidget {
  const SquareIcon({
    super.key,
    this.icon,
    this.iconUrl,
    this.imageUrl,
    this.child,
    this.size,
    this.padding,
    this.isBordered = false,
  });

  final IconData? icon;
  final String? iconUrl, imageUrl;
  final Widget? child;
  final double? size;
  final EdgeInsetsGeometry? padding;
  final bool isBordered;

  @override
  Widget build(BuildContext context) {
    final radius = size != null ? (size! / 4.75).r : (58.h / 4.75).r;
    final defaultPadding = padding ?? (icon != null ? 0.all : 12.all);
    final backgroundColor =
        isBordered ? Get.appColors.background : Get.appColors.secondary;
    final borderColor = Get.appColors.secondary;
    final iconColor = isBordered
        ? (Get.isDarkMode
            ? Get.appColors.onBackground
            : Get.appColors.secondary)
        : Get.appColors.onSecondary;

    return Skeleton.shade(
      child: Container(
        width: size ?? 58.h,
        height: size ?? 58.h,
        padding: defaultPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: backgroundColor,
          border: isBordered
              ? Border.all(
                  width: 4.r,
                  color: borderColor,
                )
              : null,
        ),
        child: _buildContent(iconColor),
      ),
    );
  }

  Widget _buildContent(Color iconColor) {
    if (icon != null) {
      return Center(
        child: Icon(
          icon,
          color: iconColor,
          size: 32.r,
        ),
      );
    } else if (iconUrl?.isNotEmpty == true) {
      return SvgPicture.network(
        iconUrl!,
        colorFilter: ColorFilter.mode(
          Get.appColors.onPrimary,
          BlendMode.srcIn,
        ),
      );
    } else if (imageUrl?.isNotEmpty == true) {
      return CachedImage(
        url: imageUrl!,
        color: Get.appColors.onPrimary,
      );
    } else if (child != null) {
      return child!;
    } else {
      return const SizedBox();
    }
  }
}
