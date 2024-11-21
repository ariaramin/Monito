import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/routes/pages.dart';
import 'package:monito/app/core/values/theme_controller.dart';
import 'package:monito/app/data/providers/auth_repository.dart';
import 'package:monito/app/widgets/icon_button.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/gen/assets.gen.dart';

import 'overview_card/overview_card.dart';

part 'header_bar.dart';
part 'header_curve_clipper.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final double headerHeight = 258.h;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipPath(
          clipper: HeaderCurveClipper(),
          child: Container(
            width: double.infinity,
            height: headerHeight,
            color: Get.appColors.primary,
            child: Assets.svgs.lines.svg(
              fit: BoxFit.cover,
              width: double.infinity,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.06),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          top: 16.h,
          left: 16.w,
          right: 16.w,
          child: Column(
            children: [
              const HeaderBar(),
              42.verticalSpace,
              const OverviewCard(),
            ],
          ),
        ),
      ],
    );
  }
}
