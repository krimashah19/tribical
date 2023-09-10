import 'dart:async';

abstract class TimerState {}

class TimerInitialState extends TimerState {}

class TimerRunningState extends TimerState {
  final int elapsedSeconds;

  TimerRunningState(this.elapsedSeconds);
}

class TimerPausedState extends TimerState {
  final int elapsedSeconds;

  TimerPausedState({required this.elapsedSeconds});
}

class TimerCompleteState extends TimerState {}