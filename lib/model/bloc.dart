import "package:observable/observable.dart";

import './model.dart';

class BlocState {
  AppState appState = AppState();
  // add new
  Stream<List<ChangeRecord>> changes;

  BlocState() {
    changes = appState.categories.changes;
  }
}


BlocState mockedBlocState () {
  BlocState mock = BlocState();

  final mainCategory = TodoCategory("To do");
  mainCategory.todos.add(Todo("Make exercise"));
  mainCategory.todos.add(Todo("Study a lot"));
  mainCategory.todos.add(Todo("Make pancakes"));
  mock.appState.categories.add(mainCategory);

  final familyCategory = TodoCategory("Family Task");
  familyCategory.todos.add(Todo("Visit Grandparents"));
  var cakeTodo = Todo("Make a cake");
  cakeTodo.toggle();
  familyCategory.todos.add(cakeTodo);
  mock.appState.categories.add(familyCategory);

  return mock;
}

