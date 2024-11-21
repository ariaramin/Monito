import 'package:flutter/material.dart' show EdgeInsets;
import 'package:flutter_screenutil/flutter_screenutil.dart' show SizeExtension;

extension SizedBoxExtension on num {
  EdgeInsets get all => EdgeInsets.all(toDouble().w);

  EdgeInsets get top => EdgeInsets.only(top: toDouble().h);

  EdgeInsets get bottom => EdgeInsets.only(bottom: toDouble().h);

  EdgeInsets get left => EdgeInsets.only(left: toDouble().w);

  EdgeInsets get right => EdgeInsets.only(right: toDouble().w);

  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: toDouble().w);

  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: toDouble().h);
}
