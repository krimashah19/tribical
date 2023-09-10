import 'dart:async';

import 'package:exerciseapp/Bloc/exercise_bloc.dart';
import 'package:exerciseapp/Bloc/timer_bloc.dart';
import 'package:exerciseapp/Bloc/timer_event.dart';
import 'package:exerciseapp/Bloc/timer_state.dart';
import 'package:exerciseapp/Core/Constant/AppColors.dart';
import 'package:exerciseapp/widget/AppTextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseNumberWidget extends StatelessWidget {
  final int? number;
  final int? time;
  final int? inteval;
  late Timer? _timer;
  final bool? isCompleted;

  ExerciseNumberWidget(
      {Key? key, this.number, this.time, this.inteval, this.isCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);
    final ExerciseBloc exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: exerciseBloc.items[number! - 1].isCompleted == true
                  ? AppColors.subTextColor
                  : AppColors.primary),
          width: 30,
          // Set the width of the rectangle
          height: 30,
          // Set the height of the rectangle
          // Set the color of the rectangle
          child: Center(
            child: AppTextWidget(
              txtTitle: '$number',

              txtColor: AppColors.white, // Set the text color
              fontSize: 14, // Set the text font size
            ),
          ),
        );
      },
    );
  }

  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is StartTimerEvent) {
      _timer = Timer.periodic(Duration(seconds: 3), (_) {});
    }
  }
}
