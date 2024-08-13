import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todoist/models/create_task_model.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/models/hive_model.dart';
import 'package:todoist/repos/api_service.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  ApiServices apiServices;

  TodosBloc(this.apiServices) : super(TodosState.initial()) {
    on<TodosEvent>((event, emit) {});

    on<GetAllTaskEvent>((event, emit) async {
      Box<HiveModel> hiveModelBox = await Hive.openBox("hive_model");

      emit(state.copyWith(todoStatus: TodoStatus.loading));
      try {
        print("CONTENT: ${event.content}");
        if (event.content.isNotEmpty) {
          Either<String, CreateTaskModel> result =
              await apiServices.createTask(event.content);
          result.fold((e) {}, (data) {
            HiveModel hiveModel = HiveModel(
                id: data.id, startDate: data.createdAt, status: "todo");
            hiveModelBox.add(hiveModel);
          });
        }

        Either<String, List<GetTaskModel>> result =
            await apiServices.getAllTasks();
        result.fold((errorMessage) {
          emit(state.copyWith(
              todoStatus: TodoStatus.error, error: errorMessage));
        }, (data) {
          emit(state.copyWith(
              todoStatus: TodoStatus.loaded, getTaskModelList: data));
        });
      } catch (e) {
        print("ERROR: $e}");
        emit(state.copyWith(todoStatus: TodoStatus.error, error: e.toString()));
      }
    });
  }
}
