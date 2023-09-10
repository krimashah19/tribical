import 'package:exerciseapp/Bloc/exercise_bloc.dart';
import 'package:exerciseapp/Model/ExerciseModel.dart';

abstract class ExerciseState {}

class InitialState extends ExerciseState {}

class UpdatedListState extends ExerciseState {
  final List<ExerciseModel> items;

  UpdatedListState(this.items);
}