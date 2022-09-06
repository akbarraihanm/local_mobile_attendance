import 'package:flutter/material.dart';
import '../../core/config/app_typography.dart';
import 'app_text.dart';

class AppButton extends StatelessWidget {
  final Function? onPressed;
  final double? height;
  final double? width;
  final Color? color;
  final Widget? child;
  final bool isEnable;
  final double? radius;
  final String? title;
  final double? elevation;
  final TextStyle? textStyle;

  const AppButton(
      {Key? key,
        this.onPressed,
        this.height,
        this.width,
        this.color,
        this.child,
        this.isEnable = true,
        this.radius = 4,
        this.title,
        this.elevation,
        this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        if (isEnable) onPressed?.call();
      },
      height: height ?? 44,
      minWidth: width ?? double.infinity,
      color: isEnable ? color : Colors.grey,
      elevation: elevation ?? 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
      child: title != null
          ? AppText(
        title: title,
        textStyle: textStyle ?? AppTypography.action1(color: Colors.white),
        align: TextAlign.center,
      ) : child,
    );
  }
}
