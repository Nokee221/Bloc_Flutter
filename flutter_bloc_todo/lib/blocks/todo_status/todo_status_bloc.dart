import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_todo/blocks/todo/todo_bloc.dart';

import '../../models/todos_model.dart';

part 'todo_status_event.dart';
part 'todo_status_state.dart';

class TodoStatusBloc extends Bloc<TodoStatusEvent, TodoStatusState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _todosSubscription;

  TodoStatusBloc({required TodoBloc todoBloc})
      : _todoBloc = todoBloc,
        super(TodoStatusLoading()) {
    on<UpdateTodoStatus>(_onUpdateTodosStatus);

    _todosSubscription = _todoBloc.stream.listen((state) {
      if (state is TodoLoaded) {
        add(
          UpdateTodoStatus(todos: state.todos),
        );
      }
    });
  }

  void _onUpdateTodosStatus(
    UpdateTodoStatus event,
    Emitter<TodoStatusState> emit,
  ) {
    List<Todo> pendingTodos = event.todos
        .where((todo) => todo.isCancelled == false && todo.isCompleted == false)
        .toList();
    List<Todo> completedTodos = event.todos
        .where((todo) => todo.isCompleted == true && todo.isCancelled == false)
        .toList();
    List<Todo> cancelledTodos =
        event.todos.where((todo) => todo.isCancelled == false).toList();

    emit(
      TodoStatusLoaded(
        pendingTodos: pendingTodos,
        completedTodos: completedTodos,
        cancelledTodos: cancelledTodos,
      ),
    );
  }
  
  @override
  Future<void> close() {
    _todosSubscription.cancel();
    return super.close();
  }
  
}
