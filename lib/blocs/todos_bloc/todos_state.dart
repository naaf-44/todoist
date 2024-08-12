part of 'todos_bloc.dart';

enum TodoStatus { initial, loading, loaded, error }

class TodosState extends Equatable {
  final TodoStatus todoStatus;
  final List<GetTaskModel> getTaskModelList;
  final String? error;

  const TodosState({required this.todoStatus, required this.getTaskModelList, required this.error});

  @override
  List<Object?> get props => [todoStatus, getTaskModelList, error];

  factory TodosState.initial() {
    return const TodosState(todoStatus: TodoStatus.initial, getTaskModelList: [], error: "");
  }

  TodosState copyWith({TodoStatus? todoStatus, List<GetTaskModel>? getTaskModelList, String? error}) {
    return TodosState(todoStatus: todoStatus ?? this.todoStatus, getTaskModelList: getTaskModelList ?? this.getTaskModelList, error: error ?? this.error);
  }
}
