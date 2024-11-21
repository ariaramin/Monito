import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:monito/app/core/extensions/num_extension.dart';
import 'package:monito/app/core/extensions/theme_extension.dart';
import 'package:monito/app/core/extensions/widget_extension.dart';
import 'package:monito/app/core/values/theme.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.controller,
    this.initialValue,
    this.isExpanded = false,
    this.isOpenable = false,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.isDate = false,
    this.isCardDate = false,
    this.onPasswordSuffixIconTap,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.helperText,
    this.errorText,
    this.suffixText,
    this.prefixIcon,
    this.onTap,
  });

  final TextEditingController? controller;
  final String label;
  final String? initialValue;
  final bool isExpanded;
  final bool isOpenable;
  final bool isPassword;
  final bool isPasswordVisible;
  final bool isDate;
  final bool isCardDate;
  final Function()? onPasswordSuffixIconTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? helperText;
  final String? errorText;
  final String? suffixText;
  final Widget? prefixIcon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return !isOpenable
        ? TextFormField(
            controller: controller,
            initialValue: initialValue,
            keyboardType: keyboardType,
            style: Get.appTextTheme.regularBold1.copyWith(
              fontFamily: 'IranSans',
            ),
            inputFormatters: inputFormatters,
            validator: validator,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.end,
            maxLines: isExpanded ? 4 : 1,
            obscureText: isPassword ? !isPasswordVisible : false,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: label,
              errorText: errorText,
              counterText: '',
              helperText: helperText,
              suffixText: suffixText,
              suffixIcon: isPassword
                  ? Padding(
                      padding: 8.left,
                      child: GestureDetector(
                        onTap: onPasswordSuffixIconTap,
                        child: Icon(
                          isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                          size: 24.r,
                        ),
                      ),
                    )
                  : null,
              suffixIconColor: WidgetStateColor.resolveWith(
                (states) => initialValue != null
                    ? Get.appColors.onBackground
                    : AppPalette.gray,
              ),
            ),
          )
        : GestureDetector(
            onTap: onTap,
            child: FormField<String>(
              validator: validator,
              initialValue: initialValue,
              builder: (field) => InputDecorator(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: prefixIcon,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_rounded,
                    size: 24.r,
                  ),
                  suffixIconColor: WidgetStateColor.resolveWith(
                    (states) => initialValue != null
                        ? Get.appColors.onBackground
                        : AppPalette.gray,
                  ),
                  errorText: field.errorText,
                ),
                child: isDate && initialValue != null
                    ? Text(
                        initialValue ?? label,
                        style: initialValue == null
                            ? Get.appTextTheme.regularBold1.copyWith(
                                color: AppPalette.gray,
                              )
                            : Get.appTextTheme.regularBold1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).withDate(isCardDate: isCardDate)
                    : Text(
                        initialValue ?? label,
                        style: initialValue == null
                            ? Get.appTextTheme.regularBold1.copyWith(
                                color: AppPalette.gray,
                              )
                            : Get.appTextTheme.regularBold1,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
          );
  }
}
