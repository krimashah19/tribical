import 'dart:async';
import 'package:exerciseapp/Bloc/exercise_bloc.dart';
import 'package:exerciseapp/Bloc/timer_event.dart';
import 'package:exerciseapp/Bloc/timer_state.dart';
import 'package:exerciseapp/Core/Constant/Router/AppRouterName.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  int remainingSeconds = 0;

  TimerBloc() : super(TimerInitialState()) {
    on<StartTimerEvent>((event, emit) {
      mapEventToState(event);
    });
  }

  int exerciseTime = 3;

  mapEventToState(TimerEvent event) async {
    if (event is StartTimerEvent) {
      for (int i = 0; i <= event.duration; i++) {
        await Future.delayed(Duration(seconds: 1));
        emit(TimerRunningState(i));
      }
    }
  }

  void redirectToTheScreen(ExerciseBloc exerciseBloc, BuildContext context)
  {
    for (int i = 0; i < exerciseBloc.items.length; i++) {
      if (remainingSeconds == 27) {
        exerciseBloc.items[0].isCompleted = true;
      } else if (remainingSeconds == 24) {
        exerciseBloc.items[1].isCompleted = true;
      } else if (remainingSeconds == 21) {
        exerciseBloc.items[2].isCompleted = true;
      } else if (remainingSeconds == 18) {
        exerciseBloc.items[3].isCompleted = true;
      } else if (remainingSeconds == 15) {
        exerciseBloc.items[4].isCompleted = true;
      } else if (remainingSeconds == 12) {
        exerciseBloc.items[5].isCompleted = true;
      } else if (remainingSeconds == 9) {
        exerciseBloc.items[6].isCompleted = true;
      } else if (remainingSeconds == 6) {
        exerciseBloc.items[7].isCompleted = true;
      } else if (remainingSeconds == 3) {
        exerciseBloc.items[8].isCompleted = true;
      } else if (remainingSeconds == 0) {
        exerciseBloc.items[9].isCompleted = true;
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          Navigator.pushNamed(
            context,
            AppRouterName.congratulationView,
          );
        });
      }
    }
  }
}
