import 'package:dartz/dartz.dart';
import 'package:todoist/models/create_task_model.dart';
import 'package:todoist/models/get_task_model.dart';

abstract class ApiServices {
  Future<Either<String, GetTaskModel>> getAllTasks();
  Future<Either<String, CreateTaskModel>> createTask(String content);
}