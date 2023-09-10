abstract class TimerEvent {}

class StartTimerEvent extends TimerEvent {
  final int duration;

  StartTimerEvent(this.duration);
}

class StopTimerEvent extends TimerEvent {}

class ResetTimerEvent extends TimerEvent {}

class TimerTickEvent extends TimerEvent {
  final int elapsedSeconds;

  TimerTickEvent(this.elapsedSeconds);
}

class TimerCompleteEvent extends TimerEvent {}