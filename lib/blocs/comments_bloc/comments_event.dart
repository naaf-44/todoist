part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCommentsEvent extends CommentsEvent {
  final String taskId;
  final String content;
  const GetAllCommentsEvent({this.taskId = "", this.content = ""});
  @override
  List<Object?> get props => [taskId, content];
}

