import 'package:dartz/dartz.dart';
import 'package:todoist/models/all_comments_model.dart';
import 'package:todoist/models/create_task_model.dart';
import 'package:todoist/models/get_task_model.dart';

abstract class ApiServices {
  Future<Either<String, List<GetTaskModel>>> getAllTasks();
  Future<Either<String, CreateTaskModel>> createTask(String content);
  Future<Either<String, bool>> updateTask(String taskId, String content);

  Future<Either<String, List<AllCommentsModel>>> getAllComments(String taskId);
  Future<Either<String, bool>> createComment(String taskId, String content);
}