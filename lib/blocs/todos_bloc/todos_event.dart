part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object?> get props => [];
}

class GetAllTaskEvent extends TodosEvent {
  final String content;
  const GetAllTaskEvent({this.content = ""});
  @override
  List<Object?> get props => [content];
}

class UpdateTaskEvent extends TodosEvent{
  final String content;
  final String taskId;

  const UpdateTaskEvent({this.content = "", this.taskId = ""});

  @override
  List<Object?> get props => [content, taskId];
}
