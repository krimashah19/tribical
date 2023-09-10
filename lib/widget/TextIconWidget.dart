import 'package:exerciseapp/Core/Constant/AppColors.dart';
import 'package:exerciseapp/widget/AppTextWidget.dart';
import 'package:flutter/cupertino.dart';

class TextIconWidget extends StatelessWidget {
  final IconData? iconName;
  final Color? iconColor;
  final String? titleName;
  final String? titleValue;
  final Color? bgColor;

  const TextIconWidget(
    this.iconName,
    this.iconColor,
    this.titleName,
    this.titleValue,
    this.bgColor, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(8)),
          child: Icon(
            iconName,
            color: iconColor,
            size: 14,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Column(
          children: [
            AppTextWidget(
              txtTitle: titleName ?? '',
              txtColor: AppColors.subTextColor,
              fontSize: 10,
            ),
            SizedBox(
              height: 2,
            ),
            AppTextWidget(
              txtTitle: titleValue ?? '',
              txtColor: AppColors.black,
              fontSize: 12,
            )
          ],
        )
      ],
    );
  }
}
