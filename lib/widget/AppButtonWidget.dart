import 'package:exerciseapp/widget/AppTextWidget.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    Key? key,
    this.height,
    this.width,
    required this.onPressed,
    this.btnName,
    this.txtColor = Colors.white,
    this.disableTxtColor = Colors.white,
    this.fontSize = 16,
    this.btnColor,
    this.fontWeight = FontWeight.w600,
    this.borderRadius = 5,
    this.borderColor = Colors.transparent,
    this.disableBorderColor = Colors.transparent,
    this.padding,
    this.borderWidth = 0,
    this.child,
    this.margin,
    this.isEnable = true,
  }) : super(key: key);
  final double? height;
  final double? width;
  final Function() onPressed;
  final String? btnName;
  final Color txtColor;
  final Color disableTxtColor;
  final double fontSize;
  final Color? btnColor;
  final FontWeight fontWeight;
  final double borderRadius;
  final Color borderColor;
  final Color disableBorderColor;
  final Widget? child;
  final double borderWidth;
  final bool isEnable;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onPressed : () {},
      child: Container(
        height: height,
        width: width,
        padding: padding ?? EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: isEnable ? borderColor : disableBorderColor,
              width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
          color: btnColor ?? Colors.blue.shade900,
        ),
        child: child ??
            AppTextWidget(
              overflow: TextOverflow.ellipsis,
              maxLine: 2,
              txtTitle: (btnName ?? ""),
              fontSize: fontSize,
              txtColor: isEnable ? txtColor : disableTxtColor,
              fontWeight: fontWeight,
            ),
      ),
    );
  }
}
