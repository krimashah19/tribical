abstract class ExerciseEvent {}

class AddItemEvent extends ExerciseEvent {
  final int length;
  AddItemEvent(this.length);
}