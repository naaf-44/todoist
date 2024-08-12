part of 'comments_bloc.dart';

enum CommentsStatus { initial, loading, loaded, error }

class CommentsState extends Equatable {
  final CommentsStatus commentsStatus;
  final List<AllCommentsModel> allCommentsModelList;
  final String? error;

  const CommentsState(
      {required this.commentsStatus,
      required this.allCommentsModelList,
      required this.error});

  @override
  List<Object?> get props => [commentsStatus, allCommentsModelList, error];

  factory CommentsState.initial() {
    return const CommentsState(
        commentsStatus: CommentsStatus.initial,
        allCommentsModelList: [],
        error: "");
  }

  CommentsState copyWith(
      {CommentsStatus? commentsStatus,
      List<AllCommentsModel>? allCommentsModelList,
      String? error}) {
    return CommentsState(
        commentsStatus: commentsStatus ?? this.commentsStatus,
        allCommentsModelList: allCommentsModelList ?? this.allCommentsModelList,
        error: error ?? this.error);
  }
}
