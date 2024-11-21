/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/256.png
  AssetGenImage get a256 => const AssetGenImage('assets/images/256.png');

  /// File path: assets/images/512.png
  AssetGenImage get a512 => const AssetGenImage('assets/images/512.png');

  /// File path: assets/images/european-union.png
  AssetGenImage get europeanUnion =>
      const AssetGenImage('assets/images/european-union.png');

  /// File path: assets/images/iran.png
  AssetGenImage get iran => const AssetGenImage('assets/images/iran.png');

  /// File path: assets/images/splash.png
  AssetGenImage get splash => const AssetGenImage('assets/images/splash.png');

  /// File path: assets/images/turkey.png
  AssetGenImage get turkey => const AssetGenImage('assets/images/turkey.png');

  /// File path: assets/images/united-arab-emirates.png
  AssetGenImage get unitedArabEmirates =>
      const AssetGenImage('assets/images/united-arab-emirates.png');

  /// File path: assets/images/united-kingdom.png
  AssetGenImage get unitedKingdom =>
      const AssetGenImage('assets/images/united-kingdom.png');

  /// File path: assets/images/united-states.png
  AssetGenImage get unitedStates =>
      const AssetGenImage('assets/images/united-states.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        a256,
        a512,
        europeanUnion,
        iran,
        splash,
        turkey,
        unitedArabEmirates,
        unitedKingdom,
        unitedStates
      ];
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/lines.svg
  SvgGenImage get lines => const SvgGenImage('assets/svgs/lines.svg');

  /// File path: assets/svgs/monito_logo.svg
  SvgGenImage get monitoLogo =>
      const SvgGenImage('assets/svgs/monito_logo.svg');

  /// File path: assets/svgs/onboarding1.svg
  SvgGenImage get onboarding1 =>
      const SvgGenImage('assets/svgs/onboarding1.svg');

  /// File path: assets/svgs/onboarding2.svg
  SvgGenImage get onboarding2 =>
      const SvgGenImage('assets/svgs/onboarding2.svg');

  /// File path: assets/svgs/onboarding3.svg
  SvgGenImage get onboarding3 =>
      const SvgGenImage('assets/svgs/onboarding3.svg');

  /// File path: assets/svgs/undraw_credit_card_re_blml.svg
  SvgGenImage get undrawCreditCardReBlml =>
      const SvgGenImage('assets/svgs/undraw_credit_card_re_blml.svg');

  /// File path: assets/svgs/undraw_no_data_re_kwbl.svg
  SvgGenImage get undrawNoDataReKwbl =>
      const SvgGenImage('assets/svgs/undraw_no_data_re_kwbl.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        lines,
        monitoLogo,
        onboarding1,
        onboarding2,
        onboarding3,
        undrawCreditCardReBlml,
        undrawNoDataReKwbl
      ];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/fa.json
  String get fa => 'assets/translations/fa.json';

  /// List of all assets
  List<String> get values => [fa];
}

class Assets {
  Assets._();

  static const String aEnv = '.env';
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
