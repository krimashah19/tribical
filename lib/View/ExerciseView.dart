import 'dart:math';

import 'package:exerciseapp/Bloc/exercise_bloc.dart';
import 'package:exerciseapp/Bloc/exercise_event.dart';
import 'package:exerciseapp/Bloc/exercise_state.dart';
import 'package:exerciseapp/Bloc/timer_bloc.dart';
import 'package:exerciseapp/Bloc/timer_event.dart';
import 'package:exerciseapp/Bloc/timer_state.dart';
import 'package:exerciseapp/Core/Constant/AppAssets.dart';
import 'package:exerciseapp/Core/Constant/AppColors.dart';
import 'package:exerciseapp/Core/Constant/Router/AppRouterName.dart';
import 'package:exerciseapp/View/CongratulationView.dart';
import 'package:exerciseapp/widget/AppTextWidget.dart';
import 'package:exerciseapp/widget/CirclePainter.dart';
import 'package:exerciseapp/widget/DottedProgressBar.dart';
import 'package:exerciseapp/widget/ExerciseNumberWidget.dart';
import 'package:exerciseapp/widget/TextIconWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext Ccontext) {
    return Scaffold(
      appBar: AppBar(
          title: AppTextWidget(
            txtTitle: 'Exercise',
            txtColor: AppColors.primary,
            fontSize: 20,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ExerciseBloc>(
            create: (context) => ExerciseBloc()..add(AddItemEvent(10)),
          ),
          BlocProvider<TimerBloc>(
            create: (context) => TimerBloc(),
          ),
        ],
        child: ExerciseItemWidget(),
      ),
    );
  }
}

class ExerciseItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ExerciseBloc exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: exerciseBloc.controller,
              readOnly: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final length = int.tryParse(value);
                if (length != null) {
                  exerciseBloc.add(AddItemEvent(length));
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              height: 143,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.lightGray),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppTextWidget(txtTitle: 'Repetition Exercise'),
                  Flexible(
                    child: BlocBuilder<ExerciseBloc, ExerciseState>(
                      builder: (context, state) {
                        if (state is UpdatedListState) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                            ),
                            itemCount: exerciseBloc.items.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ExerciseNumberWidget(
                                number:
                                    int.parse(exerciseBloc.items[index].name!) +
                                        1,
                                time: timerBloc.remainingSeconds,
                                inteval: exerciseBloc.interval,
                                isCompleted:
                                    exerciseBloc.items[index].isCompleted,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child:
                                CircularProgressIndicator(), // Show loading indicator if needed
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Image.asset(
              AppAssets.exerciseImg, // Replace with your image path
            ),
            SizedBox(
              height: 12,
            ),
            AppTextWidget(
              txtTitle: 'Sit ups',
              fontSize: 20,
              txtColor: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                TextIconWidget(Icons.alarm, AppColors.primary, 'Total Time',
                    '1 min', AppColors.primary.withOpacity(0.1)),
                SizedBox(
                  width: 40,
                ),
                TextIconWidget(
                    Icons.category,
                    AppColors.primary,
                    'Total calories',
                    '100 kcal',
                    AppColors.secondary.withOpacity(0.1))
              ],
            ),
            SizedBox(
              height: 12,
            ),
            descriptionWidget(),
            SizedBox(
              height: 30,
            ),
            BlocBuilder<TimerBloc, TimerState>(
              builder: (context, state) {
                if (state is TimerRunningState || state is TimerInitialState) {
                  final bool isRunning = state is TimerRunningState;
                  final int elapsedSeconds = isRunning
                      ? (state as TimerRunningState).elapsedSeconds
                      : 0;

                  exerciseBloc.time = int.parse(exerciseBloc.controller.text);
                  timerBloc.remainingSeconds = exerciseBloc.time *
                          BlocProvider.of<TimerBloc>(context).exerciseTime -
                      (state is TimerRunningState
                          ? (state as TimerRunningState).elapsedSeconds
                          : 0);
                timerBloc.redirectToTheScreen(exerciseBloc,context);

                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomPaint(
                          size: Size(120, 120),
                          painter: isRunning
                              ? DottedProgressBar(
                                  totalDuration: exerciseBloc.time *
                                      BlocProvider.of<TimerBloc>(context)
                                          .exerciseTime,
                                  elapsedDuration: elapsedSeconds,
                                  isRunning: isRunning)
                              : CirclePainter(),
                        ),
                        if (isRunning)
                          timerBloc.remainingSeconds == 0
                              ? InkWell(
                                  onTap: () {
                                    BlocProvider.of<TimerBloc>(context).add(
                                        StartTimerEvent(exerciseBloc.time *
                                            BlocProvider.of<TimerBloc>(context)
                                                .exerciseTime));
                                  },
                                  child: Icon(
                                    Icons.play_arrow,
                                    size: 50,
                                    color: AppColors.primary,
                                  ),
                                )
                              : AppTextWidget(
                                  txtTitle:
                                      timerBloc.remainingSeconds.toString())
                        else
                          InkWell(
                            onTap: () {
                              BlocProvider.of<TimerBloc>(context).add(
                                  StartTimerEvent(exerciseBloc.time *
                                      BlocProvider.of<TimerBloc>(context)
                                          .exerciseTime));
                            },
                            child: Icon(
                              Icons.play_arrow,
                              size: 50,
                              color: AppColors.primary,
                            ),
                          ),
                      ],
                    ),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<TimerBloc>(context).add(StartTimerEvent(
                          exerciseBloc.time *
                              BlocProvider.of<TimerBloc>(context)
                                  .exerciseTime));
                    },
                    child: Text('Start'),
                  );
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  descriptionWidget() {
    return AppTextWidget(
        txtColor: AppColors.subTextColor,
        fontSize: 12,
        txtTitle:
            'Follow the rhythm and start burning the fat like never before! Please take a small break after you are done with the exercise!');
  }
}
