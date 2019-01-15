import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './model/model.dart';
import './model/bloc.dart';
import './screens/main_screen.dart';

class ToDoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppState>(
      model: mockedAppState(),
      child: MaterialApp(
        title: 'Todo List',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: MainScreen(title: 'Todo List'),
      ),
    );
  }
}

void main() => runApp(ToDoApp());