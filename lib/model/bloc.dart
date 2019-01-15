import "package:observable/observable.dart";

import './model.dart';

AppState mockedAppState() {
  AppState mock = AppState();

  final mainCategory = TodoCategory("To do");
  mainCategory.todos.add(Todo("Make exercise"));
  mainCategory.todos.add(Todo("Study a lot"));
  mainCategory.todos.add(Todo("Make pancakes"));
  mock.categories.add(mainCategory);

  final familyCategory = TodoCategory("Family Task");
  familyCategory.todos.add(Todo("Visit Grandparents"));
  var cakeTodo = Todo("Make a 🍰");
  cakeTodo.toggle();
  familyCategory.todos.add(cakeTodo);
  mock.categories.add(familyCategory);

  return mock;
}
