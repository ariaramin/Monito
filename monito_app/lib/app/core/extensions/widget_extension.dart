import 'package:flutter/material.dart'
    show
        RichText,
        SliverToBoxAdapter,
        Text,
        TextAlign,
        TextDirection,
        TextOverflow,
        TextSpan,
        TextStyle,
        Widget;
import 'package:get/get.dart' show GetStringUtils, Obx, Trans;
import 'package:monito/app/modules/auth/controllers/profile_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    show DateTimeExt, Jalali;

extension WidgetExtension on Widget {
  Widget get asSliver => SliverToBoxAdapter(child: this);
}

extension TextExtension on Text {
  Widget withToman({TextStyle? style}) {
    final baseStyle =
        (this.style ?? const TextStyle()).copyWith(fontFamily: 'IranSans');
    final tomanStyle = (style ?? baseStyle).copyWith(color: this.style?.color);

    return Obx(() {
      final unit = ProfileController.instance.selectedMoneyUnit.value;
      return RichText(
        text: TextSpan(
          text: '$data ',
          style: baseStyle,
          children: [
            TextSpan(
              text: 'unit'.trParams({'unit': unit}),
              style: tomanStyle,
            ),
          ],
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      );
    });
  }

  Widget withDate({bool isCardDate = false}) {
    return Obx(() {
      final dateType = ProfileController.instance.selectedDateType.value;
      return Text(
        data!.isDateTime
            ? isCardDate
                ? formatDate(data!, dateType)
                : formatFullDate(data!, dateType)
            : data!,
        style: style,
        textDirection:
            dateType == 'jalali'.tr ? TextDirection.rtl : TextDirection.ltr,
      );
    });
  }
}

String formatFullDate(String iso8601String, String dateType) {
  Jalali date = DateTime.parse(iso8601String).toJalali();
  final f =
      dateType == 'jalali'.tr ? date.formatter : date.toGregorian().formatter;
  return '${f.d} ${f.mN} ${f.y}';
}

String formatDate(String iso8601String, String dateType) {
  Jalali date = DateTime.parse(iso8601String).toJalali();
  final f =
      dateType == 'jalali'.tr ? date.formatter : date.toGregorian().formatter;
  return '${f.yyyy}/${f.mm}';
}
