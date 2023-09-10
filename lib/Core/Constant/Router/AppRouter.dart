


import 'package:exerciseapp/Core/Constant/Router/AppRouterName.dart';
import 'package:exerciseapp/View/CongratulationView.dart';
import 'package:exerciseapp/View/ExerciseView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {
    case AppRouterName.exerciseView:
      return MaterialPageRoute(
          builder: (context) => const ExerciseView());

    case AppRouterName.congratulationView:
      return MaterialPageRoute(
          builder: (context) => const CongratulationView());

    default:
      return MaterialPageRoute(
          builder: (context) => const ExerciseView());
  }
}



