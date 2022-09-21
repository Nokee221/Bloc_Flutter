part of 'todo_status_bloc.dart';

abstract class TodoStatusState extends Equatable {
  const TodoStatusState();
  
  @override
  List<Object> get props => [];
}

class TodoStatusLoading extends TodoStatusState {}

class TodoStatusLoaded extends TodoStatusState {
  final List<Todo> pendingTodos;
  final List<Todo> completedTodos;
  final List<Todo> cancelledTodos;

  const TodoStatusLoaded({this.pendingTodos = const<Todo>[], this.completedTodos = const<Todo>[], this.cancelledTodos = const<Todo>[]});

  @override
  List<Object> get props => [
        pendingTodos,
        completedTodos,
        cancelledTodos,
      ];
}
