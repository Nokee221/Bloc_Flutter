import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/screens/home_screen.dart';
import 'package:flutter_bloc_todo/simple_bloc_observer.dart';

import 'blocks/todo/todo_bloc.dart';
import 'blocks/todo_status/todo_status_bloc.dart';
import 'models/todos_model.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc()
            ..add(
              LoadTodos(
                todos: [
                  Todo(
                    id: '1',
                    task: 'BloC Pattern Video',
                    description: 'Explain what is the BloC Pattern',
                  ),
                  Todo(
                    id: '2',
                    task: 'BloC Pattern Video #2',
                    description: 'Explain what is the BloC Pattern',
                  ),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodoStatusBloc(
           todoBloc: BlocProvider.of<TodoBloc>(context),
          )..add(UpdateTodoStatus()),
        ),
      ],
      child: MaterialApp(
        title: 'BloC Pattern - Todos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: const Color(0xFF000A1F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF000A1F),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
