import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:todoist/models/all_comments_model.dart';
import 'package:todoist/repos/api_service.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  ApiServices apiServices;

  CommentsBloc(this.apiServices) : super(CommentsState.initial()) {
    on<CommentsEvent>((event, emit) {});

    on<GetAllCommentsEvent>((event, emit) async {
      emit(state.copyWith(commentsStatus: CommentsStatus.loading));
      try {

        if (event.content.isNotEmpty && event.taskId.isNotEmpty) {
          await apiServices.createComment(event.taskId, event.content);
        }

        Either<String, List<AllCommentsModel>> result =
            await apiServices.getAllComments(event.taskId);
        result.fold((errorMessage) {
          emit(state.copyWith(
              commentsStatus: CommentsStatus.error, error: errorMessage));
        }, (data) {
          emit(state.copyWith(
              commentsStatus: CommentsStatus.loaded,
              allCommentsModelList: data));
        });
      } catch (e) {
        print("ERROR: $e}");
        emit(state.copyWith(
            commentsStatus: CommentsStatus.error, error: e.toString()));
      }
    });
  }
}
