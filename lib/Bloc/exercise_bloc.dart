import 'dart:async';

import 'package:exerciseapp/Bloc/exercise_event.dart';
import 'package:exerciseapp/Bloc/exercise_state.dart';
import 'package:exerciseapp/Model/ExerciseModel.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(InitialState()) {
    on<AddItemEvent>(_handleUpdateListLengthEvent);
  }

  TextEditingController controller = TextEditingController(text: "10");

  int time = 0;
  int interval = 0;
  List<ExerciseModel> items = [];

  void _handleUpdateListLengthEvent(
      AddItemEvent event, Emitter<ExerciseState> emit) {
    items.clear();
    for (int i = 0; i < event.length; i++) {
      items.add(ExerciseModel(i.toString(), false));
    }

    emit(UpdatedListState(List<ExerciseModel>.from(items)));
  }
}
