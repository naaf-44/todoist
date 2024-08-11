import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:todoist/models/create_task_model.dart';
import 'package:todoist/models/get_task_model.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/utils/app_urls.dart';
import 'package:todoist/utils/dio_service.dart';

class ApiServiceImpl implements ApiServices {
  final DioService dioService;

  ApiServiceImpl(this.dioService);

  @override
  Future<Either<String, GetTaskModel>> getAllTasks() async {
    try {
      final response = await DioService.dio.get(AppUrls.tasks);
      print("RESPONSE $response");
      if (response.statusCode == 200) {
        final getTaskModel = GetTaskModel.fromJson(response.data);
        return Right(getTaskModel);
      } else {
        return const Left("No Data Found");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CreateTaskModel>> createTask(String content) async {
    try {
      var params = {"content": content};

      final response = await DioService.dio.post(AppUrls.tasks, data: jsonEncode(params));
      if (response.statusCode == 200) {
        final createTaskModel = CreateTaskModel.fromJson(response.data);
        return Right(createTaskModel);
      } else {
        return const Left("Not able to create the task.");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
