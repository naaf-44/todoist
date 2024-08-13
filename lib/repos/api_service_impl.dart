import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:todoist/models/all_comments_model.dart';
import 'package:todoist/models/create_task_model.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/utils/app_urls.dart';
import 'package:todoist/utils/dio_service.dart';

class ApiServiceImpl implements ApiServices {
  final DioService dioService;

  ApiServiceImpl(this.dioService);

  @override
  Future<Either<String, List<GetTaskModel>>> getAllTasks() async {
    try {
      final response = await DioService.dio.get(AppUrls.tasks);
      if (response.statusCode == 200) {
        Iterable getAllTaskIterable = response.data;
        List<GetTaskModel> getTaskModelList = List<GetTaskModel>.from(
            getAllTaskIterable.map((model) => GetTaskModel.fromJson(model)));
        return Right(getTaskModelList);
      } else {
        return const Left("No Data Found");
      }
    } catch (e) {
      print("ERROR: $e");
      return const Left(
          "No data found. Please click on Add button to add new task.");
    }
  }

  @override
  Future<Either<String, CreateTaskModel>> createTask(String content) async {
    try {
      var params = {"content": content};

      final response =
          await DioService.dio.post(AppUrls.tasks, data: jsonEncode(params));
      if (response.statusCode == 200) {
        CreateTaskModel createTaskModel =
            CreateTaskModel.fromJson(response.data);
        return Right(createTaskModel);
      } else {
        return const Left("Not able to create the task.");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> updateTask(String taskId, String content) async {
    try {
      var params = {"content": content};

      final response = await DioService.dio
          .post("${AppUrls.tasks}/$taskId", data: jsonEncode(params));
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return const Left("Couldn't update the task.");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<AllCommentsModel>>> getAllComments(
      String taskId) async {
    try {
      final response =
          await DioService.dio.get("${AppUrls.comment}?task_id=$taskId");
      if (response.statusCode == 200) {
        Iterable getAllCommentsIterable = response.data;
        List<AllCommentsModel> getAllCommentsModelList =
            List<AllCommentsModel>.from(getAllCommentsIterable
                .map((model) => AllCommentsModel.fromJson(model)));
        return Right(getAllCommentsModelList);
      } else {
        return const Left("No Data Found");
      }
    } catch (e) {
      return const Left(
          "No data found. Please click on Add button to add new comment.");
    }
  }

  @override
  Future<Either<String, bool>> createComment(
      String taskId, String content) async {
    try {
      var params = {"content": content, "task_id": taskId};

      final response =
          await DioService.dio.post(AppUrls.comment, data: jsonEncode(params));
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return const Left("Not able to create the task.");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
