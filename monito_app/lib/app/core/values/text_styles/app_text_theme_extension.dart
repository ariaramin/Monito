import 'package:flutter/material.dart' show TextStyle, ThemeExtension;

class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {
  const AppTextThemeExtension({
    required this.titleExtraBold2,
    required this.titleExtraBold1,
    required this.titleBold1,
    required this.regularExtraBold2,
    required this.regularBold2,
    required this.regular2,
    required this.regularExtraBold1,
    required this.regularBold1,
    required this.smallExtraBold3,
    required this.smallBold3,
    required this.small3,
    required this.smallBold2,
    required this.small2,
    required this.smallBold1,
    required this.small1,
  });

  final TextStyle titleExtraBold2;
  final TextStyle titleExtraBold1;
  final TextStyle titleBold1;
  final TextStyle regularExtraBold2;
  final TextStyle regularBold2;
  final TextStyle regular2;
  final TextStyle regularExtraBold1;
  final TextStyle regularBold1;
  final TextStyle smallExtraBold3;
  final TextStyle smallBold3;
  final TextStyle small3;
  final TextStyle smallBold2;
  final TextStyle small2;
  final TextStyle smallBold1;
  final TextStyle small1;

  @override
  ThemeExtension<AppTextThemeExtension> copyWith({
    TextStyle? titleExtraBold2,
    TextStyle? titleExtraBold1,
    TextStyle? titleBold1,
    TextStyle? regularExtraBold2,
    TextStyle? regularBold2,
    TextStyle? regular2,
    TextStyle? regularExtraBold1,
    TextStyle? regularBold1,
    TextStyle? smallExtraBold3,
    TextStyle? smallBold3,
    TextStyle? small3,
    TextStyle? smallBold2,
    TextStyle? small2,
    TextStyle? smallBold1,
    TextStyle? small1,
  }) {
    return AppTextThemeExtension(
      titleExtraBold2: titleExtraBold2 ?? this.titleExtraBold2,
      titleExtraBold1: titleExtraBold1 ?? this.titleExtraBold1,
      titleBold1: titleBold1 ?? this.titleBold1,
      regularExtraBold2: regularExtraBold2 ?? this.regularExtraBold2,
      regularBold2: regularBold2 ?? this.regularBold2,
      regular2: regular2 ?? this.regular2,
      regularExtraBold1: regularExtraBold1 ?? this.regularExtraBold1,
      regularBold1: regularBold1 ?? this.regularBold1,
      smallExtraBold3: smallExtraBold3 ?? this.smallExtraBold3,
      smallBold3: smallBold3 ?? this.smallBold3,
      small3: small3 ?? this.small3,
      smallBold2: smallBold2 ?? this.smallBold2,
      small2: small2 ?? this.small2,
      smallBold1: smallBold1 ?? this.smallBold1,
      small1: small1 ?? this.small1,
    );
  }

  @override
  ThemeExtension<AppTextThemeExtension> lerp(
    covariant ThemeExtension<AppTextThemeExtension>? other,
    double t,
  ) {
    if (other is! AppTextThemeExtension) {
      return this;
    }

    return AppTextThemeExtension(
      titleExtraBold2:
          TextStyle.lerp(titleExtraBold2, other.titleExtraBold2, t)!,
      titleExtraBold1:
          TextStyle.lerp(titleExtraBold1, other.titleExtraBold1, t)!,
      titleBold1: TextStyle.lerp(titleBold1, other.titleBold1, t)!,
      regularExtraBold2:
          TextStyle.lerp(regularExtraBold2, other.regularExtraBold2, t)!,
      regularBold2: TextStyle.lerp(regularBold2, other.regularBold2, t)!,
      regular2: TextStyle.lerp(regular2, other.regular2, t)!,
      regularExtraBold1:
          TextStyle.lerp(regularExtraBold1, other.regularExtraBold1, t)!,
      regularBold1: TextStyle.lerp(regularBold1, other.regularBold1, t)!,
      smallExtraBold3:
          TextStyle.lerp(smallExtraBold3, other.smallExtraBold3, t)!,
      smallBold3: TextStyle.lerp(smallBold3, other.smallBold3, t)!,
      small3: TextStyle.lerp(small3, other.small3, t)!,
      smallBold2: TextStyle.lerp(smallBold2, other.smallBold2, t)!,
      small2: TextStyle.lerp(small2, other.small2, t)!,
      smallBold1: TextStyle.lerp(smallBold1, other.smallBold1, t)!,
      small1: TextStyle.lerp(small1, other.small1, t)!,
    );
  }
}
