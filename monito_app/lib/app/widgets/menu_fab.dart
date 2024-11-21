import 'package:flutter/material.dart'
    show
        BuildContext,
        FloatingActionButton,
        Icon,
        Icons,
        StatelessWidget,
        Widget;
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart' show Get;
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/extensions/theme_extension.dart'
    show ThemeExtension;

class MenuFab extends StatelessWidget {
  const MenuFab({
    super.key,
    this.onEditPressed,
    this.onExportPressed,
    this.onDeletePressed,
  });

  final Function()? onEditPressed, onExportPressed, onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      pos: ExpandableFabPos.left,
      distance: 86,
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        fabSize: ExpandableFabSize.small,
        child: const Icon(Icons.close_rounded),
        foregroundColor: Get.appColors.onError,
        backgroundColor: Get.appColors.error,
      ),
      openButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Iconsax.menu_1),
        foregroundColor: Get.appColors.onPrimary,
        backgroundColor: Get.appColors.primary,
      ),
      children: [
        FloatingActionButton.small(
          backgroundColor: Get.appColors.primary,
          foregroundColor: Get.appColors.onPrimary,
          onPressed: onDeletePressed,
          heroTag: 'delete',
          child: const Icon(Iconsax.trash),
        ),
        FloatingActionButton.small(
          backgroundColor: Get.appColors.primary,
          foregroundColor: Get.appColors.onPrimary,
          onPressed: onExportPressed,
          heroTag: 'export',
          child: const Icon(Iconsax.export),
        ),
        FloatingActionButton.small(
          backgroundColor: Get.appColors.primary,
          foregroundColor: Get.appColors.onPrimary,
          onPressed: onEditPressed,
          heroTag: 'edit',
          child: const Icon(Iconsax.edit_2),
        ),
      ],
    );
  }
}
