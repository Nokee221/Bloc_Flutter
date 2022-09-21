import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todos_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
  }
  
  void _onLoadTodos(
    LoadTodos event,
    Emitter<TodoState> emit,
  ) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodo(
    AddTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(
        TodoLoaded(
          todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _onDeleteTodo(
    DeleteTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = (state.todos.where((todo) {
        return todo.id != event.todo.id;
      })).toList();

      emit(TodoLoaded(todos: todos));
    }
  }

  void _onUpdateTodo(
    UpdateTodo event,
    Emitter<TodoState> emit,
  ) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = (state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      })).toList();

      emit(TodoLoaded(todos: todos));
    }
  }
}
