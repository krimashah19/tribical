import 'package:exerciseapp/Core/Constant/AppAssets.dart';
import 'package:exerciseapp/Core/Constant/AppColors.dart';
import 'package:exerciseapp/View/ExerciseView.dart';
import 'package:exerciseapp/widget/AppButtonWidget.dart';
import 'package:exerciseapp/widget/AppTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CongratulationView extends StatelessWidget {
  const CongratulationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.decorationSvg),
                        SvgPicture.asset(AppAssets.congratulationImg),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SvgPicture.asset(AppAssets.congratulationText),
                  SizedBox(
                    height: 10,
                  ),
                  AppTextWidget(
                      textAlign: TextAlign.center,
                      txtColor: AppColors.subTextColor,
                      fontSize: 14,
                      txtTitle:
                          "Congratulations, you have just reached the goal and activated your combustion..Well  done!!  Don’t forget to take a well-deserved small break now ;)"),
                ],
              ),
            ),
            AppButtonWidget(
              height: 48,
              btnName: 'Start again!',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              btnColor: AppColors.primary,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseView()),
                );
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
