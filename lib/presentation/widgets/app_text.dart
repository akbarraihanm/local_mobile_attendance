import 'package:flutter/material.dart';

import '../../core/config/app_typography.dart';

class AppText extends StatelessWidget {
  final String? title;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLine;
  final TextStyle? textStyle;

  const AppText(
      {Key? key,
        this.title,
        this.align,
        this.overflow,
        this.maxLine,
        this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: textStyle ?? AppTypography.body2(),
      maxLines: maxLine,
      overflow: overflow ?? TextOverflow.fade,
      textAlign: align,
    );
  }
}
